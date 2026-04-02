library(BactDating)
library(ggplot2)
library(ggtree)
library(dplyr)
library(ape)
library(phangorn)
library(phylogram)
library(dendextend)

get_colours <- function(categories, seed_cols=c("#0571B0", "#FFBF00", "#CA0020")){
    set.seed(1)
    if(length(unique(categories)) > 3) {
        colours <- setNames(
            Polychrome::createPalette(length(unique(categories)), seedcolors=seed_cols),
            sort(unique(categories))
        )
    } else {
        colours <- setNames(palette()[1:length(unique(categories))],
                            sort(unique(categories)))
    }
    return(colours)
}

# modified BactDating roottotip function
my_roottotip <- function(tree, date, rate=NA, permTest=10000, showFig=T, 
                         colored=T, showPredInt="gamma", showText=T, showTree=T){
    tree = ape::rtt(tree, date) # MOD. best-fit-root the tree
    if (!is.rooted(tree)) 
        warning("Warning: roottotip was called on an unrooted input tree. Consider using initRoot first.\n")
    if (sum(tree$edge.length) < 5) 
        warning("Warning: input tree has small branch lengths. Make sure branch lengths are in number of substitutions (NOT per site).\n")
    if (!is.null(names(date))) 
        date = BactDating:::findDates(tree, date)
    if (var(date, na.rm = T) == 0 && is.na(rate)) {
        warning("Warning: All dates are identical.\n")
        return(list(rate = NA, ori = NA, pvalue = NA))
    }
    n = length(date)
    ys = BactDating:::leafDates(tree)
    if (is.na(rate)) { res = lm(ys ~ date) }
    else { 
        res = lm(I(ys - rate * date) ~ 1)
        res$coefficients = c(res$coefficients, rate)
    }
    ori = -coef(res)[1]/coef(res)[2]
    rate = coef(res)[2]
    r2 = summary(res)$r.squared
    correl = cor(date, ys, use = "complete.obs")
    pvalue = 0
    for (i in 1:permTest) {
        date2 = sample(date, n, replace = F)
        correl2 = cor(date2, ys, use = "complete.obs")
        if (correl2 >= correl) { pvalue = pvalue + 1/permTest }
    }
    if (rate < 0) { warning("The linear regression suggests a negative rate.") }
    if (showFig == F) return(list(rate = rate, ori = ori, pvalue = pvalue, r2 = round(r2,2)))
    old.par = par(no.readonly = T)
    par(xpd = NA, mar = c(1,0,1,1), oma = c(1, 0, 1, 1)) # MOD.
    if (colored) {
        normed = (date - min(date, na.rm = T))/(max(date, na.rm = T) - min(date, na.rm = T))
        cols = grDevices::rgb(ifelse(is.na(normed), 0, normed), 
                              ifelse(is.na(normed), 0.5, 0), 
                              1 - ifelse(is.na(normed), 1, normed), 0.5)
    }
    else cols = "black"
    if (showTree) {
        par(mfrow = c(1, 2))
        plot(tree, show.tip.label = F)
        if (colored) 
            tiplabels(col = cols, pch = 19)
        axisPhylo(1, backward = F)
    }
    par(mar = c(1,3,1,1)) # MOD.
    plot(date, ys, col = cols,
         xlab = ifelse(showText, "Sampling date", ""), 
         ylab = ifelse(showText, "Root-to-tip distance", ""), 
         xaxs = "i", yaxs = "i", pch = 19, ylim = c(0, max(ys)), 
         xlim = c(ifelse(rate > 0, ori, min(date, na.rm = T)), 
                  max(date, na.rm = T)))
    par(xpd = F)
    abline(res, lwd = 2)
    if (rate < 0) {
        par(old.par)
        return(list(rate = rate, ori = ori, pvalue = pvalue))
    }
    xs = seq(ori, max(date, na.rm = T), 0.1)
    plim = 0.05
    if (showPredInt == "poisson") {
        lines(xs, qpois(plim/2, (xs - ori) * rate), lty = "dashed")
        lines(xs, qpois(1 - plim/2, (xs - ori) * rate), lty = "dashed")
    }
    if (showPredInt == "gamma") {
        lines(xs, qgamma(plim/2, shape = (xs - ori) * rate, scale = 1), lty = "dashed")
        lines(xs, qgamma(1 - plim/2, shape = (xs - ori) * rate, 
                         scale = 1), lty = "dashed")
    }
    if (showText) {
        mtext(do.call(expression, 
                      list(bquote(paste("R" ^ "2", " = ", .(round(r2,2)))))),
              cex=1, outer=FALSE, adj = 0)
    }
    par(old.par)
    return(list(rate = rate, ori = ori, pvalue = pvalue, r2 = round(r2,2)))
}

