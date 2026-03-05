# OncoExpress-Pipeline: TCGA-BRCA Differential Expression Analysis

## Executive Summary
This project provides a modular bioinformatics pipeline for analyzing large-scale transcriptomic data from the TCGA-BRCA cohort. By processing 1,224 patient samples (1,111 Tumor vs. 113 Normal), I identified a signature of 3,869 significant genes, including high-confidence biomarkers like MMP11, COL10A1, and NEK2.

### Project Rationale
* **Personal Connection**: Driven by a family history of breast cancer, this project explores the molecular drivers of the disease.
* **Research Interest**: This pipeline serves as a foundation for exploring the potential connection between intratumoral bacterial populations and genomic expression patterns, investigating how the microbiome might influence the signatures identified here.

## Quick Start
To reproduce this analysis, ensure you have R 4.0+ and VS Code installed.

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/YourUsername/OncoExpress-Pipeline.git](https://github.com/YourUsername/OncoExpress-Pipeline.git)
   cd OncoExpress-Pipeline```

2. **Initialize Environment**:
    ```Open project in VSCode, and install the following packages:
    install.packages(c("here", "ggplot2", "ggrepel", "BiocManager"))
    BiocManager::install(c("TCGAbiolinks", "DESeq2", "SummarizedExperiment"))```
3. **Run the pipeline**:
    1. 01_data_downlaod.R
    2. 02_differential_expression.R
    3. 03_visualization.R

| Skill Category | Tools & Concepts | Evidence in Project |
|---|---|---|
| Data Engineering | R, TCGAbiolinks | Automated curation of 1,224 GDC samples |
| Statistical Rigor | DESeq2, FDR, Log2FC | Applied Benjamini-Hochberg correction for multiple testing |
| Visualization | ggplot2, ggrepel | Publication-quality Volcano Plots with labeled top hits |
| Software

## Key Biological Findings
The analysis revealed a strong metastatic and proliferative signature:

    1. MMP11 (Matrix Metallopeptidase 11): Significant up-regulation associated with extracellular matrix breakdown and invasive potential.

    2. NEK2: A master regulator of mitosis, highlighting the high proliferation rate characteristic of this tumor cohort.

## Project Structure

```
OncoExpress-Pipeline/
├── scripts/
│   ├── 01_data_download.R       # Data ingestion
│   ├── 02_differential_expression.R  # Statistical analysis
│   └── 03_visualization.R       # Results and Plots
├── results/
│   ├── plots/                   # Volcano_Plot_BRCA.png
│   └── tables/                  # Top_Hits_Annotated.csv
├── OncoExpress-Pipeline.Rproj   # Project anchor
└── data/                        # GDC raw data (Git-ignored)
```
