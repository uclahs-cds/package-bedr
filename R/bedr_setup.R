
bedr_setup <- function(datasets = "all", data_dir = paste0(Sys.getenv("HOME"),"/bedr/data")) {

	config_file <- paste0(Sys.getenv("HOME"),"/bedr/config.txt");
	if (!file.exists(data_dir)) dir.create(data_dir, recursive = TRUE);
	if (!file.exists(config_file)) file.create(config_file);

	config_bedr$data_dir <- data_dir;
	cat(as.yaml(config_bedr), file = config_file, append = TRUE);

	download_datasets(datasets, data_dir);
	
	return();
	}
