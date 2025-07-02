process getHifiReads { 
    input:
    path hifi_dir

    output:
    path hifi_reads

    script:
    """
    mkdir hifi_reads
    python3 ${projectDir}/bin/getHifiReads.py --dir ${hifi_dir}
    mv *.fastq.gz hifi_reads
    """
}



process getHicReads { 
    input:
    path hic_dir

    output:
    path hic_files


    script:
    """
    mkdir hic_files
    python3 ${projectDir}/bin/getHicReads.py --dir ${hic_dir}
    mv *.fastq.gz hic_files
    """
}
