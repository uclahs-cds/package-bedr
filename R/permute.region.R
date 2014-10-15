permute.region <- function(x, stratify.by.chr = FALSE, species = "human", build = "hg19", mask.gaps = FALSE, mask.repeats = FALSE, sort.output = TRUE, is.checked = FALSE, check.zero.based = TRUE, check.chr = TRUE,check.valid = TRUE, verbose = TRUE) {

	if (!is.checked) {
		x <- convert2bed(x, check.zero.based = check.zero.based, check.chr = check.chr, verbose = verbose);
		}

	colnames(x)[1:3] <- c("chr","start","end");

	n.regions    <- nrow(x);
	
	# select the chr to use	
	if (stratify.by.chr) {
		chr.length <- get.chr.length(chr = unique(x$chr));
		}
	else {
		chr.names <- paste0("chr",c(1:22,"X","Y","M"));
		chr.length <- get.chr.length(chr = chr.names);
		}

	# load the masks
	if (mask.gaps) {
		gaps <- query.ucsc(system.file("extdata/gap.txt.gz", package = "bedr"), columns.keep = c("chrom","chromStart","chromEnd"));
		colnames(gaps)[1:3] <- c("chr","start","end");
		}
	
	if (mask.repeats) {
		if (!file.exists("~/bedr/data/rmsk.txt.gz")) {
			catv("The repeatMasker file does not exist.  Either run download.datasets() or query.ucsc(rmsk)\n");
			}
		
		repeats <- query.ucsc("~/bedr/data/rmsk.txt.gz", columns.keep = c("genoName", "genoStart","genoEnd"));
		colnames(repeats)[1:3] <- c("chr","start","end");
		}

	# create the mask bed file
	if (mask.gaps && !mask.repeats) {
		mask <- gaps;
		}
	else if (!mask.gaps && mask.repeats) {
		mask <- repeats;
		}
	else if (mask.gaps && mask.repeats) {
		mask <- snm(rbind(gaps,repeats), check.chr = FALSE, check.zero.based = FALSE, check.valid = FALSE, verbose = FALSE);
		}
	else {
		mask <- NULL;
		}

	# select the chr
	if (stratify.by.chr) {
		random.chr <- x$chr; # not so random!
		}
	else {
		# make the chr sampling probability proportional to the unmasked length
		if (!mask.gaps && !mask.repeats) {
			chr.length$prob   <- (chr.length$length)/sum(as.numeric(chr.length$length)); 
			}
		else if (mask.gaps && !mask.repeats) {
			chr.length$prob   <- (chr.length$length.mapped)/sum(as.numeric(chr.length$length.mapped));
			}
		else if (!mask.gaps && mask.repeats) {
			chr.length$prob   <- (chr.length$length.wo.repeats)/sum(as.numeric(chr.length$length.wo.repeats));
			}
		else if (mask.gaps && mask.repeats) {
			chr.length$prob   <- (chr.length$length.mapped.wo.repeats)/sum(as.numeric(chr.length$length.mapped.wo.repeats));
			}
		
		size.dist    <- x$end - x$start;
		random.chr   <- sample(chr.names, n.regions, replace = TRUE, prob = chr.length$prob); # weighted according to size
		}

	random.start <- integer(n.regions); # just initialize
	random.end   <- integer(n.regions); # just initialize


	# loop over each chr
	for (chr in unique(random.chr)) {
		
		# the size distribution if stratifed by chr
		if (stratify.by.chr) {
			size.dist    <- x[x$chr == chr,"end"] - x[x$chr == chr,"start"];
			}
			
		n.chr.regions    <- sum(random.chr == chr);
		random.size      <- sample(size.dist, n.chr.regions, replace = TRUE);

		# do masked sampling if requested
		if (mask.gaps || mask.repeats) {


#			# create a bit vector the length of the chr to use a mask for sampling
#			mask <- !bit(chr.length[chr.length$chr == chr,"length"]);

#			if (mask.gaps) {
#				# loop over each unmapped region and set the mask to FALSE
#				for (i in 1:nrow(gaps[gaps$chr == chr,])) {
#					gap <- gaps[i,];
#					mask[gap$start:gap$end] <- FALSE;
#					}
#				}
			
#			if (mask.repeats) {
#				# loop over each repeated region and set the mask to FALSE
#				for (i in 1:nrow(repeats[repeats$chr == chr,])) {
#					repeated <- repeats[i,];
#					mask[repeated$start:repeated$end] <- FALSE;
#					}
#				}

			# do the sampling with 0 weights for masked regions
			#random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE, prob = as.logical(mask));
			random.start[random.chr == chr]  <- sample.interval(sum(random.chr == chr), mask[mask$chr == chr, c("start","end")]);
			
			random.end[random.chr == chr]   <- random.start[random.chr == chr] + random.size;
		
			}
		else {
			# do the sampling with even weights
#			random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE);
			random.start[random.chr == chr] <- as.integer(runif(sum(random.chr == chr), min=1, max=chr.length[chr.length$chr == chr,"length"]));
			random.end[random.chr == chr]   <- random.start[random.chr == chr] + random.size;
			#random.start <- sample(chr.length[chr.length$chr == chr,"length"], n.regions, replace = TRUE);
			}

		}
	
	x <- data.frame(chr = random.chr, start = random.start, end = random.end, stringsAsFactors = FALSE);

	if (sort.output) {
		x <- bedr.sort.region(x, check.valid = FALSE, check.zero.based = FALSE, check.chr = FALSE, check.merge = FALSE, verbose = FALSE)
		}
	
	gc();
	# add region masking i.e. exome/centromeres
	# flush/trim overhaning regions
	return(x);
	}
	
sample.interval <- function(n, x) {
	
	# get sampling probability as function of size
	interval.size <- x[,2] - x[,1];
	total.size <- sum(interval.size);
	sampling.probality <- interval.size/total.size;

	# sample rows
	random.rows <- ceiling(runif(n, min = 1, max = nrow(x)));
	random.values <- integer(n);

	# sample from the intervals
	for (row in unique(random.rows)) {
		n.rows <- sum(random.rows == row);
		random.values[random.rows == row] <- ceiling(runif(n.rows, min = x[row,1], max = x[row,2]));
		}

	return(random.values);
	}


# get N chr size
#for (i in 1:nrow(a) ) {a[i,"length.mapped"] <- nchar(gsub("[^N]","",get.fasta(paste0(a[i,"chr"],":1-",a[i,"length"]),check.chr=F,check.valid=F,check.sort=F,check.merge=F)[1,2])) }  
