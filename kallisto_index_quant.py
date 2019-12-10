#!/usr/bin/python3

import os

#create index for kallisto
os.system('kallisto index -i kallisto_reed_index.idx ~/Desktop/kallisto_server_data/genewiz_transcriptome.fa')

#align trimmed reads
samples = ['VcB1', 'VcB2', 'VcB3', 'VcS1', 'VcS2', 'VcS3', 'VcV1', 'VcV2', 'VcV3', 'VcN1', 'VcN2', 'VcN3']

for i in samples:
	os.system('kallisto quant -i kallisto_reed_index.idx -o kallisto_alignments -b 100 '+ i +'_R1_trim_pe.fastq.gz '+ i +'_R2_trim_pe.fastq.gz')