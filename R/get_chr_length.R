get_chr_length <- function(chr = NULL, species = "human", build = "hg19") {

	file.name <- paste0("genomes/", species, ".", build, ".genome");

	file.name <- system.file(file.name, package = "bedr");

	x <- read.table(file.name, header = TRUE, sep = "\t", as.is = TRUE);
	
	if (!is.null(chr)) {
		x <- x[x$chr %in% chr,];
		}

	return(x)
	}
