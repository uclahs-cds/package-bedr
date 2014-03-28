permute_region <- function(x, stratify.by.chr = FALSE, is.checked = FALSE) {

	if (!is.checked) {
		x <- convert2bed(x);
		}

	chr.length <- get_chr_length(chr = unique(x$chr));
	chr.length$prob   <- chr.length$length/sum(chr.length$length)

	if (stratify.by.chr) {
		for (chr in  unique(x$chr)) {
			size.dist    <- x[x$chr == chr,"end"] - x[x$chr == chr,"start"];
			n.regions    <- length(size.dist);
			random.size  <- sample(size.dist, n.regions, replace = TRUE);
			random.start <- sample(chr.length[chr.length$chr == chr,"length"], n.regions, replace = TRUE);
			random.end   <- random.start + random.size;
			x[x$chr == chr, "start"] <- random.start;
			x[x$chr == chr, "end"]   <- random.end;
			}
		}
	else {
		size.dist    <- x$end - x$start;
		n.regions    <- length(size.dist);
		random.size  <- sample(size.dist, n.regions, replace = TRUE);
		random.chr   <- sample(chr.length$chr, n.regions, replace = TRUE, prob = chr.length$prob); # weighted according to size
		random.start <- integer(n.regions);
		for (chr in unique(random.chr)) {
			random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE);
			}
		random.end   <- random.start + random.size;
		x <- data.frame(chr = random.chr, start = random.start, end = random.end, stringsAsFactors = FALSE);
		}
	
	# flush overhaning regions
	return(x);
	}
