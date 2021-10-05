# get STRAND from INFO or ALT field

get.strand <- function(df) {
  strand <- rep('+', nrow(df));
  if ('STRAND' %in% names(df)) { 
    strand <- df$STRAND;
  } else if (any(grepl('\\]|\\[', df$ALT))) {
    strand[grepl('\\[.*\\[', df$ALT)] <- '-';
  } else {
    catv('STRAND information is not recorded in INFO:STRAND or ALT field. Returning default: + ')
  }
  return(strand);
} 
