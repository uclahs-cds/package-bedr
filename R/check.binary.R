# The bedtools package is copyright (c) 2013 Ontario Institute for Cancer Research (OICR)
# This package and its accompanying libraries is free software; you can redistribute it and/or modify it under the terms of the GPL
# (either version 1, or at your option, any later version) or the Artistic License 2.0.  Refer to LICENSE for the full license text.
# OICR makes no representations whatsoever as to the SOFTWARE contained herein.  It is experimental in nature and is provided WITHOUT
# WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE OR ANY OTHER WARRANTY, EXPRESS OR IMPLIED. OICR MAKES NO REPRESENTATION
# OR WARRANTY THAT THE USE OF THIS SOFTWARE WILL NOT INFRINGE ANY PATENT OR OTHER PROPRIETARY RIGHT.
# By downloading this SOFTWARE, your Institution hereby indemnifies OICR against any loss, claim, damage or liability, of whatsoever kind or
# nature, which may arise from your Institution's respective use, handling or storage of the SOFTWARE.
# If publications result from research using this SOFTWARE, we ask that the Ontario Institute for Cancer Research be acknowledged and/or
# credit be given to OICR scientists, as scientifically appropriate.

check.binary <- function(x = "bedtools", verbose = TRUE) {

	if (x == "bedtools") {
		default.path <- "/oicr/local/analysis/sw/bedtools/2.18.2/bin";
		git.url <- "https://github.com/arq5x/bedtools2";
		}
	else if (x == "bedops") {
		default.path <- "/oicr/local/boutroslab/sw/bedops/2.2.0/bin";
		git.url <- "https://github.com/alexpreynolds/bedops";
		}
	else if (x == "tabix") {
		default.path <- "/oicr/local/analysis/sw/tabix/tabix-0.2.6";
		git.url <- "https://github.com/samtools/tabix";
		
		}
	else {
		default.path <- "";
		git.url <- "";
		}

	catv(paste0("  * Checking path for ", x, "... ") );

	# check if binary is in path
	if (Sys.which(x) == "") {
		catv(paste0("FAIL\n") );
		path <- Sys.getenv("PATH");
		if (file.exists(default.path)) {
			Sys.setenv(PATH=paste0(path,":",default.path));
			catv(paste0("  * Checking default locations for ", x, "... PASS\n    ", default.path, "\n") );
			}
		else {
			catv(paste0("  * Checking default locations for ", x, "... FAIL\n    ", default.path, "\n") );
			if (git.url != "") {
				catv(paste0("    Download: ", git.url));
				}
			return(0);
			}
		}
	else {
		catv(paste0("PASS\n    ", Sys.which(x), "\n") );
		}

	return(1);
	}
