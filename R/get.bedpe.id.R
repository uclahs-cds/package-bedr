# get BEDPE ID column from VCF

get.bedpe.id <- function(df) {
  name <- df$ID;
  if ('EVENT' %in% names(df)) {
    name <- df$EVENT;
  } else if (any(grepl('^Manta', name))) {
    name <- gsub(':.$', '', df$ID);
  } else if (any(grepl('_[12]$', name))) {
    name <- gsub('_[12]$', '', df$ID);
  }
  return(name);
}