test_region_similarity <- function (x, y, startify.by.chr = FALSE, n = 1e3, mask.gaps = FALSE, mask.repeats = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, verbose = TRUE) {

	is_valid_region(x, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, verbose = verbose);
	is_valid_region(y, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, verbose = verbose);

	jaccard.orig     <- jaccard(x,y, check.chr = FALSE, check.valid = FALSE, check.sort = FALSE, check.merge = FALSE)[1,3]; # larger more similar (0-1)
	reldist.orig     <- reldist(x,y, check.chr = FALSE, check.valid = FALSE, check.sort = FALSE, check.merge = FALSE);# smaller more similar (0-0.5). should be uniform
	reldist.orig.median  <- tail(reldist.orig[cumsum(reldist.orig$count/sum(reldist.orig$count))  <= 0.5,"reldist"], 1); # if uniform should be ~0.25
	reldist.orig.fraction.zero    <- reldist.orig[1,"fraction"]; # the fraction at reldist 0.  if uniform all 50 fractions = 0.02
	reldist.orig.fraction.fifty   <- reldist.orig[50,"fraction"]; # the fraction at reldist 50
	
	jaccard.perm.gt <- 0;
	reldist.perm.median.lt <- 0;
	reldist.perm.fraction.zero.gt <- 0;
	reldist.perm.fraction.fifty.gt <- 0;
	
	catv("PERMUTATION TEST\n")

	#catv(paste0(" * iterator: 0"))
	#backspace <- "\b";

	batch.size <- 20;
	n.batches <- ceiling(n/batch.size);

	if (batch.size > n) batch.size <- n;

	for (i in 1:n.batches) {

		if (i == n.batches) batch <- n %% batch;

	#	catv(paste0(backspace, i));
	#	backspace <- rep("\b", nchar(i));

		# send batches of permutations
		perm.results <- mclapply(list(1:n.batches), iterate_perm, x = x, y = y);

		if (jaccard.perm >= jaccard.orig) jaccard.perm.gt <- jaccard.perm.gt + 1;
		if (reldist.perm.median <= reldist.orig.median)  reldist.perm.median.lt <- reldist.perm.median.lt + 1;
		if (reldist.perm.fraction.zero >= reldist.orig.fraction.zero)  reldist.perm.fraction.zero.gt <- reldist.perm.fraction.zero.gt + 1;
		if (reldist.perm.fraction.fifty >= reldist.orig.fraction.fifty)  reldist.perm.fraction.fifty.gt <- reldist.perm.fraction.fifty.gt + 1;

#		if (i == 100 ) {
#			if (jaccard.perm.gt > 20 && reldist.perm.median.lt > 20) break;
#			}
		}

	jaccard.p <- jaccard.perm.gt / n;
	reldist.median.p <- reldist.perm.median.lt / n;
	reldist.fraction.zero.p   <- reldist.perm.fraction.zero.gt / n;
	reldist.fraction.fifty.p   <- reldist.perm.fraction.fifty.gt / n;

	tests <- c("jaccard_stat", "reldist_median","reldist_fraction_zero","reldist_fraction_50")
	effect.sizes <- c(jaccard.orig, reldist.orig.median, reldist.orig.fraction.zero, reldist.orig.fraction.fifty) 
	empirical.pvalues <- c(jaccard.p, reldist.median.p, reldist.fraction.zero.p, reldist.fraction.fifty.p);
	perm.results <- data.frame(test = tests, effect = effect.sizes, p = empirical.pvalues, stringsAsFactors = FALSE);

	return(list(results = perm.results, n = i, relative_distance = reldist.orig))
	}



iterate_perm <- function(x.region, y.region) {

	x.perm       <- permute_region(x, mask.gaps = mask.gaps, mask.repeats = mask.repeats, is.checked = TRUE, sort.output = TRUE);
	jaccard.perm <- jaccard(x.perm, y, check.chr = FALSE, check.valid = FALSE, check.sort = FALSE, check.merge = FALSE, verbose = FALSE)[1,3];
	reldist.perm <- reldist(x.perm, y, check.chr = FALSE, check.valid = FALSE, check.sort = FALSE, check.merge = FALSE, verbose = FALSE);

	reldist.perm.median   <- tail(reldist.perm[cumsum(reldist.perm$count/sum(reldist.perm$count))  <= 0.5,"reldist"], 1); 
	reldist.perm.fraction.zero     <- reldist.perm[1,"fraction"];
	reldist.perm.fraction.fifty    <- reldist.perm[50,"fraction"];

	if (jaccard.perm >= jaccard.orig) jaccard.perm.gt <- TRUE;
	if (reldist.perm.median <= reldist.orig.median)  reldist.perm.median.lt <- TRUE;
	if (reldist.perm.fraction.zero >= reldist.orig.fraction.zero)  reldist.perm.fraction.zero.gt <- TRUE;
	if (reldist.perm.fraction.fifty >= reldist.orig.fraction.fifty)  reldist.perm.fraction.fifty.gt <- TRUE;

	return(jaccard.perm.gt = reldist.perm.median.lt, reldist.perm.median.lt, reldist.perm.fraction.zero.gt, reldist.perm.fraction.fifty.gt)
	}
