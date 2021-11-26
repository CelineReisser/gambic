# Read trimming and preparation

## Read filtering
With scripts 00 to 03, we estimated the quality of the reads, and trimmed them according to quality, before checking once more for quality.

## Read merging and normalizing

Because Trinity needs to use reads of all individuals and conditions to build an accurate transcriptome, we merged the reads of all individuals into a unique R1 file and a unique R2 file (script 04).
Many assemblers perform poorly when given too much data, or data with irregular coverage, such as RNAseq data. Subsampling randomly discards some of the reads and reduce the average coverage, but does not take into account the fact that low-coverage regions should be kept with a coverage as high as possible in order to be represented in the assembly. Normalization however discards reads based on the local coverage and uses a k-mer based graph to do so (script 05)

# Trinity build

We used the default parameters to perform the transcriptome assembly of the adult liver of G. holbrooki (script 06a) and obtain its statistics with script 06b.

# Transcripts filtering

## removing transcripts lacking ORFs

## removing low expressed transcripts

## removing redundant transcripts

# Estimation of transcriptome completedness

We used BUSCO and the script 11.
