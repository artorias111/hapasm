#!/usr/bin/env nextflow

// load your modules
include { getHifiReads } from './bin/Reads.nf'
include { getHicReads } from './bin/Reads.nf'

include { runBusco as buscoRound1 } from './bin/Busco.nf' // hifiasm
include { runQuast as QuastRound1 } from './bin/Quast.nf' // hifiasm

/*
include { runBusco as buscoRound2 } from './bin/Busco.nf' // yahs
include { runQuast as QuastRound2 } from './bin/Quast.nf' // yahs
*/

include { runHifiasm; gfa2fa } from './bin/Hifiasm.nf'

/*
include { AlignHicReads } from './bin/Bwamem2.nf'
include { scaffoldWithYahs } from './bin/Yahs.nf'
*/



// define workflows

workflow {
    hifi_ch = Channel.fromPath(params.hifi_reads)
    hic_ch = Channel.fromPath(params.hic_reads)

    // Get reads
    getHifiReads(hifi_ch)
    getHicReads(hic_ch)

    runHifiasm(getHifiReads.out, getHicReads.out.read_files[0], getHicReads.out.read_files[1])
    gfa2fa(runHifiasm.out)

    buscoRound1(gfa2fa.out)
    QuastRound1(gfa2fa.out)
}
