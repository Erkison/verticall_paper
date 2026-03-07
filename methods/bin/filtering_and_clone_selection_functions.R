library(tidyverse)
library(magrittr)
library(RColorBrewer)
library(viridis)
library(ggplot2)


get_qc_range <- function(data, qc_columns) {
    qc_range <- data %>%
        # select qc cols and make long
        dplyr::select(dplyr::all_of(!!qc_columns)) %>%
        tidyr::pivot_longer(cols = dplyr::all_of(!!qc_columns), names_to = "key", values_to = "value") %>%
        dplyr::group_by(key) %>% dplyr::reframe(range = range(value, na.rm = T)) %>% # summarise each group (range)
        dplyr::group_by(key) %>%
        dplyr::summarise("Range in dataset" = paste0(range, collapse = " - ")) %>% # One range per group
        dplyr::rename("Metric" = "key")
    return(qc_range)
}


count_distinct_var_by_group <- function(data, group_col = "Sublineage", var_col = "K_locus", show = Inf) {
    # count and list distinct vars per group
    distinct_var_by_group <- data %>%
        dplyr::filter(! is.na(!!rlang::sym(group_col)) ) %>% # exclude rows with group_col == NA
        dplyr::filter(! is.na(!!rlang::sym(var_col)) ) %>% # exclude rows with var_col == NA
        dplyr::group_by(!!rlang::sym(group_col)) %>%
        dplyr::count(!!rlang::sym(var_col)) %>%
        dplyr::arrange(desc(n)) %>% 
        dplyr::mutate(rank = row_number()) %>% 
        dplyr::mutate(counted_var = if_else(rank <= show, !!rlang::sym(var_col), "Others")) %>% 
        dplyr::reframe(n_distinct = n_distinct(!!rlang::sym(var_col)),
                       values = paste0(unique(counted_var), collapse = "; ")) %>% 
        dplyr::arrange(dplyr::desc(n_distinct))
    return(distinct_var_by_group)
}


