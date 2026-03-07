#!~/miniconda/bin/python3

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
import sys

# Arguments
multifasta_file = sys.argv[1]
headers_list = sys.argv[2]
output_file = sys.argv[3]


ffile = SeqIO.parse(multifasta_file, "fasta")
header_set = set(line.strip() for line in open(headers_list, encoding="utf-8"))

output_fasta_record = []

for seq_record in ffile:
    try:
        header_set.remove(seq_record.name)
        output_fasta_record.append(SeqRecord(
            seq_record.seq,
            id = seq_record.id,
            description=''
        ))
    except KeyError:
        continue

SeqIO.write(output_fasta_record, output_file, "fasta")

if len(header_set) != 0:
    print(len(header_set), 'of the headers from list were not identified in the input fasta file.', file=sys.stderr)
    print(header_set)
