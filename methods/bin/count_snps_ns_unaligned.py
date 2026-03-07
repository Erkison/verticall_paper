#!/usr/bin/env python3


import gzip
import sys


def main():
    sequences = iterate_fasta(sys.argv[1])

    canonical = {'A', 'C', 'G', 'T'}

    _, ref_seq = next(sequences)
    for ref_base in ref_seq:
        assert ref_base in canonical

    for name, seq in sequences:
        assert len(seq) == len(ref_seq)
        match_count, snp_count, n_count, unaligned_count = 0, 0, 0, 0
        for base, ref_base in zip(seq, ref_seq):
            if base == ref_base:
                match_count += 1
            elif base == 'N':
                n_count += 1
            elif base == '-':
                unaligned_count += 1
            else:
                assert base in canonical
                snp_count += 1
        print(f'{name}\t{snp_count}\t{n_count}\t{unaligned_count}')
        



def get_compression_type(filename):
    """
    Attempts to guess the compression (if any) on a file using the first few bytes.
    http://stackoverflow.com/questions/13044562
    """
    magic_dict = {'gz': (b'\x1f', b'\x8b', b'\x08'),
                  'bz2': (b'\x42', b'\x5a', b'\x68'),
                  'zip': (b'\x50', b'\x4b', b'\x03', b'\x04')}
    max_len = max(len(x) for x in magic_dict)
    unknown_file = open(str(filename), 'rb')
    file_start = unknown_file.read(max_len)
    unknown_file.close()
    compression_type = 'plain'
    for file_type, magic_bytes in magic_dict.items():
        if file_start.startswith(magic_bytes):
            compression_type = file_type
    if compression_type == 'bz2':
        sys.exit('\nError: cannot use bzip2 format - use gzip instead')
    if compression_type == 'zip':
        sys.exit('\nError: cannot use zip format - use gzip instead')
    return compression_type


def get_open_func(filename):
    if get_compression_type(filename) == 'gz':
        return gzip.open
    else:  # plain text
        return open


def iterate_fasta(filename, include_info=False, preserve_case=False):
    """
    Takes a FASTA file as input and yields the contents as (name, seq) tuples. If include_info is
    set, it will yield (name, info, seq) tuples, where info is whatever follows the name.
    """
    with get_open_func(filename)(filename, 'rt') as fasta_file:
        name = ''
        sequence = []
        for line in fasta_file:
            line = line.strip()
            if not line:
                continue
            if line[0] == '>':  # Header line = start of new contig
                if name:
                    if include_info:
                        name_parts = name.split(maxsplit=1)
                        contig_name = name_parts[0]
                        info = '' if len(name_parts) == 1 else name_parts[1]
                        yield contig_name, info, ''.join(sequence)
                    else:
                        yield name.split()[0], ''.join(sequence)
                    sequence = []
                name = line[1:]
            else:
                if preserve_case:
                    sequence.append(line)
                else:
                    sequence.append(line.upper())
        if name:
            if include_info:
                name_parts = name.split(maxsplit=1)
                contig_name = name_parts[0]
                info = '' if len(name_parts) == 1 else name_parts[1]
                yield contig_name, info, ''.join(sequence)
            else:
                yield name.split()[0], ''.join(sequence)


if __name__ == '__main__':
    main()
