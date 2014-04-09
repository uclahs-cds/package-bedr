get_random_regions <- function(n = 10, chr = "chr22", species = "human", build = "hg19", size.mean = 5, size.sd = 1, mask.unmapped = FALSE, sort.output = TRUE) {
# chr can be a region to check specific loci
	chrs <- chr;
	x <- NULL;

	for (chr in chrs) {
		chr.length <- get_chr_length(chr = chr);
		gaps <- query_ucsc(system.file("extdata/gap.txt.gz", package="bedr"))[,-1];
		colnames(gaps)[1:3] <- c("chr","start","end");

		chr.length$prob   <- (chr.length$length)/sum(as.numeric(chr.length$length));


		if (nrow(chr.length)==0) {
			catv("   ERROR: No chr selected!!!");
			stop();
			}
		
		if (mask.unmapped) {
			# create a bit vector the length of the chr to use a mask for sampling
			mask <- !bit(chr.length[chr.length$chr == chr,"length"]);

			# loop over each unmapped region and set the mask to FALSE
			for (i in 1:nrow(gaps[gaps$chr == chr,])) {
				gap <- gaps[i,];
				mask[gap$start:gap$end] <- FALSE;
				}
			
			start <- sample(chr.length[chr.length$chr == chr,"length"],n, replace = TRUE, prob = as.logical(mask));
			}
		else {
			start <- sample(chr.length[chr.length$chr == chr,"length"],n, replace = TRUE);
			}

		end  <- start + ceiling(rlnorm(n, meanlog = size.mean, sdlog = size.sd));
		
		#if (any(end > chr.length[chr.length$chr == chr, "length"])) {
		#	end[end > chr.length[chr.length$chr == chr, "length"]] <- rep(chr.length[chr.length$chr == chr,"length"], sum(end > chr.length[chr.length$chr == chr, "length"]));
		#	}

		x.tmp <- data.frame(chr = chr, start = start, end = end, stringsAsFActors = FALSE);

		old.scipen <- getOption("scipen")
		options(scipen = 999);
		x.tmp <- paste0(x.tmp$chr, ":", x.tmp$start,"-", x.tmp$end);
		options(scipen = old.scipen);

		x <- c(x, x.tmp)
		}
	

	if (sort.output) x <- sort_region(x, check.zero.based = FALSE, check.chr = FALSE, check.valid = FALSE, check.merge = FALSE, verbose = FALSE);

	return(x)
	}
