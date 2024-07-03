#!/bin/bash


#generating the genome index:
STAR --runThreadN 32 --runMode genomeGenerate --genomeDir hg38/STAR --genomeFastaFiles hg38/GCF_000001405.40_GRCh38.p14_genomic.fna --sjdbGTFfile hg38/ annotations.entrezid.gtf --sjdbOverhang 151 


#alignment and counting:
for R1 in ../paired_trimmed_reads/*_1.fastq.gz
do 
  R2="${R1%_1.fastq.gz}_2.fastq.gz"
  #sample="${RawFASTQ/%R2%_2.fastq.gz}"
  sample=${R2:31}
  sample="${sample%_2.fastq.gz}"
  STAR --runThreadN 18 --genomeDir hg38/STAR --quantMode GeneCounts --readFilesIn ${R1} ${R2} --readFilesCommand zcat --sjdbGTFfile hg38/annotations.entrezid.gtf --outMultimapperOrder Random --outSAMattributes All --outSAMtype BAM SortedByCoordinate --outReadsUnmapped Fastx --outFileNamePrefix STAR_output/${sample} --outFilterMultimapNmax 1
 
 # ${infile} ${base}_2.fastq.gz \
  #${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
  #${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
  #echo ${R2}
done
 
