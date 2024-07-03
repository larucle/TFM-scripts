#!/bin/bash

for R1 in RawFASTQ/*_1.fastq.gz
do 
  R2="${R1%_1.fastq.gz}_2.fastq.gz"
  #sample="${RawFASTQ/%R2%_2.fastq.gz}"
  sample=${R2:9}
  sample="${sample%_2.fastq.gz}"
  trimmomatic PE -threads 16 -trimlog trimmomatic_summaries/${sample}_log.txt -summary trimmomatic_summaries/${sample}_summary_trimmomatic.txt ${R1} ${R2} trimmed_reads/paired_${sample}_1.fastq.gz trimmed_reads/unpaired_${sample}_1.fastq.gz trimmed_reads/paired_${sample}_2.fastq.gz trimmed_reads/unpaired_${sample}_2.fastq.gz ILLUMINACLIP:$CONDA_PREFIX/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:15 TRAILING:15 SLIDINGWINDOW:4:20 MINLEN:20 2> trimmomatic_summaries/${sample}_stdErr.txt
 # ${infile} ${base}_2.fastq.gz \
  #${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
  #${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
  #echo ${sample}
done
 