get_matching_nodes_in_tree <- function(tree, tree_nodes, other_tree){
    matched_nodes <- purrr::map_dfr(tree_nodes, function(x) {
        # 'x' is the internal node index from the input 'tree_nodes'
        absolute_node_in_tree <- ape::Ntip(tree) + x
        # Extract tips for that node in the original tree
        subtree_tips <- ape::extract.clade(tree, node = absolute_node_in_tree)$tip.label
        # Find MRCA in the other tree 
        matching_node_abs <- tidytree::MRCA(other_tree, subtree_tips)
        matching_node_int <- matching_node_abs - ape::Ntip(other_tree)
        tibble::tibble(node_in_first_tree = x,
                       node_in_other_tree = matching_node_abs)
    })
    return(matched_nodes)
}

get_group_mrca <- function(tree, df, group_column, tip_column){
    df %<>% rename(my_group_col := group_column,
                  my_tip_lab_col := tip_column) %>% 
        filter(!is.na(my_group_col))
    grps <- unique(df$my_group_col)
    group_mrca <- purrr::map_dfr(grps, function(x) { # 'x' is each unique group
        tips <- df %>% filter(my_group_col == x) %>% pull(my_tip_lab_col)
        grp_mrca <- tidytree::MRCA(tree, tips)
        tibble::tibble(Group = x, Node = grp_mrca)})
    return(group_mrca)
}

merge_overlapping_genome_ranges <- function(df, group_col, start_col, end_col){
    # only overlaps within the same group (in `group_col`) are merged
    stopifnot(all(c(group_col, start_col, end_col) %in% names(df)))
    # convert to gr obj
    gr <- GenomicRanges::makeGRangesFromDataFrame(
        df, seqnames.field = group_col, start.field = start_col, end.field = end_col, 
        keep.extra.columns = T, ignore.strand = T, starts.in.df.are.0based = T)
    # merge ranges and convert to df
    merged_gr <- GenomicRanges::reduce(gr, with.revmap = TRUE)
    merged_df <- as.data.frame(merged_gr) %>% as_tibble() %>% 
        mutate(n_merged_ranges = sapply(revmap, length)) %>% # how many ranges merged  
        mutate(merged_size = width) %>% 
        rename(!!sym(group_col) := seqnames,
               !!sym(start_col) := start,
               !!sym(end_col) := end) %>% 
        select(all_of(c(group_col, start_col, end_col)), n_merged_ranges, merged_size, revmap)
    return(merged_df)
}

