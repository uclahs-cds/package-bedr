
bed2vcf <- function(x, filename = NULL, zero.based = TRUE, header = NULL, fasta = NULL) {

	if (is.null(header)) header <- list();

	is.valid <- is_valid_region(x);

	header.defaults <- list(fileformat = "VCFv4.1", fileDate = format(Sys.time(),  "%Y-%M-%d"), source = "bedr", reference = fasta );
	header <- modifyList(header, header.defaults);


	vcf <- data.frame( x$chr, pos = x$start + 1, ID = NA, REF = NA, QUAL = NA, FILTER = NA, INFO = NA,  stringsAsFactors = FALSE);

	default.vcf.field.names <- c("ID","ALT","QUAL","FILTER","INFO","FORMAT")
	default.vcf.fields <- data.frame(x[,c(default.vcf.field.names, tolower(default.vcf.field.names))], stringsAsFactors = FALSE);
	
	if ("REF" %in% default.vcf.field.names) {
		vcf$REF <- x$REF;
		}
	else {
		vcf$REF <- get_fasta(x, fasta = fasta);
		}

	for (default in default.vcf.field.names[default.vcf.field.names %in% colnames(x)]) {
		vcf[,default] <- x[,default];
		}

	vcf <- list(header = header, vcf = vcf)

	# replace this by write_vcf
	if (!is.null(filename))

		if (!is.null(header)) {
			for (i in 1:length(header)) {
				
				if (length(dim(header[[i]])==1)) {
					cat(paste("##",names(header)[i]), "=", header[[i]], "\n", file = filename);
					}
				else {
					header[[i]] <- apply(header[[i]], 1, function(x,name) {paste0(name, "=", x)}, colnames(header[[i]]));
					header[[i]] <- apply(header[[i]], 2, function(x,name) {paste0("##",name,"<",paste(x,collapse=","),">")}, names(header)[i]);
					write.table(header[[i]], quote = FALSE, sep = "", row.names = FALSE, append = TRUE);
					}
			}

		cat("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO", file = filename);
		write.table(vcf,filename,row.names = FALSE, sep = "\t", quote = FALSE);
		}
	else {
		return(vcf);
		}
	}
