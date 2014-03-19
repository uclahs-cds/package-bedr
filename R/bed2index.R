bed2index <- function(x, sort = TRUE) {
	index <- paste(x[,c(1,2,3)], collapse = ":");
	if (sort) {
		index <- sort_region(index);
		}
	index;
	}
