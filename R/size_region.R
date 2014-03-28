size_region <- function(x, zero.based = TRUE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, verbose = TRUE) {

	x <- convert2bed(x, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, check.sort = FALSE, check.merge = FALSE, verbose = verbose);
	
	size <- x$end - x$start;
	if (!zero.based) size <- size + 1;
	
	return(size)
	}


