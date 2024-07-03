
##### commands followed in the pipeline #####



#--- Step 1: Quality control FastQC and MultiQC ---#

fastqc # se seleccionan a mano los documentos que quieras y se guarda el report

multiqc FastQC_reports/ #mergea todos los reports de la ubi que le das



#--- Step 2: Trimming with Trimmomatic and Quality control ---#

trim.sh #llamas al script con el código automatizado para trimear

multiQC Trimmomatic_reports/ .mtrimmomatic #report de trimmomatic de todas las muestras con el módulo específico de multiqc

fastqc #seleccion manual de los files con los reads trimmeads

multiqc . #si queremos mergear los reports del fastqc después del trimming



#--- Step 3: Alignment and counting ---#


# 3.1. descargamos y adaptamos los files necesarios

wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/latest_assembly_versions/GCF_000001405.40_GRCh38.p14/ GCF_000001405.40_GRCh38.p14_genomic.fna.gz 

wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Homo_sapiens/annotation_releases/GCF_000001405.40-RS_2023_10/GCF_000001405.40_GRCh38.p14_genomic.gtf.gz

Gunzip CF_000001405.40_GRCh38.p14_genomic.gtf.gz 

Gunzip CF_000001405.40_GRCh38.p14_genomic.fna.gz 

cat GCF_000001405.40_GRCh38.p14_genomic.gtf | cut -f1-8 > first.txt

cat GCF_000001405.40_GRCh38.p14_genomic.gtf | cut -f9 | sed 's/.*GeneID:\([0-9]*\).*/gene_id "\1";/' > second.txt

paste first.txt second.txt > annotations.entrezid.gtf


# 3.2. STAR

STAR_script #crea índice y mappea todos los files. Genera los archivos de counts, summaries y stats


# 3.3. Quality control opcional con multiqc de los reports generados con STAR

multiqc ./*Gene.out.tab -m star 


