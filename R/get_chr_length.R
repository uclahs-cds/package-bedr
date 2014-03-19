get_chr_length <- function(species = "human", build = "hg19") {

	file.name <- paste0("genomes/", species, ".", build, ".genome");

	file.name <- system.file(file.name, package = "bedr");

	x <- read.table(file.name, header = FALSE, sep = "\t", as.is = TRUE);
	colnames(x) <- c("chr", "length");

	return(x)
	}
