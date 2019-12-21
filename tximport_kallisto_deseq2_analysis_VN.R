#tximport after kallisto

library(tximport)
library(rhdf5)
library(DESeq2)
library(readr)

samples <- read_csv(file.path('kallisto_Vc', 'kallisto_Vc_metadata_VN.csv'))
samples

files <- file.path('kallisto_Vc', 'genewiz_kallisto_alignments','VN', samples$sample, 'abundance.h5')
files
txi.kallisto <- tximport(files, type = 'kallisto', txOut = TRUE)
head(txi.kallisto$counts)

ddsTxi <- DESeqDataSetFromTximport(txi.kallisto, colData = samples, design = ~ treatment)

ddsTxi <- DESeq(ddsTxi)
res = results(ddsTxi)
res

(resordered = as.data.frame(res[order(res$padj),]))
write.csv(resordered, '/home/alexanderselvey/kallisto_Vc/genewiz_kallisto_alignments/VN/genewiz_kallisto_tximport_deseq2_VN.csv')

(res1 = subset(res,subset=res@listData[['padj']] < 0.05))
write.csv(res1, '/home/alexanderselvey/kallisto_Vc/genewiz_kallisto_alignments/VN/genewiz_kallisto_tximport_deseq2_VN_sig.csv')
vsd = vst(ddsTxi,blind=FALSE,fitType='local')
plotPCA(vsd,intgroup='treatment')
plotPCA(vsd,intgroup='sample')
plotPCA(vsd,intgroup='sample_number')

vst_mat <- assay(vsd)
vst_cor <- cor(vst_mat)
pheatmap::pheatmap(vst_cor)

library("pheatmap")
select <- order(rowMeans(counts(ddsTxi,normalized=TRUE)),
                decreasing=TRUE)[1:20]
df <- as.data.frame(colData(ddsTxi)[,c("sample","treatment")])
pheatmap(assay(vsd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)

sampleDists <- dist(t(assay(vsd)))
library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condition, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)
