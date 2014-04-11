#include <RcppArmadilloExtensions/sample.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;

// [[Rcpp::export]]
int sample_interval(int n, IntegerMatrix x) {

 // #include <Rcpp.h>
	// interval size
	IntegerVector intervalSize = x(_,1) - x(_,0);
	
	// interval sampling probability
	double totalSize = sum(intervalSize);
	NumericVector samplingProbality = intervalSize / totalSize;

	// row sampling
//	IntegerVector randomRows = ceil(runif(n, 0, x.nrow()));
	IntegerVector randomRows = RcppArmadillo::sample(x.nrow(), n, TRUE)

	// loop over sampled rows
	IntegerVector uniqueRows  = unique(randomRows);
	int nUniqueRows = uniqueRows.size();
//	for (int i = 0; i < nUniqueRows; i++) {
	
	// initialization
	IntegerVector::iterator it, pos;
	int row, nrows;
	IntegerVector randomValues(n);

	for (it = uniqueRows.begin(); it != uniqueRows.end(); ++it) {
	
		row = *it; 
		nrows = sum(randomRows == row);
		
		randomValues(randomRows == row) = ceil(runif(nrows, min = x(row,1), max = x(row,2)));

	}

	return randomValues;

}
