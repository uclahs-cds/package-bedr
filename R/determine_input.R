determineInput <- function(x, check.chr = FALSE, verbose = TRUE) {
	# vector index (0), bed (1), index in first column (2), rownmames are index (3), unrecognized(4)

	if (check.chr) {
		pattern = "^chr[0-9XYM]{1,2}:\\d*-\\d*$";
		}
	else {
		pattern = "^.*[0-9XYM]{1,2}:\\d*-\\d*$";
		}

	catv("  * Checking input type... ");

	is.vector.index <- is.vector(x) && grepl(pattern, x[1]);
	if (is.vector.index) {
		catv("PASS\n    Input is in index format\n")
		return(0)
		}

	x <- as.data.frame(x);

	is.bed <- length(colnames(x)>=3) && all(colnames(x)[1:3] == c("chr","start","end"));
	if (is.bed) {
		catv("PASS\n    Input is in bed format\n")
		return(1)
		}

	is.column.index <- colnames(x)[1] == "index" && is.vector(x[,"index"]) && all(grepl(pattern, x[1, "index"]));
	if (is.column.index) {
		catv("PASS\n    Input is tabular with an index column\n")
		return(2)
		}

	# try and guess if no names given first bed then index
	is.bed <- ncol(x)>=3 && all(grepl(pattern, paste0(x[1,1],":",x[1,2],"-",x[1,3])));
	if (is.bed) {
		catv("PASS\n    Input seems to be in bed format but there the chr/start/end column names are missing\n")
		return(1)
		}

	is.rowname.index <- grepl(pattern, rownames(x)[1]);
	if (all(is.rowname.index)) {
		catv("PASS\n    Input is tabular with an index as the rownames\n")
		return(3)
		}

	catv("FAIL\n");

	return(4);
	}
