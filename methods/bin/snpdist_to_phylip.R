#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

square_matrix_to_phylip <- function(M, f) {
    n <- nrow(M)  # of genomes
    ids <- rownames(M)
    write(n, file = f)  
    for (i in 1 : n) {
        write(paste(c(ids[i], as.character(M[i, ])), collapse = "\t"), file = f, append = TRUE)
    }
}

snpdists_tsv <- args[1]
output_phylip <- args[2]

# square matrix format 
dist <- read.table(snpdists_tsv, skip = 1, header = F)
dist_samples <- dist$V1
dist_matrix <- as.matrix(dist[,-1])
dimnames(dist_matrix) <- list(dist_samples, dist_samples)

# square matrix to phylip
square_matrix_to_phylip(dist_matrix, output_phylip)
