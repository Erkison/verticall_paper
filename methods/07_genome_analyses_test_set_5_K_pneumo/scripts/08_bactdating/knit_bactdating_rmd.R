#!/usr/local/bin/Rscript

library(optparse)
library(rmarkdown)

# pandoc path
Sys.setenv(RSTUDIO_PANDOC=rmarkdown::find_pandoc()$dir)

default_iterations <- 100000
default_seed <- 3
tree_for_bactdate_options <- c('tree', 'rooted_tree', 'rooted_tree_rec')
default_tree_for_bactdate <- tree_for_bactdate_options[1]
default_best_model <- 'relaxedgamma'
default_n_alignment_sites <- 1
default_run_mode <- 'full'
default_na_year <- 'include'

# args
option_list = list(
    optparse::make_option(c('-c', '--clone'), type = 'character', default = NULL,
                          help = 'required: clone (e.g., SL_10)'),
    optparse::make_option(c('-m', '--markdown_template'), type = 'character', default = NULL,
                          help = 'required: path to rmarkdown file'),
    optparse::make_option(c('-o', '--output_dir'), type = 'character', default = NULL,
                          help = 'required: path to write output doc'),
    optparse::make_option(c('-i', '--iterations'), type = 'double', default = default_iterations,
                          help = "Number of iterations [default = %default]"),
    optparse::make_option(c('-s', '--seed'), type = 'integer', default = default_seed,
                          help = "seed [default = %default]"),
    optparse::make_option(c('-t', '--tree_for_bactdate'), type = 'character', default = default_tree_for_bactdate,
                          help = "One of 'tree', 'rooted_tree', or 'rooted_tree_rec'. [default = %default]"),
    optparse::make_option(c('-b', '--best_model'), type = 'character', default = default_best_model,
                          help = "Best model. Only needed for test run. [default = %default]"),
    optparse::make_option(c('-n', '--n_alignment_sites'), type = 'integer', default = NULL,
                          help = "Number of verticall alignment sites used to create tree. Only needed for verticall trees"),
    optparse::make_option(c('-r', '--run_mode'), type = 'character', default = default_run_mode,
                          help = "One of 'full' or 'resume'. Use 'resume' to skip steps with a previous saved MCMC object. [default = %default]"),
    optparse::make_option(c('-y', '--na_year'), type = 'character', default = default_run_mode,
                          help = "One of 'include' or 'exclude'. Use 'exclude' to exclude samples with missing year info. [default = %default]")
    
);
opt_parser = optparse::OptionParser(option_list = option_list);
opt = optparse::parse_args(opt_parser);

# check args
if (is.null(opt$clone) || is.null(opt$markdown_template) || is.null(opt$output_dir)) {
    optparse::print_help(opt_parser)
    stop("All mandatory arguments must be supplied", call. = FALSE)
}
if (! opt$tree_for_bactdate %in% tree_for_bactdate_options) {
    optparse::print_help(opt_parser)
    stop(glue::glue("--tree_for_bactdate option must be one of {}"), call. = FALSE)
}


render_report <- function(markdown_file, clone, output_dir, 
                          iterations=default_iterations, seed=default_seed, 
                          tree_for_bactdate=default_tree_for_bactdate,
                          best_model=default_best_model, 
                          n_alignment_sites=default_n_alignment_sites,
                          run_mode=default_run_mode, na_year=default_na_year){
    out_prefix <- tools::file_path_sans_ext(basename(markdown_file))
    rmarkdown::render(
        markdown_file, params = list(
            clone = clone,
            iterations = iterations,
            seed = seed,
            tree_for_bactdate = tree_for_bactdate,
            best_model = best_model,
            n_alignment_sites = n_alignment_sites,
            run_mode = run_mode,
            na_year = na_year
        ),
        output_file = file.path(output_dir, glue::glue("{clone}_{out_prefix}_{iterations}_iters.html")),
        output_format = 'html_document'
    )
}

# Generate report
render_report(markdown_file = opt$markdown_template, clone = opt$clone, 
              output_dir = opt$output_dir, iterations = opt$iterations, 
              seed = opt$seed, tree_for_bactdate = opt$tree_for_bactdate,
              best_model = opt$best_model, n_alignment_sites = opt$n_alignment_sites, 
              run_mode = opt$run_mode, na_year = opt$na_year)


