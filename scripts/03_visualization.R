# --- PART 1: Setup ---
if (!require("here")) install.packages("here")
library(here)
library(ggplot2)
library(ggrepel)

# --- PART 2: Categorize for Color ---
# We create a column to tell ggplot which points to color
res_annotated$diff_status <- "Not Significant"
# Note: Based on your contrast, Negative LFC = Up in Tumor
dir.create(here("results", "plots"), recursive = TRUE, showWarnings = FALSE)
res_annotated$diff_status[res_annotated$log2FoldChange < -2 & res_annotated$padj < 0.05] <- "Up-regulated (Tumor)"
res_annotated$diff_status[res_annotated$log2FoldChange > 2 & res_annotated$padj < 0.05] <- "Down-regulated (Tumor)"

# --- PART 3: Create Volcano Plot ---
p <- ggplot(res_annotated, aes(x = log2FoldChange, y = -log10(padj), color = diff_status)) +
    geom_point(alpha = 0.5, size = 1.5) +
    scale_color_manual(values = c("Down-regulated (Tumor)" = "blue", 
                                  "Not Significant" = "grey", 
                                  "Up-regulated (Tumor)" = "red")) +
    theme_minimal() +
    geom_vline(xintercept = c(-2, 2), linetype = "dashed", color = "black") +
    geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
    labs(title = "Differential Expression: TCGA-BRCA",
         subtitle = "Tumor (1,111) vs. Normal (113)",
         x = "Log2 Fold Change", y = "-Log10(Adjusted P-value)")

# --- PART 4: Add Labels for Top 10 Hits ---
p_labeled <- p + geom_text_repel(data = head(res_annotated, 10), 
                                 aes(label = gene_name), 
                                 color = "black", size = 3, fontface = "bold")

# --- PART 5: Save to Results ---
ggsave(here("results", "plots", "Volcano_Plot_BRCA.png"), 
       p_labeled, width = 10, height = 8)