
# Title : Comparison of LASV Receptor-Binding Sites
# Description: Translates LASV GPC sequences, aligns them to the Josiah reference, and extracts amino acid frequencies at the matriglycan-binding (Y150, R256, R257, L258)
# Author: Maria 
# Date: Nov 2026

# NOTE: The syntax below was developed using youtube tutorials, AI and the book, R for Data Science

# required libraries
library(Biostrings)
library(msa)
library(ggplot2)
library(dplyr)
library(tidyr)
# 1. LOAD DATA
# (This fasta file contains sampled 34 Nigeria + 34 Sierra Leone, which I had already downloaded from NCBI and sampled, soon will add the syntax for that) 
my_sequences <- readDNAStringSet("lasv_gpc_sequences.fasta")
metadata <- read.csv("lasv_metadata.csv")

# 2.PROCESS THE REFERENCE (JOSIAH STRAIN)
# The LASV S segment is ambisense. The GPC is on the reverse strand.
ref_raw <- readLines("josiah_reference.fasta")
s_seq <- paste(ref_raw[!grepl(">", ref_raw)], collapse = "")
# Reverse complement the reference,
rc_seq <- reverseComplement(DNAString(s_seq))

# then use a 21-nucleotide sequence which is 
# the coding for the start of the GPC protein, MGQIVTF(can be confirmed from Uniprot), 
# to find the exact start. the 21 nucleotide sequence below corresponds to the 7 amino acids
# at the start, i.e. M= ATG, G=GGA and so on
start_idx <- regexpr("ATGGGACAAATAGTGACATTC", rc_seq)
gpc_dna <- substr(rc_seq, start_idx, nchar(rc_seq))
ref_protein <- as.character(translate(gpc_dna))

# 3. TRANSLATE YOUR 68 SEQUENCES
# Find the first ATG, translate to protein, and cut at the first stop codon.
# 'if.fuzzy.codon = "solve"' prevents the code from crashing if there are unknown 
# bases in the sequences, translating them to 'X' instead
user_proteins <- sapply(my_sequences, function(x) {
  atg <- regexpr("ATG", as.character(x))
  if (atg == -1) return(NA)
  prot <- as.character(translate(DNAString(substr(as.character(x), atg, nchar(as.character(x)))), if.fuzzy.codon = "solve"))
  stop <- regexpr("\\*", prot)
  if (stop == -1) return(prot) else return(substr(prot, 1, stop - 1))
})
user_proteins <- user_proteins[!is.na(user_proteins)]

# 4. ALIGN PRoteins  
# Combine the translated sequences with the reference and align them 
# using ClustalOmega. This ensures aminonacids across all sequences lines up 
# exactly with the ones in the reference.
all_proteins <- c(user_proteins, "REFERENCE" = ref_protein)
prot_alignment <- msa(AAStringSet(all_proteins), method = "ClustalOmega")
prot_matrix <- as.matrix(prot_alignment)

# 5. EXTRACT POSITIONS
# Using the aligned reference sequence as a map to find the exact grid 
# columns for positions 150, 256, 257, and 258.
ref_row <- which(rownames(prot_matrix) == "REFERENCE")
ref_seq <- prot_matrix[ref_row, ]
non_gap <- which(ref_seq != "-")
cols <- non_gap[c(150, 256, 257, 258)]

p150 <- prot_matrix[-ref_row, cols[1]]
p256 <- prot_matrix[-ref_row, cols[2]]
p257 <- prot_matrix[-ref_row, cols[3]]
p258 <- prot_matrix[-ref_row, cols[4]]

# 6. MATCH COUNTRIES AND PRINT
# Match the accession numbers to the metadata to find which sequence is 
# from Nigeria and which is from Sierra Leone
countries <- metadata$country[match(sub(" .*", "", names(p150)), metadata$accession)]

cat("\n=== Position 150 ===\n"); print(table(countries, p150))
cat("\n=== Position 256 ===\n"); print(table(countries, p256))
cat("\n=== Position 257 ===\n"); print(table(countries, p257))
cat("\n=== Position 258 ===\n"); print(table(countries, p258))

# 7. SAVE
# save as csv file for easy viewing
final_results <- data.frame(Sequence = names(p150), Country = countries, Pos150 = p150, Pos256 = p256, Pos257 = p257, Pos258 = p258)
write.csv(final_results, "Final_Binding_ResultsLDS.csv", row.names = FALSE)
# 8. Make the Plot
# simplify country names so Nigeria is just "Nigeria" (not the states).
# Then, reshape the data and remove gaps/unknowns so the plot is clean.
final_results$Simple_Country <- ifelse(grepl("Nigeria", final_results$Country), "Nigeria", "Sierra Leone")

# Prepare the data
plot_data <- final_results %>%
  select(Simple_Country, Pos150, Pos256, Pos257, Pos258) %>%
  pivot_longer(cols = starts_with("Pos"), names_to = "Position", values_to = "AminoAcid") %>%
  # Remove gaps and unknowns so the plot is clean
  filter(!is.na(AminoAcid), AminoAcid != "-", AminoAcid != "X") %>%
  # how many sequences have each amino acid
  group_by(Simple_Country, Position, AminoAcid) %>%
  summarise(Count = n(), .groups = "drop")

# Generating the bar chart
best_plot <- ggplot(plot_data, aes(x = AminoAcid, y = Count, fill = Simple_Country)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~ Position, scales = "free_y") +
  scale_fill_manual(values = c("Nigeria" = "#377eb8", "Sierra Leone" = "#e41a1c")) +
  theme_minimal() +
  labs(
    title = "Amino Acid Frequencies at LASV Receptor-Binding Positions",
    subtitle = "Comparing Nigerian vs. Sierra Leonean sequences",
    x = "Amino Acid",
    y = "Number of Sequences",
    fill = "Country"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    strip.text = element_text(face = "bold", size = 12),
    legend.position = "bottom"
  )

# Display the plot
print(best_plot)
ggsave("Best_Binding_Plot.png", best_plot, width = 10, height = 6, dpi = 300)
