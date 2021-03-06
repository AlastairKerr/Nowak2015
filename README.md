# Files and scripts for the Nowak 2015 paper 

## Methods 
The locations of pre and pri microRNAs were extracted from miRBase v21 [doi: 10.1093/nar/gkt1181]. The genomic DNA of these sequences and their flanking region was extracted using Ensembl [doi: 10.1093/nar/gkt1196] and Biomart [doi: 10.1093/nar/gkv350] on mouse assembly GRCm38.


## General Scripts 

### rnd_selectseq.pl
Used to generate randomized fasta sequences. From a fasta input sequence, the scripts randomly selects base pairs to generate a new sequence of the same length.

### subseq_loc.pl
Used to map the location of hexamers to the fasta file 

## DotPlot Directory 
### kmer-plot.tsv
Data file for dot plots
### plot-dot.r  
Plot hexamers mapped on selected pri-miRNAs vs all-miRNAs
### plot-dotrnd.r
Plot hexamers on selected pri-miRNAs vs randomised RNA

## Positions Directory 
### mmu-roio+200.ggag and mmu-roio+200.out
Data files for the following pri-miRNAs 

 mmu-let-7a-1 
 mmu-let-7a-2
 mmu-mir-155
 mmu-mir-29a
 mmu-mir-34c
 mmu-mir-9-1
 mmu-mir-9-2
 mmu-mir-9-3
 mmu-mir-99b

For all hexamers (mmu-roio+200.out) and for hexamers containing ggag (mmu-roio+200.ggag)

### KmerPosition.r
Plot the position of hexamers



