process AignHicReads {
    conda params.bwa_mem_env

    input:
    path hic_reads_1
    path hic_reads_2
    path contig_assembly

    output:
    path "aligned.bam", emit: aligned_bam
    path "aligned.bam.bai", emit: aligned_bam_bai

    script:
    """
    bwa-mem2 mem -SP5M -t ${params.nthreads} ${contig_assembly} ${hic_reads_1} ${hic_reads_2} | \ 
    ${params.samblaster} |\
    samtools view -h -b -F 2316 --threads ${params.nthreads} -o aligned.bam
    samtools index aligned.bam
    """
}
