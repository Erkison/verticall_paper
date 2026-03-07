#!/usr/bin/env Rscript

# http://blog.phytools.org/2015/04/finding-closest-set-of-node-rotations.html

library(optparse)
library(ape)
library(maps)
library(phytools)


option_list <- list(make_option("--in1", type="character", help="First input tree"),
                    make_option("--in2", type="character", help="Second input tree"),
                    make_option("--out2", type="character", help="Second output tree"),
                    make_option("--iterations", type="integer", help="Iterations"))

args <- parse_args(OptionParser(option_list=option_list))

isSingleton<-function(tree,node) if(sum(tree$edge[,1]==node)<=1) TRUE else FALSE

myMinRotate<-function(tree, x) {
    tree <- reorder(tree)
    nn <- 1:tree$Nnode + Ntip(tree)
    x <- x[tree$tip.label]
    for (i in 1:tree$Nnode){
        tt <- read.tree(text=write.tree(if(isSingleton(tree, nn[i])) tree else rotate(tree, nn[i])))
        oo <- sum(abs(order(x[tree$tip.label])-1:length(tree$tip.label)))
        pp <- sum(abs(order(x[tt$tip.label])-1:length(tt$tip.label)))
        if (oo > pp) {
            tree <- tt
        }
        if (oo > pp || i == 1 || i == tree$Nnode) {
            message(paste(i, "/", tree$Nnode, ": ", min(oo, pp), sep=""))
        }
    }
    attr(tree, "minRotate") <- min(oo, pp)
    return(tree)
}

cat("\n")
cat("Loading tree 1: ", args$in1, "\n", sep = "")
tree_1 <- read.tree(args$in1)

cat("Loading tree 2: ", args$in2, "\n", sep = "")
tree_2 <- read.tree(args$in2)
cat("\n")

target_order <- setNames(1:length(tree_1$tip.label), tree_1$tip.label)
for (i in seq(args$iterations)) {
    cat("Iteration ", i, "\n", sep = "")
    tree_2 <- myMinRotate(tree_2, target_order)
    cat("\n")
}
write.tree(tree_2, args$out2)
