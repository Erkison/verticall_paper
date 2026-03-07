All analyses were run on MASSIVE. Sample commands with a single sublineage (SL1) are shown


### Directory structure
```
- working_dir/
    - SL_1/
        - SL_1_data.tsv
        - gubbins/
        - verticall/
        - verticall_dist/
    - SL_10/
    - scripts/
    - bactdating/
        - scripts/
            - run_bactdating_for_clone.sh
            - ...
```


### Bactdating  
Software used:  

 - [BactDating](https://github.com/xavierdidelot/BactDating) v1.1.1  
```bash 
conda activate bactdatingR

# bactdating gubbins
bash scripts/run_bactdating_for_clone.sh SL_1 gubbins test 10000000 3 rooted_tree_rec

# bactdating verticall alignment
bash scripts/run_bactdating_for_clone.sh SL_1 verticall test 10000000 3 rooted_tree <ALIGNMENT_LENGTH>

# bactdating verticall distance
bash scripts/run_bactdating_for_clone.sh SL_1 verticall_dist test 10000000 3 rooted_tree
```

