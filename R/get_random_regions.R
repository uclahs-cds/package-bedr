get_random_regions <- function(n = 10, chr = NULL, species = "human", build = "hg19", size.mean = 10, size.sd = 0.25, mask.gaps = FALSE, mask.repeats = FALSE, sort.output = TRUE, verbose = TRUE) {

	region.size  <- ceiling(rlnorm(n, meanlog = size.mean, sdlog = size.sd));

	if (!is.null(chr)) {
		stratify.by.chr = TRUE;
		x <- data.frame(chr = chr, start = 1, end = region.size, stringsAsFactors = FALSE); # don't worry about the length b/c correct at end
		}
	else {
		x <- data.frame(chr = "chr1",start =  1, end = region.size, stringsAsFActors = FALSE);
		stratify.by.chr = FALSE;
		}

	x <- permute_region(x, stratify.by.chr = stratify.by.chr, species = species, build = build, mask.gaps = mask.gaps, mask.repeats = mask.repeats, sort.output = sort.output, is.checked = TRUE, verbose = verbose);

	if (length(x) > length(n)) {
		x <- head(x, n);
		}

#	x <- paste0(x$chr,":",x$start,"-",x$end);

	return(x);
	}