# select and filter clones
select_and_filter_clones <- function(filtered_data, clone_var = "Sublineage", min_n_isolates = 20,
                                     min_k_loci_per_clone = 1, min_year_span = 10,
                                     filter_miss_year = F, filter_miss_country = F) {

    # exclude rows without a `clone` designation
    filtered_data %<>%
        dplyr::filter(!  is.na(!!rlang::sym(clone_var))  ) %>%
        # clean O type
        dplyr::mutate(cleaned_O_type = if_else(
            grepl("^unknown", O_type),
            gsub(paste(c("unknown ", "[(]", "[)]"), collapse = "|"), "", O_type),
            O_type))
    # exclude rows with missing year and country info
    if ( filter_miss_year) {filtered_data %<>%  dplyr::filter(! is.na(year) )}
    if (filter_miss_country) {filtered_data %<>% dplyr::filter(! is.na(cleaned_country))}

    # count clones
    clone_count <- filtered_data %>%
        dplyr::count(!!sym(clone_var), name = "N samples") %>% dplyr::arrange(dplyr::desc(`N samples`))

    # count and list distinct K loci per clone
    n_k_loci_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "K_locus", show = 10) %>%
        dplyr::rename(c( "N distinct K loci" = "n_distinct", "K loci (top 10)" = "values"))

    # count and list distinct o loci per clone
    n_o_loci_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "O_locus", show = 10) %>%
        dplyr::rename(c("N distinct O loci" = "n_distinct", "O loci (top 10)" = "values"))

    # count and list distinct o types per clone
    n_o_type_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "cleaned_O_type", show = 10) %>%
        dplyr::rename(c("N distinct O types" = "n_distinct", "O type (top 10)" = "values"))

    # STs per clone
    STs_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "ST", show = 10) %>%
        dplyr::select(!!sym(clone_var), values) %>%
        dplyr::rename("STs" = "values")

    # year range for clones
    years_of_isolation_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "year") %>%
        dplyr::select(!!sym(clone_var), values) %>%
        dplyr::rename("Years" = "values") %>%
        # separate out years recorded as spans. e.g, 2008-2017
        dplyr::rowwise() %>%
        dplyr::mutate(Years =
                   paste0(sort(unique(unlist(strsplit(str_replace_all(Years, "-", "; "), "; ")))),
                          collapse = "; ")
        ) %>%
        dplyr::mutate("Isolation year range" =
                   paste0(min(as.numeric(unlist(strsplit(Years, "; ")))),
                          " - ",
                          max(as.numeric(unlist(strsplit(Years, "; ")))))) %>%
        dplyr::mutate("Year span" =
                   max(as.numeric(unlist(strsplit(Years, "; ")))) - min(as.numeric(unlist(strsplit(Years, "; ")))) + 1
        ) %>%
        dplyr::ungroup() %>%
        dplyr::select(!!sym(clone_var), `Isolation year range`, `Year span`)

    # n missing year
    samples_missing_year_per_clone <- filtered_data %>%
        dplyr::group_by(!!rlang::sym(clone_var)) %>%
        dplyr::summarise(`Samples missing year` = sum(is.na(year)))

    # country
    country_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "cleaned_country") %>%
        dplyr::rename(c( "Countries" = "values", "N countries" = "n_distinct"))

    # Region
    region_by_clone <- count_distinct_var_by_group(filtered_data, clone_var, "region") %>%
        dplyr::select(!!sym(clone_var), values) %>%
        dplyr::rename("Region" = "values")

    # merge and apply filters
    selected_clones_summary_data_full <- clone_count %>%
        # join
        dplyr::left_join(STs_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(n_k_loci_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(n_o_loci_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(n_o_type_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(years_of_isolation_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(country_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(region_by_clone, by = quo_name(rlang::sym(clone_var))) %>%
        dplyr::left_join(samples_missing_year_per_clone, by = quo_name(rlang::sym(clone_var))) %>%
        # prop of each clone missing year info
        dplyr::mutate(`Prop missing year` = `Samples missing year` / `N samples`) %>%
        # filter based on minimum isolate number and distinct k loci required
        dplyr::filter(! `N samples` < min_n_isolates) %>%
        dplyr::filter(! `N distinct K loci` < min_k_loci_per_clone) %>%
        dplyr::filter(! `Year span` < min_year_span) %>%
        # sort
        dplyr::arrange( desc(`N samples`), desc(`N distinct K loci`) )

    selected_clones_summary_data <- selected_clones_summary_data_full %>%
        dplyr::select(!!sym(clone_var), "N samples", "STs",
                      "N distinct K loci", "K loci (top 10)",
                      "N distinct O loci", "O loci (top 10)",
                      "N distinct O types", "O type (top 10)",
                      "Isolation year range", "Year span",
                      "Region")

    selected_clones_data <- filtered_data %>%
        dplyr::filter( !!sym(clone_var) %in% selected_clones_summary_data[[clone_var]] ) %>%
        dplyr::mutate( !!sym(clone_var) := as.character(!!sym(clone_var)) )

    return(list(
        selected_clones_summary_data_full = selected_clones_summary_data_full,
        selected_clones_summary_data = selected_clones_summary_data,
        selected_clones_data = selected_clones_data
        ))
}

combine_clones <- function(filtered_data, clone_var = "Sublineage", ...) {

    # combine clones
    clones_to_combine <- c(...)
    combined_clones <- paste(clones_to_combine, collapse = "_and_")
    filtered_data[[clone_var]] <- as.character(filtered_data[[clone_var]])

    filtered_data <- filtered_data %>%
        dplyr::mutate(!!sym(clone_var) := case_when(
            grepl('_and_', !!sym(clone_var)) ~ !!sym(clone_var),
            !!rlang::sym(clone_var) %in% clones_to_combine ~ combined_clones,
            TRUE ~ as.character(!!rlang::sym(clone_var))))
    return(filtered_data)
}
