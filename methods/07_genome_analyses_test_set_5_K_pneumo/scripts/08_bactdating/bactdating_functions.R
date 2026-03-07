library(tidyverse)
library(BactDating)
library(ape)
library(phangorn)

prepare_bactdate_data <- function(metadata, gubbins_dir=NULL, verticall_dir=NULL) {
    if (is.null(gubbins_dir) & is.null(verticall_dir)){
        stop("Must specify one of `gubbins_dir` or `verticall_dir`")
    }
    if (!is.null(gubbins_dir) & !is.null(verticall_dir)) {
        stop("Cannot specify both `gubbins_dir` and `verticall_dir`. One must be NULL")
    } else {
        if (!is.null(gubbins_dir)) { 
            if(!fs::dir_exists(gubbins_dir)){
                stop(paste("Specified gubbins_dir:", gubbins_dir, "does not exist"))
            }
            tree_path <- list.files(gubbins_dir, pattern = ".final_tree.tre", full.names = T)[1]
            if(is.na(tree_path)){
                stop(paste("Tree file does not exist in", gubbins_dir))
            }
            # load tree
            prefix <- sub(".final_tree.tre", "", tree_path)
            tree <- BactDating::loadGubbins(prefix)
        } 
        else if (!is.null(verticall_dir)) {
            if(!fs::dir_exists(verticall_dir)){
                stop(paste("Specified verticall_dir:", verticall_dir, "does not exist"))
            }
            tree_path <- file.path(verticall_dir, "verticall.newick")
            if(is.na(tree_path) | !fs::file_exists(tree_path)){
                stop(paste("Tree file does not exist: ", tree_path))
            }
            tree <- midpoint_root_tree(tree_path, save_rooted_tree = F)
        }
    }
    
    # Drop Reference from tree (if exists)
    tree <- ape::drop.tip(tree, c('Reference'))
    
    ##################################
    # get and format dates for clone; make dates match order of tree tips
    ##################################
    dates <- metadata %>% dplyr::select(sequence_id, year) %>% 
        dplyr::mutate(dplyr::across(.cols = everything(), as.character))
    
    dates_all <- data.frame(id=tree$tip.label) %>% tibble::as_tibble() %>% 
        dplyr::left_join(dates, by = c("id" = "sequence_id")) %>% 
        # some years are ranges (e.g., 2008-2010)
        # so set all years to ranges for input into bactdate 
        dplyr::rowwise() %>% 
        dplyr::mutate(year_1 = dplyr::case_when(
            is.na(year) ~ NA,
            grepl("-", year) ~ stringr::str_trim(strsplit(year, "-")[[1]][1]),
            TRUE ~ year)) %>%
        dplyr::mutate(year_2 = dplyr::case_when(
            is.na(year) ~ NA,
            grepl("-", year) ~ stringr::str_trim(strsplit(year, "-")[[1]][2]),
            TRUE ~ year)) %>%
        # for root_to_tip, year ranges will not work
        # so use exact year if available, and mean year for those with ranges
        # See https://github.com/xavierdidelot/BactDating/issues/24 
        dplyr::mutate(year_rtt = dplyr::case_when(
            is.na(year) ~ NA,
            grepl("-", year) ~ as.character(round(mean(c(as.numeric(year_1), as.numeric(year_2))))),
            TRUE ~ year
        )) %>% 
        dplyr::ungroup() %>% 
        dplyr::mutate(
            across(dplyr::starts_with("year_"),
                   ~as.numeric(.))
        )
    
    # year vector for use in rtt
    dates_rtt <- dates_all %>% dplyr::select(id, year_rtt) %>% tibble::deframe()
    
    # year vector for use in bactdate
    dates_bactdate <- dates_all %>% dplyr::select(year_1, year_2) %>% as.matrix()
    colnames(dates_bactdate) <- NULL
    
    return(list("tree" = tree, "dates_bactdate" = dates_bactdate, "dates_rtt" = dates_rtt))
}


