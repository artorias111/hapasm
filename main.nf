#!/usr/bin/env nextflow

include { runHifiasm; gfa2fa } from './bin/Hifiasm.nf'
include { getHifiReads; getHicReads } from './bin/Reads.nf'
include { runBusco as runBusco_round1 } from './bin/Busco.nf'
include { runQuast as runQuast_round1 } from './bin/Quast.nf'

// scaffold related processes
include { AlignhicReads } from './bin/Bwamem2.nf'
include { ScaffoldWithYahs } from './bin/Yahs.nf'
include { createHeatmap } from './bin/Juicer.nf'

workflow scaffold {
    take:
    assembly_ch

    main:
    AlignhicReads(hic1_ch, hic2_ch, assembly_ch)
    ScaffoldWithYahs(assembly_ch, AlignhicReads.out.aligned_bam)

    emit:
    ScaffoldWithYahs.out.scaffolded_assembly
} 



workflow {

    usr_hifi_ch = getHifiReads(params.hifi_dir)
    usr_hic_ch = getHicReads(params.hic_dir)

    hifi_ch = usr_hifi_ch
    .map { dir -> file("${dir}/*.fastq.gz") }
    .collect()

    hic1_ch = usr_hic_ch
    .map { dir -> file("${dir}/*R1{.,_}*") }

    hic2_ch = usr_hic_ch
    .map { dir -> file("${dir}/*R2{.,_}*") }



/*
    hifi_ch = channel.fromPath('/data2/work/Notothenioids/Dmaw12/Dmaw12_CCS_cells1-3_reads/*')
        .collect()
    hic1_ch = channel.fromPath('/data2/work/Notothenioids/Dmaw12/Dmaw12_HiC_data/*R1*')
    hic2_ch = channel.fromPath('/data2/work/Notothenioids/Dmaw12/Dmaw12_HiC_data/*R2*')
*/

    runHifiasm(params.species_id, hifi_ch, hic1_ch, hic2_ch)
    
    hifiasm_out = runHifiasm.out
    .flatten()

    gfa2fa(hifiasm_out)
    runBusco_round1(gfa2fa.out)
    runQuast_round1(gfa2fa.out)

    scaffold(gfa2fa.out)
}

