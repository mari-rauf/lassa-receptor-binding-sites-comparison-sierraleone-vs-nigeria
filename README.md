# Preliminary analysis of lassa receptor binding sites: SierraLeone-vs-Nigeria as an exploratory in-silico study of host pathogen co-evolution:
## Background:
Lassa virus fever has been endemic to west africa for over a thousand years. The LARGE1 polymerizes the matriglycan, a linear repeating disaccharide of xylose and glucuronic acid,  onto alpha-dystroglycan, which was shown to be a high affinity receptor for LASV (Kunz et al., 2005). A paper published in 2024 by Kotliar et al. presented the GWAS of Nigeria and Sierra Leone and reported a nominal association between LARGE1 long range haplotype and reduced Lassa fever risk in Nigerian cohorts recruited for the study, but no replication in Sierra Leone.


## Research Question: 
At the selected binding positions (identified from Katz et al., 2022), how do the amino acids in the Nigerian and Sierra Leonean viral sequences differ and can they plausibly contribute to the non-replication of the signal in Sierra Leone?  


## Methods:

### Data source: NCBI GenBank database

### Tool: Rstudio

*Step by step analysis:*
1. Downloaded a LASV GPC fasta file containing 500 viral sequences from Nigeria, Sierra Leone and other West African countries and a metadata csv file containing the matching accession numbers and countries.
2. Filtered the data to only retain Sierra Leone and Nigerian sequences, all Sierra Leonean (SLean) sequences (n=34) were retained. For Nigerian sequences (n=~405) a random seed was set (set.seed(123)) to ensure reproducibility and random sampling was carried out to create an equal sample of 34 to match the number of SLean sequences.
3. Reverse complemented the sequences where necessary (since Lassa has an ambisense S strand). 
4. Translated the sequences, aligned using ClustalOmega in msa (R), and extracted and compared SL and NG at some of the key interacting residue positions of the virus. The Katz et.al, 2022 paper defines the domains of the GPC precursor as follows: **1. SSP(Stable Single Peptide):** REsidues: 1-58 **2. GP1(Glycoprotein 1):** Residues: 59-259 **3. GP2(GlycoProtein 2):** Residues: 260-491. Since the GP1 is the domain responsible for cell attachment, the positions where SL and NG were compared are Y150, R256, R257 and L258 because they were identified as the key interacting residues by the same paper. 
5. PLotted it on a multi faceted bar chart with the frequency of each of the amino acid found at the four positions between the two countries. The colour of the bar represents each country. 

## Result:

<img width="3000" height="1800" alt="Best_Binding_Plot" src="https://github.com/user-attachments/assets/8958a979-0f1f-4727-9736-f611aabad8c5" />



At the position 150, 28 of the 34 SLean sequences have Valine (V), 1 deleted, and 5 have Tyrosine (Y), while 31 out of 34 Nigerian sequences have Tyrosine(Y), 2 show unknown residues and 1 shows deletion. 

At position 256 and 257, all SLean sequences in the sample show deletion except 5 which have the Arginine (R) motif, the same R is found in 33 of the NG sequences while 1 shows deletion.

At position 258, 28 SLean sequences have Aspartic acid (D), 1 is deleted, and 5 show Leucine (L). While 33 of NG sequences have Leucine and 1 shows deletion.




## Discussion and Future work: 

### 1
Arginine (R) forms a salt bridge with the glucuronic acid (GlcA) of the matriglycan (Katz et al., 2022), the absence of it in all of the SLean seq from H.sapiens suggests that the SL LASV may have an alternative route of entry which may not be strictly LARGE1 dependent, or perhaps not to the same degree as the NG one. While it is possible that the deletion could be due to an error in translation in the code but unlikely because majority (25/26) from KGH show the same pattern.

Interestingly, though the Josiah reference strain was isolated from Sierra Leone in 1976 and has the (YRRL) motif along with the older Sierra Leonean sequences, the modern isolates from KGH show (V--D) which suggests temporal divergence i.e. the virus may have undergone evolutionary changes at the receptor binding sites. 


### 2
A direction that might be worth exploring into is that the non-replication of the protective variant could be due to an epigenetic change. Sierra Leone went through a brutal decade long civil war (1990s-early 2000s), one of the hotspots of which was the Eastern province (Kenema is situated in the same province) due to the diamond mines that fueled the conflict, which coincidentally is also a Lassa endemic zone. Patient recruitment for the GWAS started almost 10 years after the war. Future functional studies involving epigenetic profiling would be necessary to understand this. 

## Limitations:
This is an exploratory in-silico study based on publicly available data and aims to only suggest possibilities. 
The sample size of each country is too small(n=34) to make definitive population level conclusions. The comparison of sequences is also not Clade specific, rather country specific.
The structural impacts of (V--D) residues found in SL sequences require wet-lab validation.
Though most sequences are from human hosts, some isolates are from rodents (such as YAK-20, PV730128.1, PV730129.1, PV730130.1) and reflect interactions with the rodent reservoir.
Furthermore, future analysis containing only human derived sequences and redrawing different samples and repeating the comparisons will give a more plausible hypothesis. 

**Acknowledgement:**

Thank you to the authors of Kotliar et al. (2024) and Katz et al. (2022) for answering my questions about their respective studies.

**References:** 

Kunz, S., Rojek, J. M., Kanagawa, M., Spiropoulou, C. F., Barresi, R., Campbell, K. P., & Oldstone, M. B. (2005). Posttranslational modification of α-dystroglycan, the cellular receptor for arenaviruses, by the glycosyltransferase LARGE is critical for virus binding. Journal of virology, 79(22), 14282-14296.

Katz, M., Weinstein, J., Eilon-Ashkenazy, M., Gehring, K., Cohen-Dvashi, H., Elad, N., Fleishman, S. J., & Diskin, R. (2022). Structure and receptor recognition by the Lassa virus spike complex. Nature, 603(7899), 174-179. https://doi.org/10.1038/s41586-022-04429-2

Kotliar, D., Raju, S., Tabrizi, S. et al. Genome-wide association study identifies human genetic variants associated with fatal outcome from Lassa fever. Nat Microbiol 9, 751–762 (2024).
