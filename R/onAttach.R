.onAttach <- function(libname, pkgname) {
	packageStartupMessage(
		paste0("\n\n######################\n"),
		paste0("#### bedr v", utils::packageVersion("bedr"), " ####\n"),
		paste0("######################\n\n"),
		"checking binary availability...\n",
		paste(utils::capture.output(invisible(check_binary("bedtools"))), collapse = "\n"), "\n",
		paste(utils::capture.output(invisible(check_binary("bedops"))), collapse = "\n"), "\n",
		paste(utils::capture.output(invisible(check_binary("tabix"))), collapse = "\n"), "\n",
		"tests and examples will be skipped on R CMD check if binaries are missing\n"
		);
	}

