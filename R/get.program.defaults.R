get.program.defaults <- function() {

	# template file to search for
	entry.secret = "callerA.vcf.gz";

	# make a list of potential locations for the datasets file
	program.data.dirs <- paste(.libPaths(), "/bedr/extdata/", sep = "");

	# then search all locations
	file.checks <- file.exists( paste(program.data.dirs, "/", entry.secret, sep = "") );

	# check to see if the file was actually found
	if (any(file.checks)) {
		program.data.dir <- program.data.dirs[ order(file.checks, decreasing = TRUE)[1] ];
		}
	else {
		stop("Unable to find callerA.vcf.gz file");
		}
	
	return (
		list(
			"program.data.dir" = program.data.dir
			)
		);
	}
