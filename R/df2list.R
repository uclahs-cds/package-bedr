df2list <- function(x, start.col = 1) {
    # take df and return a list of rownames where column value is not 0 i.e. missin
	end.col   <- ncol(x);
    x         <- lapply(x[,start.col:end.col], function(x, label){label[x!=0]}, rownames(x));
    }
