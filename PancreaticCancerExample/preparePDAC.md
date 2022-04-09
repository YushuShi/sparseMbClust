### Pancreatic cancer dataset 

### Authors
Yushu Shi (shiyushu2006@gmail.com)

#### File organization

The data are created from the study

- Riquelme E, Zhang Y, Zhang L, Montiel M, Zoltan M, Dong W, Quesada P, Sahin I, Chandra V, San Lucas A, Scheet P, Xu H, Hanash SM, Feng L, Burks JK, Do KA, Peterson CB, Nejman D, Tzeng CD, Kim MP, Sears CL, Ajami N, Petrosino J, Wood LD, Maitra A, Straussman R, Katz M, White JR, Jenq R, Wargo J, McAllister F. Tumor Microbiome Diversity and Composition Influence Pancreatic Cancer Outcomes. Cell. 2019 Aug 8;178(4):795-806.e12. doi: 10.1016/j.cell.2019.07.008. PMID: 31398337; PMCID: PMC7288240.

Sequencing data and patient survival length can be accessed through NCBI BioProject Accession Number: PRJNA542615. 16S rRNA sequencing data were processed using the pipeline developed by Robert Jenq (rrjenq@mdanderson.org).

#### Code

- `otutable.csv`. The OTU table providing the number of OTU replicates for each sample.

- `tax.levels.csv`. The taxonomy assignment of OTUs

- `metadata.csv`. The survival status for each sample

- `preparePDAC.R`. Prepare the raw data for MFMDTM method

#### Acknowledgements

The code provided here is associated with the real data application section of the following publication/webpage:

- Yushu Shi, Liangliang Zhang, Kim-Anh Do, Robert Jenq and Christine B. Peterson (2022). Sparse tree-based clustering of microbiome data to characterize microbiome heterogeneity in pancreatic cancer. 



