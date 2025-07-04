process runQuast {
    conda params.quast_conda


    publishDir "${params.outdir}", saveAs: { filename -> "${filename}" }

    input:
    path genome_asm

    output:
    path "${genome_asm}.QUAST", emit: quast_results

    script:
    """
    quast -o ${genome_asm}.QUAST -t ${params.nthreads} \
    --est-ref-size ${params.est_ref_size} \
    ${genome_asm}
    """
}
