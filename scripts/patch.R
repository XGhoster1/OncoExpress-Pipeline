# Find where TCGAbiolinks is installed
pkg_path <- find.package("TCGAbiolinks")
desc_path <- file.path(pkg_path, "DESCRIPTION")

# Read the file
desc <- readLines(desc_path)

# Find and inspect the Imports block (so you know what you're editing)
grep("TCGAbiolinksGUI.data", desc, value = TRUE)