# Plot recombination map
plot_rec_map <- function(tree, recomb_df=NULL, verticall_wf=c("reference", "pairwise"), 
                         show_tips=FALSE, show_legend=FALSE,
                         node_highlight_df=NULL, node_highlight_legend=FALSE,
                         node_highlight_color=NULL, highlight_alpha=0.6, tree_scale=10,
                         plot_annot=NULL, pairwise_color_mode=c("n_pairs", "opacity")){
    verticall_wf <-  match.arg(verticall_wf)
    pairwise_color_mode <-  match.arg(pairwise_color_mode)
    stopifnot(inherits(tree, "phylo"))
    
    # Plot tree
    p_tree <- ggtree(tree, ladderize = F) + theme_void() + 
        theme(axis.text.x = element_blank(), axis.title.x = element_blank(),
              axis.ticks.x = element_blank(), panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(), plot.title = element_text(hjust = 0.5)) +
        # add annot to tree if no recombination plot
        { if (! is.null(plot_annot) & is.null(recomb_df) ) { list(
            labs(subtitle = plot_annot),
            theme(plot.subtitle = element_text(hjust=0.15, size=10, margin=margin(t=15))))}
        } +
        { if (show_tips) geom_tiplab(size = 1.5) }
    
    # Highlight clades
    if (! is.null(node_highlight_df) ){
        if (is.null(node_highlight_color)) {
            node_highlight_color <- unname(Polychrome::glasbey.colors(n=25)[-1])
        }
        names(node_highlight_df) <- c("Node_name", "Node")
        p_tree <- p_tree + 
            geom_hilight(data=node_highlight_df, 
                         mapping=aes(node=Node, fill=as.factor(Node_name)), 
                         alpha=highlight_alpha) +
            labs(fill = NULL) + 
            scale_fill_manual(values = node_highlight_color) +
            theme(legend.text=element_text(size=10, margin=margin(0,0,0,0)),
                  legend.key.size = unit(3,"mm"), legend.key.spacing.x = unit(3,"mm")) +
            { if (! node_highlight_legend) { guides(fill="none") } }
    }
    
    # Plot tree scale (ensures top layer)
    p_tree <- p_tree +
        geom_treescale(x=0.1, y=ape::Ntip(tree)/2, offset=2, width=tree_scale)
    
    if(is.null(recomb_df)) { return(p_tree) } # return only tree if no rec df supplied
    
    # Plot recombinations 
    stopifnot(all(c("Node", "Beg", "End") %in% names(recomb_df)))
    rec <- recomb_df
    
    # Re-order recombination data to match tree plot order
    tree_data <- p_tree$data
    rec %<>% 
        mutate(Node = factor(Node, levels = tree_data$label[order(tree_data$y)])) %>% 
        mutate(across(c(Beg, End), \(x) x/1000000)) # rescale to MB
    # Plot recomb blocks (right)
    p_rec <- ggplot(rec, aes(y = Node, xmin = Beg, xmax = End)) +
        scale_y_discrete(breaks = levels(rec$Node),
                         labels = as.character(levels(rec$Node))) +
        labs(x = "Genome position (Mb)", y = "") +
        theme_bw()
    if(verticall_wf == "reference"){
        stopifnot(all(c("Branch") %in% names(recomb_df)))
        p_rec <- p_rec + 
            geom_linerange(aes(color=Branch), linewidth=1.2, alpha=.95) +
            scale_color_manual(values = c("Internal"="red", "Terminal"="blue"), 
                               na.translate=F, na.value = "black")
    } else if (verticall_wf == "pairwise"){
        if (pairwise_color_mode == "n_pairs") {
            stopifnot(all(c("Pairs") %in% names(recomb_df)))
            p_rec <- p_rec +
                geom_linerange(aes(color=Pairs), size=1, alpha=1) +
                # scale_color_gradient2(low="blue", mid="yellow", high="red",
                scale_color_gradient2(low="#F0F0F0", mid="#252525", high="#000000",
                                      midpoint = Ntip(tree)/2, name = "No. of pairs",
                                      limits = c(1,length(tree$tip.label))) +
                theme(legend.key.width = unit(0.07, 'npc'))
        } else {
            # p_rec <- p_rec + geom_linerange(color="#EF3B2C", size=1, alpha=.2)
            p_rec <- p_rec + geom_linerange(color="black", size=1, alpha=.1)
        }
    }
    p_rec <- p_rec + 
        theme(axis.title.y = element_blank(), axis.text.y = element_blank(),
              axis.text=element_text(size=12), axis.title.x=element_text(size=12),
              legend.text=element_text(size=12), legend.title=element_text(size=12),
              axis.ticks.y = element_blank(), plot.title = element_text(hjust=0),
              panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
              legend.box.margin=margin(0,0,0,0), legend.box.spacing = unit(0, "pt")) +
        { if (! is.null(plot_annot) ) { list(
            labs(title = plot_annot),
            theme(plot.title = element_text(size=10, margin = margin(b=0))))}
        } +
        { if (show_tips) theme(axis.text.y = element_text(size=4)) } +
        coord_cartesian(xlim = c(0, ceiling(max(rec$End, na.rm=T) * 2) / 2))

    # Combine plots
    p <- ggarrange(p_tree, p_rec, align = "h", widths = c(0.35, 0.65), 
                   legend = if_else(show_legend, "bottom", "none"))
    # return(list(p_tree, p_rec))
    return(p)
}

