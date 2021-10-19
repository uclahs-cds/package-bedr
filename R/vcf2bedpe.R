# vcf2bedpe

vcf2bedpe <- function(x, filename = NULL, header = FALSE, verbose = TRUE) {
  catv('CONVERT VCF TO BEDPE\n')
  if (!is.null(attr(x, 'vcf')) && attr(x, 'vcf') && all(names(x) == c('header','vcf'))) {
    x <- x$vcf;
  } else {
    catv(' * This is not an vcf!\n')
    stop();
  }
  # use UCSC chromosome convention and subtract one position for start
  x$CHROM <- gsub('chr', '', x$CHROM);
  x$POS <- x$POS - 1;
  if (!'SVTYPE' %in% names(x)) {
    stop('SVTYPE column must exist in VCF file');
  }
  # define columns for bedpe
  bedpe.cols <- data.frame(
    CHROM_A = character(0),
    START_A = numeric(0),
    END_A = numeric(0),
    CHROM_B = character(0),
    START_B = numeric(0),
    END_B = numeric(0),
    ID = character(0),
    QUAL = character(0),
    STRAND_A = character(0),
    STRAND_B = character(0),
    SVTYPE = character(0)
    );
  # Convert simple breakends with no MATEID
  simple.bp <- subset(x, x$SVTYPE != 'BND' & is.na(x$MATEID));
  if (nrow(simple.bp) > 0) {
    catv('PROCESSING SIMPLE BREAKENDS\n')
    coordsA <- adjust.coordinates(simple.bp, 'CIPOS', simple.bp$POS, simple.bp$POS);
    coordsB <- adjust.coordinates(simple.bp, 'CIEND', simple.bp$END, simple.bp$END);
    name <- get.bedpe.id(simple.bp);
    if (!'CHR2' %in% names(simple.bp)) {
      # simple breakpoints are intrachromosomal; CHR2 = CHROM
      simple.bp$CHR2 <- simple.bp$CHROM;
    }
    
    simple.bedpe <- data.frame(
      CHROM_A = simple.bp$CHROM,
      START_A = coordsA$start,
      END_A = coordsA$end,
      CHROM_B = gsub('chr', '', simple.bp$CHR2),
      START_B = coordsB$start,
      END_B = coordsB$end,
      ID = name,
      QUAL = ifelse(is.na(simple.bp$QUAL), '.', simple.bp$QUAL),
      STRAND_A = rep('+', length(simple.bp$CHROM)),
      STRAND_B = rep('_', length(simple.bp$CHR2)),
      SVTYPE = simple.bp$SVTYPE
      );
  } else {
    # assign empty bedpe
    simple.bedpe <- bedpe.cols;
  }
  # Convert paired breakends with MATEID
  bnd.bp <- subset(x, x$SVTYPE == 'BND');
  if (nrow(bnd.bp > 0)) {
    catv('PROCESSING BND BREAKENDS\n')
    rownames(bnd.bp) <- bnd.bp$ID;
    if ('MATEID' %in% names(bnd.bp)) {
      bnd.bp <- subset(bnd.bp, !is.na(bnd.bp$MATEID));
      bnd_pair <- list();
      for (id in rownames(bnd.bp)) {
        if (!id %in% bnd_pair) {
          bnd_pair[[id]] <- bnd.bp[id, 'MATEID'];
        }
      }
      var <- bnd.bp[names(bnd_pair), ]; 
      mates <- bnd.bp[unlist(unname(bnd_pair)),];
      if (!'STRAND' %in% names(bnd.bp) & 'MATESTRAND' %in% names(bnd.bp)) {
        # for delly v0.7.8 because the INFO:MATESTRAND is read while the INFO:STRAND is not 
        # STRAND is not in the header so it is not read by bedr
        var$STRAND <- mates$MATESTRAND;
        mates$STRAND <- var$MATESTRAND;
      }
      name <- get.bedpe.id(var);
      coordsA <- adjust.coordinates(var, 'CIPOS', var$POS,  var$POS);
      coordsB <- adjust.coordinates(mates, 'CIPOS', mates$POS, mates$POS);
      strandA <- get.strand(var);
      strandB <- get.strand(mates);
      svtype <- ifelse(!is.null(var$SIMPLE_TYPE), var$SIMPLE_TYPE, 'BND');
      bnd.bedpe <- data.frame(
        CHROM_A = var$CHROM,
        START_A = coordsA$start,
        END_A = coordsA$end,
        CHROM_B = mates$CHROM,
        START_B = coordsB$start,
        END_B = coordsB$end,
        ID = name,
        QUAL = var$QUAL,
        STRAND_A = strandA,
        STRAND_B = strandB,
        SVTYPE = svtype
        );
      } else {
        stop('MATEID is not present in the VCF file INFO field');
        }
  } else {
    bnd.bedpe <- bedpe.cols;
  }
  bedpe_df <- rbind(simple.bedpe, bnd.bedpe);
  bedpe_df <- bedpe_df[with(bedpe_df, order(CHROM_A, START_A)), ];
  if (!is.null(filename)) {
    write.table(bedpe_df,
                file = filename,
                col.names = header,
                row.names = FALSE,
                sep = '\t',
                quote = FALSE
                );
  }
  return(bedpe_df);
}
     