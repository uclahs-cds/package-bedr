read_ucsc <- function(x, mirror = "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database", verbose = TRUE) {

	# set the mirror to null if the file has an extension
	if (grepl(".txt.gz$", x)) {
		mirror <- NULL;
		}

	if (!is.null(mirror)) {
		# create the url
		data.file <- paste0(mirror, "/", x, ".txt.gz");

		# create the url/filepath for the sql file
		sql.file <- gsub(".txt.gz", ".sql", data.file);

		# check if the file exists
		if (!file.exists(data.file) || !file.exists(sql.file)) {
			catv("ERROR: Either the data or sql file do not exist.\n");
			stop()
			}

		sql      <- readLines(sql.file);

		}
	else {
		data.file <- x;
		}

	# create the url/filepath for the sql file
	sql.file <- gsub(".txt.gz", ".sql", data.file);
	

	if (grepl("http",mirror)) {
		sql      <- readLines(url(sql.file));
		}
	else {
		}

	# parse sql
	keep <- FALSE;
	table.names <- NULL;
	var.types   <- NULL;
	for ( i in 1:length(sql) ){
		line <- sql[i] 
		if (grepl("^CREATE",line)) {keep <- TRUE;next;}
		if (grepl("^  KEY",line)) break;
		if (keep) { 
			table.name <- gsub("^  `(.*)`.*","\\1", line);
			table.names <- c(table.names, table.name);
			

			if(grepl("int", line)){
				var.type <- "integer";
				}
			else {
				var.type <- "character"
				}
			var.types <- c(var.types,var.type);
			}
		}
	
	if (grepl("http",mirror)) {
		data.con <- gzcon(url(data.file));
		data.raw <- textConnection(readLines(data.con))
		ucsc.table <- read.table(data.raw, as.is = TRUE, sep = "\t", col.names = table.names, colClasses = var.types );
		#ucsc.table <- fread(data.raw, stringsAsFactors = FALSE, sep = "\t",  colClasses = var.types );
		#setNames(ucsc.table, table.names);
		}
	else {
		ucsc.table <- read.table(data.file, as.is = TRUE, sep = "\t", col.names = table.names, colClasses = var.types );
		#ucsc.table <- fread(data.file, stringsAsFactors = FALSE, sep = "\t", colClasses = var.types );
		#setNames(ucsc.table, table.names);
		}

	ucsc.table;
	}

