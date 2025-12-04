base_packages <- c(
  "pheatmap",
  "dplyr",
  "tidyr",
  "BiocManager",
  "stringi",
  "ggplot2",
  "tibble",
  "gtools",
  "knitr",
  "ggridges",
  "reshape2",
  "seqinr",
  "scales",
  "glue",
  "patchwork",
  "plotly",
  "paletteer",
  "pheatmap",
  "RColorBrewer",
  "data.table",
  "matrixStats",
  "openxlsx2",
  "readxl",
  "DT",
  "iq"
)

# Arrow is a special install
Sys.setenv(ARROW_WITH_ZSTD = "ON")
install.packages(
  pkgs = 'arrow',
  repos = 'https://cloud.r-project.org'
)
library(arrow)

for (package in base_packages) {
  install.packages(
    pkgs = package,
    repos = 'https://cloud.r-project.org'
  )
  print("----------------------------------------------------------")
  print("----------------------------------------------------------")
  print("----------------------------------------------------------")
  print("")
  print("")
}

BiocManager::install("impute")
BiocManager::install("GSVA")

for (package in c(base_packages, "impute")) {
  library(package, character.only = TRUE)
}
