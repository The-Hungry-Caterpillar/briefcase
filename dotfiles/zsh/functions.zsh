knit() {
    OUT=./results/knitted_documents
    mkdir -p ${OUT}
    R -e "rmarkdown::render('$1', output_dir=\"${OUT}\")"
}
