process getHifiReads { 
    input:
    path hifi_dir

    output:
    tuple path("*.fastq.gz"), emit: hifi_reads


    script:
    """
    python3 ${projectDir}/bin/getHifiReads.py --dir ${hifi_dir}
    """
    


}



process getHicReads { 
    input:
    path hic_dir

    output:
    path hic_reads1, emit: read1
    path hic_reads2, emit: read2

    script:
    """
    python3 ${projectDir}/bin/getHicReads.py --dir ${hic_dir}
    """
}
