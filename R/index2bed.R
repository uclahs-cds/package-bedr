index2bed <- function(x) {

	# split the index
	index <- strsplit2matrix(x, split = ":|-");

	# add the colnames
	colnames(index) <- c("chr","start","end");
	index$start     <- suppressWarnings(as.numeric(index$start));
	index$end       <- suppressWarnings(as.numeric(index$end));

	return(index);
	}
