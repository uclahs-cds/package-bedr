catv <- function(x) {
	verbose <- get("verbose", parent.frame(1))
	if (!exists("verbose")) {
		verbose <- TRUE
		}
	if (verbose) {
		cat(x);
		}
	}
