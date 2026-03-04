library(TCGAbiolinks)

# 1. Define the Query
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    sample.type = c("Primary Tumor", "Solid Tissue Normal")
)

# 2. Download the data (this creates a 'GDCdata' folder)
GDCdownload(query)

# 3. Prepare the data into an R object
data <- GDCprepare(query)

# 4. We save the object as a file to use it in case R is restarted
saveRDS(data, "brca_data.rds")