# Plot gubbins recombination map
parse_gubbins_rec <- function(gubbins_path_and_prefix, alt_tree_for_plot=NULL, show_tips=F, 
                             show_legend=T, node_highlight_df=NULL, node_highlight_legend=F,
                             node_highlight_color=NULL, tree_scale=10, plot_annot=NULL){
    gubbins_tree_file <- paste0(gubbins_path_and_prefix, ".final_tree.tre")
    gubbins_gff_file <- paste0(gubbins_path_and_prefix, ".recombination_predictions.gff")
    # Set tree to plot
    tree <- read.tree(gubbins_tree_file)
    if(!is.null(alt_tree_for_plot)){
        if(inherits(alt_tree_for_plot, "phylo")){
            if(all(sort(alt_tree_for_plot$tip.label) == sort(tree$tip.label))){
                tree <- alt_tree_for_plot
            } else { warning("Ignoring `alt_tree_for_plot` as does not contain same tips as gubbins tree") }
        } else { warning("Ignoring `alt_tree_for_plot` as it's not a phylo object") }
    } 
    # load gubbins data
    gub <- RCandy::load.gubbins.GFF(gubbins_gff_file)
    rec <- gub %>% mutate(Branch = if_else(length(gene)>1, "Internal", "Terminal")) %>% 
        tidyr::unnest(gene) %>% 
        ungroup() %>% select(Node = gene, Beg = START, End = END, Branch)
    # add in rows for any tips without recomb (terminal or internal)
    rec <- data.frame(Node=tree$tip.label) %>% as_tibble() %>% 
        left_join(rec, by = c("Node")) %>% 
        mutate(blockSize = End - Beg)
    # Plot
    p <- plot_rec_map(tree, rec, show_tips=show_tips, show_legend=show_legend,
                      node_highlight_df=node_highlight_df, 
                      node_highlight_legend=node_highlight_legend,
                      node_highlight_color=node_highlight_color, 
                      tree_scale=tree_scale, plot_annot=plot_annot)
    return(list(rec_plot = p, rec = rec))
}

# Plot clonalframeml recombination map
parse_cfml_rec <- function(cfml_path_and_prefix, alt_tree_for_plot=NULL, show_tips=F, 
                          show_legend=T, node_highlight_df=NULL, node_highlight_legend=F,
                          node_highlight_color=NULL, tree_scale=10, plot_annot=NULL) {
    prefix = cfml_path_and_prefix
    cfml_treefile <- paste(prefix, ".labelled_tree.newick", sep = "")
    istatefile <- paste(prefix, ".importation_status.txt", sep = "")
    tree <- read.tree(cfml_treefile)
    all_rec <- read.table(istatefile, h = TRUE, as.is = TRUE, sep = "\t") %>% 
        mutate(Branch = if_else(Node %in% tree$tip.label, "Terminal", "Internal"))
    
    # Apply recombination blocks detected in internal (non-terminal) nodes to all descendants
    int_nodes <- all_rec %>% filter(!Node %in% tree$tip.label) %>% pull(Node) %>% unique()
    desc_rec <- map_dfr(int_nodes, function(node_lab) {
        # Get descendant tip labels for the node
        node_idx <- which(tree$node.label == node_lab) + Ntip(tree)
        desc_idx <- phangorn::Descendants(tree, node_idx, type = "tips")
        desc_lab <- tree$tip.label[unlist(desc_idx)]
        # Get recomb data for the node and project to descendants
        node_rec <- all_rec %>% filter(Node == node_lab)
        desc_rec <- map_dfr(1:nrow(node_rec), function(i) {
            tibble(Node = desc_lab, Beg = rep(node_rec$Beg[i], length(desc_lab)),
                   End = rep(node_rec$End[i], length(desc_lab)),
                   Branch = rep(node_rec$Branch[i], length(desc_lab)))
        })
        return(desc_rec)
    })
    # final rec with only tips and internal/terminal bracnh recombination
    rec <- all_rec %>% 
        filter(Node %in% tree$tip.label) %>% # tips (terminal branches) with recombination
        bind_rows(desc_rec) # tips with ancenstral recombination added
    # add in rows for any tips without recomb (terminal or internal)
    rec <- data.frame(Node=tree$tip.label) %>% as_tibble() %>% 
        left_join(rec, by = c("Node")) %>% 
        mutate(blockSize = End - Beg)
    
    # Set tree to plot
    if(!is.null(alt_tree_for_plot)){
        if(inherits(alt_tree_for_plot, "phylo")){
            if(all(sort(alt_tree_for_plot$tip.label) == sort(tree$tip.label))){
                tree <- alt_tree_for_plot
            } else { warning("Ignoring `alt_tree_for_plot` as does not contain same tips as CFML tree") }
        } else { warning("Ignoring `alt_tree_for_plot` as it's not a phylo object") }
    } 
    
    # Plot
    p <- plot_rec_map(tree, rec, show_tips=show_tips, show_legend=show_legend,
                      node_highlight_df=node_highlight_df,
                      node_highlight_legend=node_highlight_legend,
                      node_highlight_color=node_highlight_color, 
                      tree_scale=tree_scale, plot_annot=plot_annot)
    return(list(rec_plot = p, rec = rec))
}

