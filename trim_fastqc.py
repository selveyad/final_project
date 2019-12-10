#!/usr/bin/python3

import os
import re

#run fastqc on trimmed reads
samples = ['VcB1', 'VcB2', 'VcB3', 'VcS1', 'VcS2', 'VcS3', 'VcV1', 'VcV2', 'VcV3', 'VcN1', 'VcN2', 'VcN3']

for i in samples:
	print(i)
	os.system('fastqc -o fastqc_results --extract '+ i +'_R1_trim_pe.fastq.gz')
	os.system('fastqc -o fastqc_results --extract '+ i +'_R2_trim_pe.fastq.gz')