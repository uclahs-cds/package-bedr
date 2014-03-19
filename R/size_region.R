sizeRegion <- function(x, zero.based = TRUE) {

	x <- convert2bed(x);
	
	size <- x$end - x$start;
	if (!zero.based) size <- size + 1;
	
	return(size)
	}