# Plot verticall ref recombination map
parse_verticall_ref_rec <- function(vert_tsv_file, vert_tree, show_tips=F, show_legend=T,
                                   node_highlight_df=NULL, node_highlight_legend=F,
                                   node_highlight_color=NULL, tree_scale=10, plot_annot=NULL){
    vert_tsv <- read_tsv(vert_tsv_file, show_col_types = F)
    rec <- vert_tsv %>% 
        filter(result_level %in% c("primary")) %>% 
        select(assembly_a, assembly_b, assembly_a_horizontal_regions) %>% 
        separate_longer_delim(cols = assembly_a_horizontal_regions, delim = ",") %>% 
        filter(!is.na(assembly_a_horizontal_regions)) %>% 
        separate_wider_regex(
            assembly_a_horizontal_regions, patterns = c(".*:", Beg = "[[:alnum:]]+", "-", End = "[[:alnum:]]+$"),
            too_few = "align_start", cols_remove = F) %>% 
        select(Node = assembly_b, Beg, End) %>% 
        mutate(across(c(Beg, End), as.numeric)) %>% 
        mutate(blockSize = End - Beg) %>% 
        mutate(Branch = NA_character_)
    tree <- drop.tip(vert_tree, "Reference")
    # add in rows for any tips without recomb (terminal or internal)
    rec <- data.frame(Node=tree$tip.label) %>% as_tibble() %>% 
        left_join(rec, by = c("Node"))
    # Plot
    p <- plot_rec_map(tree, rec, show_tips=show_tips, show_legend=show_legend,
                      node_highlight_df=node_highlight_df,
                      node_highlight_legend=node_highlight_legend,
                      node_highlight_color=node_highlight_color, 
                      tree_scale=tree_scale, plot_annot=plot_annot)
    
    return(list(rec_plot = p, rec = rec))
}

