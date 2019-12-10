#tximport after kallisto

library(tximport)
library(rhdf5)
library(DESeq2)

samples <- read_csv(file.path('..', 'kallisto_Vc', 'kallisto_Vc_metadata.csv'))
samples

files <- file.path('kallisto_server_data', 'V_N_kallisto', samples$sample, 'abundance.h5')
files
txi.kallisto <- tximport(files,type = 'kallisto', txOut = TRUE)
head(txi.kallisto$counts)

ddsTxi <- DESeqDataSetFromTximport(txi.kallisto, colData = samples, design = ~ treatment)

ddsTxi <- DESeq(ddsTxi)
res <- results(ddsTxi)
res

(resordered = as.data.frame(res[order(res$padj),]))
write.csv(resordered, '/home/alexanderselvey/Desktop/kallisto_tximport_deseq2_VN.csv')
      