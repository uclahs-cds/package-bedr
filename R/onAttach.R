.onAttach <- function(libname, pkgname) {

	if (file.exists(system.file("config/config.yml", package = "bedr"))) {
		config.bedr <- yaml::yaml.load.file(input = system.file("config/config.yml", package = "bedr"));
		}
	else {
		config.bedr <- list();
		}
	if (file.exists(paste0(Sys.getenv("HOME"), "/bedr/config.yml"))) {
		config.bedr.user <- yaml::yaml.load.file(input = paste0(Sys.getenv("HOME"), "/bedr/config.yml"));
		config.bedr <- modifyList2(config.bedr, config.bedr.user);
		}

	packageStartupMessage(
		paste0("\n\n######################\n"),
		paste0("#### bedr v", utils::packageVersion("bedr"), " ####\n"),
		paste0("######################\n\n"),
		"checking binary availability...\n",
		paste(utils::capture.output(invisible(check.binary("bedtools"))), collapse = "\n"), "\n",
		paste(utils::capture.output(invisible(check.binary("bedops"))), collapse = "\n"), "\n",
		paste(utils::capture.output(invisible(check.binary("tabix"))), collapse = "\n"), "\n",
		"tests and examples will be skipped on R CMD check if binaries are missing\n"
		);
	}

