.onAttach <- function(libname, pkgname) {

	if (file.exists(system.file("config/config.yml", package = "bedr"))) {
		config_bedr <- yaml::yaml.load_file(input = system.file("config/config.yml", package = "bedr"));
		}
	else {
		config_bedr <- list();
		}
	if (file.exists(paste0(Sys.getenv("HOME"), "/bedr/config.yml"))) {
		config_bedr_user <- yaml::yaml.load_file(input = paste0(Sys.getenv("HOME"), "/bedr/config.yml"));
		config_bedr <- bedr:::modifyList2(config_bedr, config_bedr_user);
		}

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

