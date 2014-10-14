bed2vcf <- function(x, filename = NULL, zero.based = TRUE, header = NULL, fasta = NULL) {

	if (is.null(header)) header <- list();

	# add check.valid if
	is.valid <- is.valid.region(x);
	x <- convert2bed(x);

	header.defaults <- list(fileformat = "VCFv4.1", fileDate = format(Sys.time(),  "%Y-%M-%d"), source = "bedr", reference = fasta );
	header <- modifyList(header.defaults, header);

	vcf <- data.frame( CHROM = x$chr, POS = x$start + 1, ID = NA, REF = NA, QUAL = NA, FILTER = NA, INFO = NA,  stringsAsFactors = FALSE);

	default.vcf.field.names <- c("ID","ALT","REF", "QUAL","FILTER","INFO","FORMAT");
	default.vcf.field.names <- default.vcf.field.names[default.vcf.field.names %in% colnames(x)];

	if (!is.null(default.vcf.field.names)) {
		default.vcf.fields <- data.frame(x[,default.vcf.field.names], stringsAsFactors = FALSE);
		}
	else {
		default.vcf.fields <- data.frame(x[,default.vcf.field.names], stringsAsFactors = FALSE);
		}

	if ("REF" %in% default.vcf.field.names) {
		vcf$REF <- x$REF;
		}
	else {
		vcf$REF <- get.fasta(x, fasta = fasta)$sequence;
		}

	for (default in default.vcf.field.names[default.vcf.field.names %in% colnames(x)]) {
		vcf[,default] <- x[,default];
		}

	vcf <- list(header = header, vcf = vcf);
	attr(vcf, "vcf") <- TRUE;

	# write.vcf
	if (!is.null(filename)) {
		write.vcf(vcf, filename = filename);
		return();
		}
	else {
		return(vcf);
		}
	}
