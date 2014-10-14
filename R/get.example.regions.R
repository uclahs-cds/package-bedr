get.example.regions <- function() {
	# unordered and overlapping
	a <- c("chr1:10-100", "chr1:101-200","chr1:200-210", "chr1:211-212", "chr2:10-50","chr10:50-100", "chr2:40-60","chr20:1-5");

	# nothing special but should overlap with (a)  
	b <- c("chr1:1-10", "chr1:111-250","chr1:2000-2010", "chr2:1-5","chr10:100-150", "chr2:40-60","chr20:6-10");

	# incorrect format start>end, strange chr, longer than expected chr
	d <-  c("chr1:10-100", "chr1:101:200", "chr10:100-101", "1:200-210", "chr2:50-40","chr10:50-50", "chr2:o-60","chr20:1-5x");

	x <- list(a = a, b = b, d = d)

	return(x);
	}

