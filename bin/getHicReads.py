#!/usr/bin/env python3

import argparse
import os
import re
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--dir', type=str, required=True)
args = parser.parse_args()

hic_path = Path(args.dir).resolve()

files_list = os.listdir(hic_path)
reads_description = {}

for f in files_list:
    if '.fastq.gz' in f:
        curr_file = f
        original_file = hic_path / f

        if '_R1' in curr_file:
            reads_description['R1'] = Path(original_file).as_posix()
            Path(curr_file).symlink_to(original_file)


        if '_R2' in curr_file:
            reads_description['R2'] = Path(original_file).as_posix()
            Path(curr_file).symlink_to(original_file)
    else:
        continue

# print(reads_description) # debug
