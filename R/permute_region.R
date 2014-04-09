permute_region <- function(x, stratify.by.chr = FALSE, build = "hg19", mask.gaps = FALSE, mask.repeats = FALSE, sort.output = TRUE, is.checked = FALSE, check.zero.based = TRUE, check.chr = TRUE, verbose = TRUE) {

	if (!is.checked) {
		x <- convert2bed(x, check.zero.based = check.zero.based, check.chr = check.chr, verbose = verbose);
		}

	colnames(x)[1:3] <- c("chr","start","end");
	chr.length <- get_chr_length(chr = unique(x$chr));

	if (mask.gaps) {
		gaps <- query_ucsc(system.file("extdata/gap.txt.gz", package = "bedr"))[,-1];
		}
	
	if (mask.repeats) {
		if (!file.exists("~/bedr/data/rmsk.txt.gz")) {
			catv("The repeatMasker file does not exist.  Either run download_datasets() or query_ucsc('rmsk')\n");
			}
		
		repeats <- query_ucsc("~/bedr/data/rmsk.txt.gz");
		}

	colnames(gaps)[1:3] <- c("chr","start","end");

	if (stratify.by.chr) {
		random.chr <- x$chr; # not so random!
		}
	else {
		chr.length$prob   <- (chr.length$length-chr.length.unmapped)/sum(as.numeric(chr.length$length)); # select repeat/gaps if requested
		#chr.length$prob   <- (chr.length$length)/sum(as.numeric(chr.length$length)); # should use unmasked length, not calced for all chr

		random.chr   <- sample(chr.length$chr, n.regions, replace = TRUE, prob = chr.length$prob); # weighted according to size
		}

	# loop over each chr
	for (chr in unique(random.chr)) {
		
		if (stratify.by.chr) {
			size.dist    <- x[x$chr == chr,"end"] - x[x$chr == chr,"start"];
			}
		else {
			size.dist    <- x$end - x$start;
			}
		
		n.regions    <- length(size.dist);
		random.size  <- sample(size.dist, n.regions, replace = TRUE);
		random.start <- integer(n.regions); # just initialize
		
		# do masked sampling if requested
		if (mask.gaps || mask.repeats) {
			# create a bit vector the length of the chr to use a mask for sampling
			mask <- !bit(chr.length[chr.length$chr == chr,"length"]);

			if (mask.gaps) {
				# loop over each unmapped region and set the mask to FALSE
				for (i in 1:nrow(gaps[gaps$chr == chr,])) {
					gap <- gaps[i,];
					mask[gap$start:gap$end] <- FALSE;
					}
				}
			
			if (mask.repeats) {
				# loop over each repeated region and set the mask to FALSE
				for (i in 1:nrow(repeats[repeats$chr == chr,])) {
					repeated <- repeats[i,];
					mask[repeated$start:repeated$end] <- FALSE;
					}
				}

			# do the sampling with 0 weights for masked regions
			random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE, prob = as.logical(mask));
		
			}
		else {
			# do the sampling with even weights
			random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE);
			#random.start <- sample(chr.length[chr.length$chr == chr,"length"], n.regions, replace = TRUE);
			}

		random.end   <- random.start + random.size;
		x[x$chr == chr, "start"] <- random.start;
		x[x$chr == chr, "end"]   <- random.end;

		x <- data.frame(chr = random.chr, start = random.start, end = random.end, stringsAsFactors = FALSE);
		}

	rm(mask);
	gc();

	if (sort.output) {
		x <- sort_region(x, check.valid = FALSE, check.zero.based = FALSE, check.chr = FALSE, check.merge = FALSE, verbose = FALSE)
		}
	
	
	# add region masking i.e. exome/centromeres
	# flush/trim overhaning regions
	return(x);
	}
	
# get N chr size
#for (i in 1:nrow(a) ) {a[i,"length.mapped"] <- nchar(gsub("[^N]","",get_fasta(paste0(a[i,"chr"],":1-",a[i,"length"]),check.chr=F,check.valid=F,check.sort=F,check.merge=F)[1,2])) }  
