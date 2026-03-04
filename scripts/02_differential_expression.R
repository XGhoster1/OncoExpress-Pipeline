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