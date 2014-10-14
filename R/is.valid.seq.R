is.valid.seq <- function(x, querySeq, fasta = NULL, strand = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, check.merge = TRUE, verbose = TRUE){

	fastaSeq <- get.fasta(x, fasta = fasta, strand = strand, check.zero.based = check.zero.based, check.chr = check.chr, check.valid = check.valid, check.sort = check.sort, check.merge = check.merge, verbose = verbose);

	querySeq == fastaSeq;
	}
