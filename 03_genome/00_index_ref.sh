#!/bin/bash
#SBATCH --account=def-jonmee
#SBATCH --time=06:00:00
#SBATCH --mem=8G
#SBATCH --mail-user=jmee@mtroyal.ca
#SBATCH --mail-type=ALL
#SBATCH --output=00_index_ref_%j.out
#SBATCH --job-name=00_index_ref 

cd /home/jonmee/projects/def-jonmee/jonmee/ref_ninespine_2024/

module load nixpkgs/16.09 gcc/7.3.0

echo "Starting bwa index at: `date`" 

module load bwa/0.7.17

bwa index GCA_949316345.1_fPunPun2.1_genomic.fna

echo "Finished bwa index at: `date`" 

echo "Starting samtools faidx at: `date`" 

module load samtools/1.9

samtools faidx GCA_949316345.1_fPunPun2.1_genomic.fna

echo "Finished samtools faidx at: `date`" 

echo "Starting picard CreateSequenceDictionary at: `date`" 

module load picard/2.18.9
 
java -Xmx32G -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary \
	R=GCA_949316345.1_fPunPun2.1_genomic.fna \
	O=GCA_949316345.1_fPunPun2.1_genomic.dict

module unload nixpkgs/16.09 gcc/7.3.0 picard/2.18.9

echo "Program finished with exit code $? at: `date`" 
