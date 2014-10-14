bedr.setup <- function(datasets = "all", data.dir = paste0(Sys.getenv("HOME"),"/bedr/data")) {

	config.file <- paste0(Sys.getenv("HOME"),"/bedr/config.txt");
	if (!file.exists(data.dir)) dir.create(data.dir, recursive = TRUE);
	if (!file.exists(config.file)) file.create(config.file);

	config.bedr$data.dir <- data.dir;
	cat(as.yaml(config.bedr), file = config.file, append = TRUE);

	download.datasets(datasets, data.dir);
	
	return();
	}