midpoint_root_tree <- function(tree_file_path, save_rooted_tree = F) {
    tree_file <- tree_file_path
    prefix <- tools::file_path_sans_ext(basename(tree_file))
    tree <- ape::read.tree(file = tree_file)
    tree$edge.length <- pmax(tree$edge.length, 0.0) # set any negative branch lengths to zero
    mdpt_rooted_tree <- phangorn::midpoint(tree)
    
    # write tree
    if (save_rooted_tree) {
        rooted_tree_file <- file.path(dirname(tree_file),
                                      glue::glue("{prefix}_mdpt_rooted.nwk"))
        print(glue::glue("Writing tree to {rooted_tree_file}"))
        ape::write.tree(
            mdpt_rooted_tree, 
            file = rooted_tree_file
        )
    }
    return(mdpt_rooted_tree)
}


extract_bactdating_summary <- function(x, sublineage=NULL, burnin_prop=0.5, ...) {
    stopifnot(inherits(x, "resBactDating"))
    
    summary_values <- list()
    summary_values$Sublineage <- sublineage 
    # Get param estimates
    for (nam in c("likelihood", "prior", "mu", "sigma", "alpha")) {
        v = x$record[, nam]
        v = v[(1 + length(v)/2):length(v)]
        v = sort(v)
        vals = c(mean(v), v[pmax(1, floor(length(v) * c(0.025, 0.975)))])
        vals = round(vals, 2)
        summary_values[[nam]] <- as.character(
            glue::glue("{vals[1]} [{vals[2]};{vals[3]}]")
        )
    }
    # Get root date
    v = x$record[, Ntip(x$tree) + 1]
    v = sort(v[(1 + length(v)/2):length(v)])
    vals = c(mean(v), v[pmax(1, floor(length(v) * c(0.025, 0.975)))])
    vals = round(vals, 2)
    summary_values$root_date <- as.character(
        glue::glue("{vals[1]} [{vals[2]};{vals[3]}]")
    )
    summary_values$root_date_mlr <- paste0(
        round(x$tree$root.time, 2), " [",
        round(x$CI[Ntip(x$tree) + 1, 1], 2), ";",
        round(x$CI[Ntip(x$tree) + 1, 2], 2), "]"
    )
    summary_values$rootprob <- round(x$rootprob,2) 
    # ESS
    ess <- coda::effectiveSize(
        as.mcmc.resBactDating(x, burnin=burnin_prop)
    )
    summary_values[paste0("ess_",names(ess))] <- round(ess,2)
    # DIC
    summary_values$dic <- round(x$dic,2)
    # Combine df
    summary_df <- as.data.frame(summary_values)
    
    return(summary_df)
}

bd_to_beast_tree <- function(bd_mcmc, dates_bd, show_tree=F){
    beast_tree <- BactDating::as.treedata.resBactDating(bd_mcmc)
    # Get data
    bestroot <- as.numeric(names(sort(table(
        bd_mcmc$record[floor(nrow(bd_mcmc$record)/2):nrow(bd_mcmc$record),
                       "root"]), decreasing = T)[1]))
    # Rows with post-burn-in samples where "root" is bestroot
    bestrows <- intersect(floor(nrow(bd_mcmc$record)/2):nrow(bd_mcmc$record), 
                         which(bd_mcmc$record[, "root"] == bestroot))
    # Calculate mean node dates using best rows
    meanRec <- colMeans(bd_mcmc$record[bestrows, , drop = F])
    node_dates <- bd_mcmc$CI %>% 
        tibble::as_tibble(rownames = "node") %>% 
        dplyr::rename("date_lower" = "V1", "date_upper" = "V2") %>% 
        dplyr::mutate(date = unname(meanRec[1:nrow(bd_mcmc$CI)]))
    # Rejoin to tree data
    tree_data <- tibble::as_tibble(as.data.frame(beast_tree[[2]])) %>% 
        dplyr::mutate(node = trimws(node)) %>% 
        dplyr::left_join(node_dates, by = "node")
    # Make final beast-ish tree file
    beast_tree <- methods::new('treedata', phylo=beast_tree[[1]], data=tree_data)
    
    # Plot tree for sanity check
    p <- ggtree::ggtree(beast_tree, mrsd=lubridate::date_decimal(max(dates_bd, na.rm = T))) +
        ggtree::geom_range(range='length_0.95_HPD', color='red', alpha=.6, size=2) +
        ggtree::geom_text(aes(label=node), size=2, hjust=1.2, vjust=-0.2) +
        ggtree::theme_tree2()
    if(show_tree) {print(p)}
    
    return(beast_tree)
}

