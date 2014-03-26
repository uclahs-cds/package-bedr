index2bed <- function(x, set.type = TRUE) {

	# split the index
	index <- strsplit2matrix(x, split = ":|-");

	# add the colnames
	colnames(index) <- c("chr","start","end");
	index$start     <- suppressWarnings(as.numeric(index$start));
	index$end       <- suppressWarnings(as.numeric(index$end));

	if (set.type) attr(x, "input.type") <- 1;
	return(index);
	}
