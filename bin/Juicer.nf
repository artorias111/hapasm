process createHeatmap {
    input:
    path contig_assembly_index
    path yahs_bin
    path yahs_agp

    output:
    path "out_JBAT.hic"

    script:
    """
    ${params.juicer} pre -a -o out_JBAT \
    ${yahs_bin} ${yahs_agp} ${contig_assembly_index} >out_JBAT.log 2>&1

    Juicer_cmd=\$(grep 'JUICER_PRE CMD' out_JBAT.log | sed 's/JUICER_PRE CMD: //' | sed 's/\[I::main_pre\]//')

    eval "\${Juicer_cmd}"
    """
 }
