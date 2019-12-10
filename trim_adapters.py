#!/usr/bin/python3

import os

#trim adapters using trimmomatic
samples = ['VcB1', 'VcB2', 'VcB3', 'VcS1', 'VcS2', 'VcS3', 'VcV1', 'VcV2', 'VcV3', 'VcN1', 'VcN2', 'VcN3']

for i in samples:
	print(i)
	os.system('java -jar ~/Downloads/Trimmomatic/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 9 -trimlog '+ i +'_trimmomatic_trimlog.log '+ i +'_R1_001.fastq.gz '+ i +'_R2_001.fastq.gz '+ i +'_R1_trim_pe.fastq.gz '+ i +'_R1_trim_se.fastq.gz '+ i +'_R2_trim_pe.fastq.gz '+ i +'_R2_trim_se.fastq.gz ILLUMINACLIP:/home/alexanderselvey/Desktop/kallisto_server_data/tru3_next_polyG_adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:40')