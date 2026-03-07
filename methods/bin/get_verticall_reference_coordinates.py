import sys
from multiprocessing import Pool
from verticall.__main__ import parse_args
from verticall.pairwise import pairwise, find_assemblies, find_reference, check_assemblies, \
    check_one_assembly, process_all_pairs, get_arg_list, parse_part, prepare_log_text, process_one_pair, \
    check_view_num, get_table_header, get_table_line
from verticall.log import log, section_header, explanation, warning
from verticall.alignment import build_indices, align_sample_pair, Alignment

# USAGE:
# conda activate verticall
# /Users/lsheo11/mambaforge/envs/verticall/bin/python3 get_verticall_reference_coordinates.py \
#       pairwise -i assemblies -o ref_coordinates.tsv \
#       -r Reference.fasta --threads 1

def save_alignment_coord_maps(args, assemblies, reference, table_file):
    section_header('Getting coordinate maps of alignment positions')
    arg_list = get_arg_list(args, assemblies, reference)
    # If only using a single thread, do the alignment in a simple loop (easier for debugging).
    if args.threads == 1:
        for a in arg_list:
            alignments = process_one_pair(a, view=True)[0]
            if isinstance(alignments[0], Alignment):
                table_line = alignment_to_coord_maps(alignments, a[1], a[2])
                table_file.write(table_line)
                table_file.flush()
            else:
                warning(f"No alignments found for {alignments[0]}")

    # If using multiple threads, use a process pool to work in parallel.
    else:
        with Pool(processes=args.threads) as pool:
            all_res = pool.starmap(process_one_pair, zip(arg_list, (True for _ in arg_list)))
            for res in all_res:
                alignments = res[0]
                if isinstance(alignments[0], Alignment):
                    name_a, name_b = (name.strip() for name in res[8][0].rstrip(':').split(' vs '))
                    table_line = alignment_to_coord_maps(alignments, name_a, name_b)
                    table_file.write(table_line)
                    table_file.flush()
                else:
                    warning(f"No alignments found for {alignments[0]}")


def alignment_to_coord_maps(alignments, name_a, name_b):
    alignment_pos_map = []
    for a in alignments:
        a_str = str(a) + ' ' + str(a.matches)
        alignment_pos_map.append(a_str)
    alignment_pos_map_line = f"{name_a}\t{name_b}\t{';'.join(alignment_pos_map)}\n"
    return alignment_pos_map_line

def main():
    args = parse_args(sys.argv[1:])

    assemblies = find_assemblies(args.in_dir)
    reference = find_reference(args.reference)
    check_assemblies(assemblies, args.threads, reference)
    build_indices(args, assemblies, args.threads)
    with open(args.out_file, 'wt') as table_file:
        if parse_part(args.part)[0] == 0:  # only include the header in the first part
            table_file.write(f'assembly_a\tassembly_b\talignment_coordinates\n')
        save_alignment_coord_maps(args, assemblies, reference, table_file)

if __name__ == '__main__':
    main()
