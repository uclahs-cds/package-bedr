get_random_regions <- function(n = 10, chr = "chr22", species = "human", build = "hg19", size.mean = 5, size.sd = 1, sort = TRUE) {
# chr can be a region to check specific loci

	chrLengths <- get_chr_length(
		species,
		build
		);

	chrLengths <- chrLengths[chrLengths$chr %in% chr, ,drop = FALSE];

	if (nrow(chrLengths)==0) {
		catv("   ERROR: No chr selected!!!");
		stop();
		}

	x <- data.frame(chr=NA,start=NA,end=NA);
	
	for (i in 1:n) {
		x[i,"chr"]   <- sample(chrLengths$chr, 1);
		x[i,"start"] <- round(runif(1, min=1, max=chrLengths[chrLengths$chr == chr,"length"]-1));
		x[i, "end"]  <- x[i,"start"] + ceiling(rlnorm(1, meanlog = size.mean, sdlog = size.sd));
		if (x[i,"end"] > chrLengths[chrLengths$chr == chr, "length"]) {x[i,"end"] <- chrLengths[chrLengths$chr == chr,"length"];}
		}

    old.scipen <- getOption("scipen")
    options(scipen = 999);
	x <- paste0(x$chr, ":", x$start,"-", x$end);
	options(scipen = old.scipen);

	if (sort) x <- sort_region(x, check.zero.based = FALSE, check.chr = FALSE, check.valid = FALSE, check.merge = FALSE, verbose = FALSE);

	return(x)
	}
