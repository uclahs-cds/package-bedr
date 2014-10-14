process.input <- function(input, tmpDir = NULL, include.names = TRUE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, check.merge = TRUE, verbose = TRUE) {
# takes list of input and creates tmp files for input and returns string of paths

	file.extensions <- c("bed","vcf", "gff","bam", "sam", "csv", "tsv", "txt", "gz")
	input.files   <- list();
	
	if (is.vector(input, mode = "character") || is.data.frame(input)) {
		input  <- list(input);
		}

	# loop over input files/objects
	if (length(input) > 0) {

		for (i in 1:length(input)) {
			catv(paste0(" * Processing input (", i, "): ", names(input)[i], "\n"));

			# check if input is a file
			is.file  <- is.vector(input[[i]]) && length(input[[i]]) == 1  && tools::file.ext(gsub(".gz", "", input[[i]]) ) %in% file.extensions;

			# skip procesing if input is a file
			if (is.file) {
				if (!file.exists(input[[i]])) {
					catv(paste("ERROR:", input[[i]], "does not exist"));
					stop();
					}
				input.file  <- input[[i]];
				}
			else {
				# convert to bed format
				input[[i]] <- convert2bed(input[[i]], set.type = FALSE, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, check.sort = check.sort, check.merge = check.merge, verbose = verbose);

				# create tmp file
				input.file   <- create.tmp.bed.file(input[[i]], names(input)[i], tmpDir);
				}

			attr(input.file, "is.file") <- is.file;
			input.files                 <- c(input.files, list(input.file)); # note the list() to prevent c() from dropping attributes
			}

		# paste the input files together
		if (include.names) {
			commandString  <-  paste(paste(paste("-", names(input), sep = ""), input.files), collapse = " ");
			commandString  <-  gsub(" - ", " ", commandString);
			commandString  <-  gsub("^- ", "", commandString);
			}
		else {
			commandString <- paste(input.files, collapse = " ");
			}
		attr(input.files, "commandString") <- commandString;
		}
	else {
		input.files <- "";
		}

	return(input.files);

	}
