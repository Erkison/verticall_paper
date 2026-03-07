There are two ways I'm assessing trees:
* Temporal signal: appropriate for S_pneumo_PMEN1 and S_enterica_Typhi_431 which have sample dates
* Root-to-tip variance: appropriate for E_coli_GEMS and Klebsiella_Alfred which do not have sample dates

# Paths

```bash
main_dir=/home/wickr/Verticall_paper/
```

# Rotate tree nodes to better match each other

This step doesn't change the tree topology, it just makes the trees a bit easier to visually compare side by side.


## Rotate S_pneumo_PMEN1 and E_coli_GEMS trees
```bash 
for s in S_pneumo_PMEN1 E_coli_GEMS; do
    cd ${main_dir}/${s}
    for i in {1..3}; do
        ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 snippy_clonalframeml_iqtree.newick --out2 snippy_clonalframeml_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1
    
        ../../scripts/rotate_trees.R --in1 snippy_clonalframeml_iqtree.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_clonalframeml_iqtree.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_clonalframeml_iqtree.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_clonalframeml_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_clonalframeml_iqtree.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1
    
        ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 snippy_clonalframeml_iqtree.newick --out2 snippy_clonalframeml_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1
    
        ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 snippy_clonalframeml_iqtree.newick --out2 snippy_clonalframeml_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1
    
        ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_clonalframeml_iqtree.newick --out2 snippy_clonalframeml_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1
    
        ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 snippy_clonalframeml_iqtree.newick --out2 snippy_clonalframeml_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
        ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
    done
done
```

## Rotate S_enterica_Typhi_431 trees
```bash
cd ${main_dir}/S_enterica_Typhi_431
for i in {1..3}; do
    ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1

    ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_gubbins_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1

    ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_verticall_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1

    ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_gubbins_iqtree.newick --out2 snippy_gubbins_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_verticall_iqtree.newick --out2 snippy_verticall_iqtree.newick --iterations 1
done
```

## Rotate Klebsiella_Alfred trees
```bash
cd ${main_dir}/Klebsiella_Alfred
for i in {1..3}; do
    ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 snippy_iqtree.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1

    ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 fastani_fastme.newick --in2 verticall_pairwise_fastme.newick --out2 verticall_pairwise_fastme.newick --iterations 1

    ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 snippy_iqtree.newick --out2 snippy_iqtree.newick --iterations 1
    ../../scripts/rotate_trees.R --in1 verticall_pairwise_fastme.newick --in2 fastani_fastme.newick --out2 fastani_fastme.newick --iterations 1
done
```



