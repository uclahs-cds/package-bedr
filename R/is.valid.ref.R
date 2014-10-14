is.valid.ref <- function(x, fasta = NULL, strand = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, check.merge = TRUE, verbose = TRUE){
	# wrapper for vcf
	catv("VCF REF VALIDATION\n")

	x <- vcf2bed(x, other = "REF");
	if (!grepl("chr", x[1,"chr"])) {
		catv(" * The default reference is HG19 which requires 'chr' prefix... FAIL\n");
		catv("   Change the reference i.e. GRCh37 or add the 'chr' prefix\n");
		stop();
		}

	is.valid.seq(x, querySeq = x[[1]]$REF, fasta = fasta, strand = strand, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, check.sort = check.sort, check.merge = check.merge, verbose = verbose)
	}
