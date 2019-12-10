#!/usr/bin/bash

#bash wrapper for individaul python scripts to do a full RNA-Seq data clean up and differential expression analysis

#ideally, you should have all of your raw sequencing data (preferably copies), de novo transcriptome, fastqc_results directory, trimming adapter fasta file, kallisto index (can be made in directory by modifying the individual script), and Rscripts for DE analysis all in the same 'rna_seq_de_analysis/' 

#run initial fastqc
python initial_fastqc.py

wait

#trim off adapters
python trim_adapters.py

wait

#run trimming fastqc
python trim_fastqc.py

wait

#align trimmed reads to de novo transcriptome using kallisto
python kallisto_index_quant.py

wait

#run DE analysis for 4 groups (B vs. S, B vs. V, S vs. N, V vs. N)
Rscript ~/Desktop/kallisto_server_data/tximport_kallisto_deseq2_analysis_BS.R
Rscript ~/Desktop/kallisto_server_data/tximport_kallisto_deseq2_analysis_VB.R
Rscript ~/Desktop/kallisto_server_data/tximport_kallisto_deseq2_analysis_NS.R
Rscript ~/Desktop/kallisto_server_data/tximport_kallisto_deseq2_analysis_VN.R

wait

#run multiqc
cd fastqc_results
multiqc .
