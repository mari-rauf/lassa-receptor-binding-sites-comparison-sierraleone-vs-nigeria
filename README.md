# Preliminary analysis of lassa receptor binding sites: Sierraleone-vs-nigeria as an exploratory in-silico study of host pathogen co-evolution:
**Background**: Lassa virus fever is endemic to west africa for a thousand years. The LARGE1 is an enzyme that polymerizes onto alpha-dystroglycan the matriglycan, a linear repeating disaccharide of xylose and glucuronic acid, which was shown to be a high affinity receptor for LASV (Kunzz et al,2005). A paper published by Kotliar, 2024 contained the GWAS of Nigeria and Sierra Leone, and reported a nominal association between LARGE long range haplotype and reduced Lassa fever risk in Nigerian cohorts recruited for the study, yet no replication in Sierra Leone.


**Research Question:** At the selected binding positions (identified from Katz et al, 2022), how do the amino acids in the Nigerian and Sierra Leonean viral sequences differ and can they plausibly contribute to the non-replication of the signal in Sierra Leone?  


**Method:**

Data source: NCBI GenBank database

Tool: Rstudio

*Step by step analysis:*
1. Downloaded a LASV fasta file containing 500 viral sequences from Nigeria, Sierra Leone and other West African countries and a metadata csv file containing the matching accession numbers and countries.
2. Filtered the data to only retain Sierra Leone and Nigerian sequences, all Sierra Leonean (SLean) sequences (n=34) were retained. For Nigerian sequences(n=~405) a random seed was set (set.seed(123)) to ensure reproducibility and random sampling was carried out to create an equal sample of 34 to match the number of SLean sequences.
3. Reverse complemented the sequences where necessary (since Lassa has an ambisense S strand). 
4. Translated the sequences, aligned using ClustalOmega, and extracted and compared SL and NG at some of the key interacting residue positions of the virus. The Katz et.al, 2022 paper defines the domains of the GPC precursor as follows: **1. SSP(stable Single Peptide):** REsidues: 1-58 **2. GP1(Glycoprotein 1):** Residues: 59-259 **3. GP2(GlycoProtein 2):** Residues: 260-491. Since the GP1 is the domain responsible for cell attachment, the positions where SL and NG were compared are Y150, R256, R257 and L258 as identified as the key interacting residues by the same paper. 
5. PLotted it on a multi faceted bar chart with the frequency of each of the amino acid found at the four positions between the two countries. The colour of the bar represents each country. 

**Result:** At the position 150, 28 of the 34 Sierra Leonean seqs had Valine (V), 1 did not and 5 had Tyrosine (Y), while
Discussion/interpretation:
Acknowledgement:   
