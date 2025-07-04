process ScaffoldWithYahs {
    input:
    path fasta
    path aligned_bam

    output:
    path "yahs.out_scaffolds_final.fa", emit: scaffolded_assembly
    path "yahs.out_scaffolds_final.fa.fai"

    script:
    """
    {params.yahs}/yahs ${fasta} ${aligned_bam}
    """
}
