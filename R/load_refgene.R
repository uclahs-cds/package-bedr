load_refgene <- function(x, protein.coding = TRUE) {
	# download
	refgene <- read_ucsc("refGene");
	# select some fields
	# select only protein coding genes
	# remove duplicate genes
	# remove some overlapping problem features
	# sort and merge
	}
