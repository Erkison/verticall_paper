#!/usr/bin/env python3

import argparse
import sys
from Bio import AlignIO
from Bio.Align import MultipleSeqAlignment

def parse_intervals(log_path, start_col=0, end_col=1, has_header=True):
    """
    Parses a tab/space-separated log file to extract start and end coordinates.
    Adjust start_col and end_col based on the exact structure of your SimBac log.
    """
    intervals = []
    with open(log_path, 'r') as f:
        if has_header:
            next(f)
            
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if not line or line.startswith('#'):
                continue
                
            parts = line.split()
            try:
                # SimBac logs are 0-indexed
                start = int(parts[start_col])
                end = int(parts[end_col])
                
                # Handle circular genome wrapping (where start > end)
                if start > end:
                    # split into two intervals: start to end-of-genome, and 0 to end
                    # Inf placehold; end of genome obtained later from alignment length
                    intervals.append((start, float('inf'))) 
                    intervals.append((0, end))
                else:
                    intervals.append((start, end))
            except (IndexError, ValueError):
                print(f"Warning: Could not parse line {line_num}: '{line}'. Skipping.", file=sys.stderr)
                
    return intervals


def merge_intervals(intervals):
    """
    Merges overlapping intervals 
    """
    if not intervals:
        return []
        
    # Sort by start coordinate
    intervals.sort(key=lambda x: x[0])
    
    merged = [intervals[0]]
    for current_start, current_end in intervals[1:]:
        prev_start, prev_end = merged[-1]
        
        if current_start <= prev_end:
            # Overlapping intervals, merge them
            merged[-1] = (prev_start, max(prev_end, current_end))
        else:
            # Non-overlapping, append
            merged.append((current_start, current_end))
            
    return merged


def exclude_recombinant_regions(alignment, recomb_intervals):
    """
    Slices the Biopython MultipleSeqAlignment to exclude the specified intervals.
    """
    aln_length = alignment.get_alignment_length()
    
    # Cap any wrapped 'inf' intervals to the alignment length
    capped_intervals = [(s, min(e, aln_length)) for s, e in recomb_intervals]
    merged_intervals = merge_intervals(capped_intervals)
    
    # Invert the recombinant intervals to find the "clonal" (keep) intervals
    keep_intervals = []
    current_pos = 0
    
    for start, end in merged_intervals:
        if start > current_pos:
            keep_intervals.append((current_pos, start))
        current_pos = max(current_pos, end)
        
    if current_pos < aln_length:
        keep_intervals.append((current_pos, aln_length))

    # Slice the alignment and concatenate the "keep" blocks
    filtered_alignment = None
    
    for start, end in keep_intervals:
        slice_block = alignment[:, start:end]
        if filtered_alignment is None:
            filtered_alignment = slice_block
        else:
            filtered_alignment += slice_block
            
    return filtered_alignment if filtered_alignment else MultipleSeqAlignment([])

def main():
    parser = argparse.ArgumentParser(description="Exclude recombinant intervals from a SimBac alignment.")
    parser.add_argument("-i", "--input", required=True, help="Input FASTA alignment (-o from SimBac)")
    parser.add_argument("-l", "--log", required=True, help="Recombination log file (-b or -f from SimBac)")
    parser.add_argument("-o", "--output", required=True, help="Output filtered FASTA file")
    
    # Optional 
    parser.add_argument("--start-col", type=int, default=0, help="Column index for interval start (default: 0)")
    parser.add_argument("--end-col", type=int, default=1, help="Column index for interval end (default: 1)")
    parser.add_argument("--header", action="store_true", default=True, help="Set this flag if the log file has a header row")

    args = parser.parse_args()

    alignment = AlignIO.read(args.input, "fasta")
    recomb_intervals = parse_intervals(args.log, args.start_col, args.end_col, args.header)
    
    filtered_alignment = exclude_recombinant_regions(alignment, recomb_intervals)
    
    filtered_len = filtered_alignment.get_alignment_length() if len(filtered_alignment) > 0 else 0
    print(f"Filtered alignment length: {filtered_len} bp ({alignment.get_alignment_length() - filtered_len} bp recombinant regions excluded)")

    if filtered_len > 0:
        AlignIO.write(filtered_alignment, args.output, "fasta")
        print(f"Success! Filtered alignment written to {args.output}")
    else:
        print("Warning: The entire alignment was filtered out. No output file written.")

if __name__ == "__main__":
    main()
