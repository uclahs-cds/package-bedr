snm <- function(x, method = "lexicographical", distance = 0, list.names = TRUE, number = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE,  verbose = TRUE) {
	x <- sort_region(x, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid,  check.merge = F, verbose = verbose);
	x <- merge_region(x, distance = distance, list.names = list.names, number = number, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid,  check.sort = F, verbose = verbose);
	return(x);
	}
