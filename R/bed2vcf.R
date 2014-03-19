
bed2vcf <- function(x, filename = NULL, zero.based = TRUE, header = NULL, fasta = NULL) {

	if (!is.null(fasta)) {
		fasta <- "/oicr/data/genomes/homo_sapiens_mc/UCSC/hg19_random/Genomic/references/fasta/hg19_random.fa";
		reference <- "hg19";
		}

	is.valid <- is_valid_region(x);

	header.defaults <- list(fileformat = "VCFv4.1", fileDate = format(Sys.time(),  "%Y-%M-%d"), source = "bedr", reference = reference );
	header <- modifyList(header, header.defaults);

	if (!is.null(header)) {
		for (i in 1:length(header)) {
			if (length(dim(header[[i]])==1)) {
				cat(paste("##",names(header)[i]), "=", header[[i]], "\n", file = filename)
				}
			else {
				write.table(header[[i]])
				}
			}

		cat("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO", file = filename);
		}


	vcf <- data.frame( x$chr, pos = x$start + 1, ID = NA, REF = NA, QUAL = NA, FILTER = NA, INFO = NA,  stringsAsFactors = FALSE);

	if ("REF" %in% default.vcf.field.names) {
		vcf$REF <- x$REF;
		}
	else {
		vcf$REF <- get_fasta(x, fasta = fasta);
		}

	default.vcf.field.names <- c("ID","ALT","QUAL","FILTER","INFO","FORMAT")
	default.vcf.fields <- data.frame(x[,c(default.vcf.field.names, tolower(default.vcf.field.names))], stringsAsFactors = FALSE);

	for (default in default.vcf.field.names[default.vcf.field.names %in% colnames(x)]) {
		vcf[,default] <- x[,default];
		}

	if (!is.null(filename)) {
		write.table(vcf,filename,row.names = FALSE, sep = "\t", quote = FALSE);
	} else {
		return(vcf);
		}
	}