parse_verticall_pairwise_rec <- function(verticall_pw_tsv_df, ref_pos_to_contig_pos_df){
    # reference coordinates relative to sample contigs - make long
    coords_map <- ref_pos_to_contig_pos_df %>% 
        separate_longer_delim(alignment_coordinates, ";") %>% 
        separate_wider_regex(
            alignment_coordinates, 
            patterns = c(
                "[[:alnum:]]+:", 
                alnRefStart = "[0-9]+", # ref start pos relative to aligned contig
                "-", 
                alnRefEnd = "[0-9]+", # ref end pos relative to aligned contig
                "\\(", strand = "[-+]", "\\), ", alnContigName = "[0-9]+", 
                ":", 
                alnContigStart = "[0-9]+", # contig start pos relative to ref
                "-",
                alnContigEnd = "[0-9]+", # contig end pos relative to ref
                " \\(", ident = "[0-9]+.[0-9]+", "%\\) ", matches="[0-9]+$"), 
            too_few = "align_start", cols_remove = TRUE) %>% 
        mutate(across(c(alnRefStart, alnRefEnd, alnContigStart, alnContigEnd, ident, matches), 
                      \(x) as.numeric(x))) %>% 
        select(-assembly_a) %>% rename("sample" = "assembly_b") 
    
    # recombination blocks all samples - make long
    rec_blocks <- verticall_pw_tsv_df %>% 
        filter(result_level == "primary") %>% 
        # Every sample appears as assembly_a against all other samples 
        # So use each sample in 'assembly_a' col as pseudo-reference
        # and get all its rec blocks relative to all other samples
        select(Genome = assembly_a, assembly_b, assembly_a_horizontal_regions) %>% 
        separate_longer_delim(cols = assembly_a_horizontal_regions, delim = ",") %>% 
        separate_wider_regex(
            assembly_a_horizontal_regions, 
            patterns = c(blockContig="[0-9]+", ":", blockStart="[0-9]+", "-", 
                         blockEnd="[0-9]+"),
            cols_remove = T) %>% 
        mutate(across(c(blockStart, blockEnd), \(x) as.numeric(x))) %>%
        mutate(blockSize = blockEnd - blockStart + 1) %>% 
        # remove pairs without horizontal regions
        filter(!is.na(blockContig))
    
    rec_blocks_merged <- get_merged_pairwise_blocks(rec_blocks, genome_column="Genome")

    # Translate recomb block positions in each sample to reference positions
    # One sample at a time with furrr cos dfs are large and fuzzyjoin is not mem efficient
    samples <- unique(coords_map$sample)
    rec <- furrr::future_map_dfr(samples, ~{
        # join blocks df to ref coordinates df if 
        # (1) contig names match 
        # (2) block is within any reference-aligned contig region 
        rec_blocks_merged %>% filter(Genome == .x) %>% 
            fuzzyjoin::fuzzy_left_join(
                coords_map %>% filter(sample == .x),
                # Modify to account for overlaps. If the block region overlaps 
                # the alignment region, should still be able to deduce block pos
                by = c(
                    "blockContig" = "alnContigName",         
                    "blockStart" = "alnContigStart",
                    "blockEnd" = "alnContigEnd"),
                match_fun = list(`==`, `>=`, `<=`)) %>%
            # translate block positions to ref pos
            mutate(offset = blockStart - alnContigStart) %>% 
            mutate(pos1 = case_when(
                strand == "+" ~ alnRefStart + offset,
                strand == "-" ~ alnRefEnd - offset,
                TRUE ~ NA_real_)) %>% 
            mutate(pos2 = case_when(
                strand == "+" ~ pos1 + blockSize -1,
                strand == "-" ~ pos1 - blockSize +1,
                TRUE ~ NA_real_)) %>%
            # ensure positions never exceeds reference boundary
            # can happen cos this extrapolated position approach doesnt account for indels
            mutate(pos1_clamped = pmax(pmin(pos1, alnRefEnd), alnRefStart)) %>% 
            mutate(pos2_clamped = pmax(pmin(pos2, alnRefEnd), alnRefStart)) %>%
            mutate(border = if_else(pos1 != pos1_clamped | pos2 != pos2_clamped,
                                     "Truncated", "Real")) %>% 
            # translate
            mutate(refBasedBlockStart = pmin(pos1_clamped, pos2_clamped),
                   refBasedBlockEnd = pmax(pos1_clamped, pos2_clamped)) %>% 
            arrange(Genome, blockContig, blockStart) %>% 
            select(Node=Genome, 
                   # blocks
                   blockContig, blockStart, blockEnd, blockSize, Pairs, n_merged_ranges,
                   # translated
                   Beg=refBasedBlockStart, End=refBasedBlockEnd, border,
                   # alignment
                   alnContigName, alnContigStart, alnContigEnd, alnRefStart, alnRefEnd,
                   strand, ident, matches)
    })
    
    # sanity
    refSize <-  max(coords_map$alnRefEnd)
    clean_rec <- rec %>% filter(!is.na(alnRefStart))
    if (any(clean_rec$End > refSize, clean_rec$Beg < 0)) {
        stop("Recombination block positions must be within reference genome regions")
    }
    
    return(list(all_rec=rec_blocks, merged_rec=rec))
    # return(rec)
}

