# --- PART 1: Load Analysis Libraries ---
library(DESeq2)
library(ggplot2)

# --- PART 2: Initialize DESeq2 Object ---
# Design uses 'sample_type' to compare Tumor vs Normal
dds <- DESeqDataSet(data, design = ~ sample_type)

# --- PART 3: Pre-filtering ---
# Keep genes with at least 10 reads total across all 1,224 samples
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
print(paste("Genes remaining after filtering:", nrow(dds)))

# --- PART 4: Run Differential Expression ---
# This step handles normalization and statistical testing
dds <- DESeq(dds)


# --- PART 5: Extract Results ---
# Contrast: Folder Name, Numerator (Tumor), Denominator (Normal)
res <- results(dds, contrast=c("sample_type", "Primary Tumor", "Solid Tissue Normal"))
summary(res)

# --- Part 6: Extract stricter results ---
# We set a higher treshold
# 1. Extract results with a stricter significance threshold
# alpha = 0.05 (stricter than the default 0.1)
res_strict <- results(dds, alpha = 0.05)

# 2. Filter for genes with high magnitude of change (|LFC| > 2)
# This finds genes that are roughly 4x different between groups
res_hits <- subset(res_strict, padj < 0.05 & abs(log2FoldChange) > 2)

# 3. Sort by significance (most significant first)
res_hits <- res_hits[order(res_hits$padj), ]

# 4. Check how many 'Top Hits' we have now
nrow(res_hits)

# --- PART 7: Annotation & ID Mapping ---
# Extract gene annotations (symbols) from the SummarizedExperiment object
anno <- as.data.frame(rowData(data))

# Convert results to a data frame and merge with symbols
res_df <- as.data.frame(res_hits)
res_df$ensembl_gene_id <- rownames(res_df)

# Merge based on IDs
res_annotated <- merge(res_df, anno, by.x = "ensembl_gene_id", by.y = "gene_id")

# Sort by significance
res_annotated <- res_annotated[order(res_annotated$padj), ]

# Save the high-confidence hits to your results folder
write.csv(res_annotated, "results\\Top_Hits_Annotated.csv", row.names = FALSE)

# Preview the top hits
head(res_annotated[, c("gene_name", "log2FoldChange", "padj")], 15)