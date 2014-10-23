df2list <- function(x, start.col = 1) {
	end.col <- ncol(x);
    x <- lapply(x[,start.col:end.col], function(x, label){label[x!=0]}, rownames(x));
    return (x);
    }