get_merged_pairwise_blocks <- function(rec, genome_column="Genome"){
    # Merge overlapping recombinations blocks
    df <- rec %>%
        mutate(uniqueGenomeContig = paste0(!!sym(genome_column), "_-_", blockContig)) %>% 
        select(!!sym(genome_column), assembly_b, blockStart, blockEnd, uniqueGenomeContig)
    merged_blocks <- 
        merge_overlapping_genome_ranges(df, group_col="uniqueGenomeContig", 
                                        start_col = "blockStart", end_col = "blockEnd") %>% 
        separate(uniqueGenomeContig, into = c(genome_column, "blockContig"), sep = "_-_") %>% 
        # count number of pairs for each merged range, based on revmap col
        mutate(Pairs = map_int(revmap, ~length(unique(df$assembly_b[.x])))) %>% 
        select(!!sym(genome_column), blockContig, blockStart, blockEnd, 
               blockSize = merged_size, Pairs, n_merged_ranges) 
    return(merged_blocks)
}


plot_verticall_pw_map <- function(recomb_df, vert_pw_tree, show_tips=F, show_legend=T, 
                                  plot_color_mode=c("n_pairs", "opacity"),
                                  min_pairs_per_block=1, node_highlight_df=NULL,
                                  node_highlight_legend=F, node_highlight_color=NULL, 
                                  tree_scale=10, plot_annot=NULL){
    plot_color_mode <- match.arg(plot_color_mode)
    # use `n_pairs` for plotting distinct recs after merging
    if (plot_color_mode == "n_pairs") {
        rec <- recomb_df %>% 
            arrange(Pairs, desc(blockSize)) %>% 
            filter(Pairs >= min_pairs_per_block)
    } 
    # use `opacity` for plotting all recs without merging
    # still need to translate to ref positions and rename cols before passing to this fnx
    else if (plot_color_mode == "opacity") { 
        rec <- recomb_df
    }
    # add in rows for any samples without recombination
    rec <- data.frame(Node=vert_pw_tree$tip.label) %>% as_tibble() %>% 
        left_join(rec, by = c("Node")) %>% 
        filter(!is.na(Beg)) # remove blocks outside reference-aligned regions

    plot_rec_map(vert_pw_tree, rec, show_tips=show_tips, verticall_wf="pairwise", 
                 show_legend=show_legend, node_highlight_df=node_highlight_df,
                 node_highlight_legend=node_highlight_legend,
                 node_highlight_color=node_highlight_color, 
                 tree_scale=tree_scale, plot_annot=plot_annot,
                 pairwise_color_mode = plot_color_mode)
}

summarise_recs <- function(rec){
    rec %>% reframe(md = median(blockSize, na.rm=T),
                           low = quantile(blockSize, 0.25, na.rm=T),
                           upp = quantile(blockSize, 0.75, na.rm=T),
                           rng = paste0(range(blockSize, na.rm=T), collapse="-")) %>% 
        mutate(blockSize = sprintf('%.0f [IQR: %.0f-%.0f, range: %s]', md, low, upp, rng)) %>% 
        select(blockSize) %>% 
        bind_cols(
            rec %>% 
                group_by(Node) %>% reframe(blocks = sum(!is.na(blockSize))) %>% 
                reframe(
                    total = sum(blocks),
                    md = median(blocks, na.rm=T),
                    low = quantile(blocks, 0.25, na.rm=T),
                    upp = quantile(blocks, 0.75, na.rm=T),
                    rng = paste0(range(blocks, na.rm=T), collapse="-")) %>% 
                mutate(blocks = sprintf('%.0f [IQR: %.0f-%.0f, range: %s]', md, low, upp, rng)) %>% 
                select(blocks, total)
        )
}


