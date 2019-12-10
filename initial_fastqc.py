#!/usr/bin/python3

import os

#run fastqc on initial raw data
os.system('fastqc -o fastqc_results --extract *gz')