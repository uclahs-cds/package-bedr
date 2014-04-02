permute_region <- function(x, stratify.by.chr = FALSE, build = "hg19", mask.include = NULL, mask.exclude = NULL, is.checked = FALSE, check.zero.based = TRUE, check.chr = TRUE, verbose = TRUE) {

	if (!is.checked) {
		x <- convert2bed(x, check.zero.based = check.zero.based, check.chr = check.chr, verbose = verbose);
		}

	colnames(x)[1:3] <- c("chr","start","end");
	chr.length <- get_chr_length(chr = unique(x$chr));

#	chr.length$prob   <- (chr.length$length-chr.length.unmapped)/sum(as.numeric(chr.length$length));
	chr.length$prob   <- (chr.length$length)/sum(as.numeric(chr.length$length));

	if (stratify.by.chr) {
		for (chr in  unique(x$chr)) {
			size.dist    <- x[x$chr == chr,"end"] - x[x$chr == chr,"start"];
			n.regions    <- length(size.dist);
			random.size  <- sample(size.dist, n.regions, replace = TRUE);
			random.start <- sample(chr.length[chr.length$chr == chr,"length"], n.regions, replace = TRUE);
			random.end   <- random.start + random.size;
			x[x$chr == chr, "start"] <- random.start;
			x[x$chr == chr, "end"]   <- random.end;
			}
		}
	else {
		size.dist    <- x$end - x$start;
		n.regions    <- length(size.dist);
		random.size  <- sample(size.dist, n.regions, replace = TRUE);
		random.chr   <- sample(chr.length$chr, n.regions, replace = TRUE, prob = chr.length$prob); # weighted according to size
		random.start <- integer(n.regions);

		for (chr in unique(random.chr)) {
			random.start[random.chr == chr] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.chr == chr), replace = TRUE);
#			repeat {
	#			random.start.base <- get_fasta(data.frame(chr=random.chr,start=random.start, end=random.end))[,2];
		#		if (sum(random.start.base == "N")==0) break;
#				random.start[random.start.base == "N"] <- sample(chr.length[chr.length$chr == chr,"length"], sum(random.start.base == "N"), replace = TRUE);
#				}
			}
		random.end   <- random.start + random.size;
		x <- data.frame(chr = random.chr, start = random.start, end = random.end, stringsAsFactors = FALSE);
		}

	# add region masking i.e. exome/centromeres
	# flush/trim overhaning regions
	return(x);
	}
	
# get N chr size
#for (i in 1:nrow(a) ) {a[i,"length.mapped"] <- nchar(gsub("[^N]","",get_fasta(paste0(a[i,"chr"],":1-",a[i,"length"]),check.chr=F,check.valid=F,check.sort=F,check.merge=F)[1,2])) }  