make_tanglegram <- function(tree1, tree2, title1="tree1", title2="tree2", untangle=F,
                            color_by_var=F, color_df=NULL, id_column=NULL, 
                            color_column=NULL, named_var_colors=NULL, color_branches=F, color_labels=F,
                            line_color=NULL, # if ! NULL, overrides all color args
                            edge.lwd = 1, lwd = .7, lab.cex = 0.0001, cex_main = 2){
    stopifnot("tree1 and tree2 must have the same tip labels" = setequal(tree1$tip.label, tree2$tip.label))
    
    # Bifurcate and convert to dendrograms
    tree1 <- ape::multi2di(tree1)
    tree2 <- ape::multi2di(tree2)
    dend1 <- phylogram::as.dendrogram.phylo(tree1)
    dend2 <- phylogram::as.dendrogram.phylo(tree2)
    dl <- dendextend::dendlist(dend1, dend2)
    
    # Get colors
    if(!is.null(line_color)){
        ids_to_col_map <- setNames(rep(line_color, length(tree1$tip.label)), tree1$tip.label)
    } else if(color_by_var){ # color lines by specified group in color_df
        stopifnot(
            "color_df must be provided when color_by_var is TRUE" = !is.null(color_df),
            "id_column must not be NULL when color_by_var is TRUE" = !is.null(id_column),
            "color_column must not be NULL when color_by_var is TRUE" = !is.null(color_column)
        )
        stopifnot(
            "id_column not found in color_df"    = id_column %in% names(color_df),
            "color_column not found in color_df" = color_column %in% names(color_df)
        )
        t_miss <- setdiff(tree1$tip.label, color_df[[id_column]])
        stopifnot("All tip labels must be present in id_column" = length(t_miss) == 0)
        
        # set colors
        unique_grps <- unique(color_df[[color_column]])
        if (!is.null(named_var_colors) & all(unique_grps %in% names(named_var_colors))) {
            grp_colors <- named_var_colors
        } else {
            grp_colors <- get_colours(unique_grps, RColorBrewer::brewer.pal(n=10, "Paired")) 
        }
        color_df$colors <- grp_colors[color_df[[color_column]]]
        ids_to_col_map <- color_df %>% select(c(!!sym(id_column), colors)) %>% deframe()
    } else { # Color lines by clusters
        cluster_cut_h <- 4e-4   # cluster threshold (applied to dend2 height)
        cl_vec <- cutree(dend1, h = cluster_cut_h) # named vector (labels -> cluster id)
        n_clusters <- length(unique(cl_vec))
        clus_levels <- sort(unique(cl_vec))
        pal <- viridisLite::viridis(n_clusters)
        clus2col <- setNames(pal, clus_levels)
        # Map colors to ids
        color_df <- data.frame(
            label = names(cl_vec), cluster = as.integer(cl_vec),
            color = clus2col[as.character(cl_vec)], stringsAsFactors = FALSE)
        ids_to_col_map <- setNames(color_df$color, color_df$label)
        if (anyNA(ids_to_col_map)) ids_to_col_map[is.na(ids_to_col_map)] <- "grey70"
    }
    
    # Untangle to best match labels (step2side is robust). Could take days for large trees
    if(untangle){ 
        cat("Untangling (step2side)...\n")
        dl <- dendextend::untangle(dl, method = "step2side")
        dend1 <- dl[[1]]
        dend2 <- dl[[2]]
    }
    
    ordered_labels_1 <- labels(dend1)
    ordered_labels_2 <- labels(dend2)
    
    # Make named color vector match dend1 order
    line_colors <- ids_to_col_map[ordered_labels_1]
    
    if (color_branches) {
        dend1 <- dend1 %>% color_branches(col = ids_to_col_map[ordered_labels_1],
                                          labels = ordered_labels_1)
        dend2 <- dend2 %>% color_branches(col = ids_to_col_map[ordered_labels_2],
                                          labels = ordered_labels_2)}
    if (color_labels) {
        dend1 <- dend1 %>% color_labels(col = ids_to_col_map[ordered_labels_1],
                                        labels = ordered_labels_1)
        dend2 <- dend2 %>% color_labels(col = ids_to_col_map[ordered_labels_2],
                                        labels = ordered_labels_2)}
    
    # Plot
    tanglegram(
        dend1, dend2,
        color_lines = line_colors, common_subtrees_color_lines = FALSE,
        highlight_distinct_edges = FALSE,
        edge.lwd = edge.lwd, lwd = lwd, lab.cex = lab.cex, cex_main = cex_main, 
        margin_inner = 0.8, sub = "", hang=T, match_order_by_labels = TRUE,
        main_left = title1, main_right = title2
    )
}

get_glm_df <- function(model){ 
    summary(model)$coefficients[-1,] %>% 
        as_tibble(rownames = "Predictor") %>% 
        rename(P = `Pr(>|z|)`, StdErr = `Std. Error`) %>% 
        mutate(OR = round(exp(Estimate), 2),
               lower = round(exp(Estimate - (1.96 * StdErr)), 2),
               upper = round(exp(Estimate + (1.96 * StdErr)), 2)) %>% 
        select(Predictor, Estimate, StdErr, OR, lower, upper, P)
}
