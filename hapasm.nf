#!/usr/bin/env nextflow

// load your modules
include { getHifiReads } from './bin/Reads.nf'
include { getHicReads } from './bin/Reads.nf'

include { runBusco as buscoRound1 } from './bin/Busco.nf' // hifiasm
include { runQuast as QuastRound1 } from './bin/Quast.nf' // hifiasm

include { runHifiasm; gfa2fa } from './bin/Hifiasm.nf'


// define workflows

workflow {
    // Get reads
    getHifiReads(params.hifi_reads)
    getHicReads(params.hic_reads)
    
    hifi_ch = getHifiReads.out
    .map { dir -> Channel.fromPath("${dir}/*.fastq.gz") }
    .flatten().view()
    
    hic1_ch = getHicReads.out
    .map { dir -> Channel.fromPath("${dir}/*R1*") }
    .view()

    hic2_ch = getHicReads.out
    .map { dir -> Channel.fromPath("${dir}/*R2*") }
    .view()


    runHifiasm(params.species_id, hifi_ch, hic1_ch, hic2_ch)
    
    hifiasm_graph_ch = runHifiasm.out.assembly_graphs
        .flatten()

    gfa2fa(hifiasm_graph_ch)
    
    // buscoRound1(gfa2fa.out)
    // QuastRound1(gfa2fa.out)
}
