# Hapasm

Wrapper to generate phased assemblies with PacBio HiFi + Hi-C reads. 

## Usage
### Quick start




## Parameters
| Parameter | Description |
|-----------|-------------|
|--hifi_reads| Path to PacBio HiFi reads |
|--hic_reads | Path to Hi-C reads |
|--species_id | Name for the species, used in generating Hifiasm assembly |
|--nthreads | Number of threads to use. Default is `16`| 
|--est_ref_size | Default is `800000000` (800Mb). for Quast's NG50 |



## Tools in the pipeline
- Hifiasm: https://github.com/chhylp123/hifiasm
- YaHS: https://github.com/c-zhou/yahs
- bwa-mem2: https://github.com/bwa-mem2/bwa-mem2
- QUAST: https://github.com/ablab/quast
- BUSCO: https://gitlab.com/ezlab/busco
