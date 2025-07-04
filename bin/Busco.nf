process runBusco {
    conda params.busco_conda

    publishDir "${params.outdir}", saveAs: { filename -> "${filename}" }

    input:
    path genome_asm

    output:
    path "${genome_asm}.BUSCO", emit :busco_results

    script:
    """
    busco -o ${genome_asm}.BUSCO \
    -i ${genome_asm} \
    -m geno \
    -l ${params.busco_lineage} \
    --download_path ${params.busco_db_path} \
    -c ${params.nthreads} \
    --offline
    """
}
