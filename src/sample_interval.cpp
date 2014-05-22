#include <RcppArmadilloExtensions/sample.h>
// [[Rcpp::depends(RcppArmadillo)]]

#include <algorithm>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector sample_interval(NumericMatrix x, int n) {

 // #include <Rcpp.h>
 
	// number of intervals
	int nrows = x.nrow();

	// interval sizes
	NumericVector intervalSize = x(_,1) - x(_,0);
//	intervalSize = as<NumericVector>(intervalSize);

	// interval sampling probability
	double totalSize = sum(intervalSize);
	NumericVector samplingProbability = intervalSize / totalSize;

	// row sampling
//	IntegerVector randomRows = ceil(runif(n, 0, x.nrow()));
	IntegerVector rowNumbers = seq_len(nrows) - 1; // starts at zero?
	IntegerVector randomRows = RcppArmadillo::sample(rowNumbers, n, true, samplingProbability);

	// loop over sampled rows
	IntegerVector uniqueRows  = unique(randomRows);
	IntegerVector randomValues(n);
	int nUniqueRows = uniqueRows.size();
//	for (int i = 0; i < nUniqueRows; i++) {
	IntegerVector test;
	
	// loop over unique values of sampled rows
	for (IntegerVector::iterator row = uniqueRows.begin(); row != uniqueRows.end(); ++row) {

		// the number times a row was sampled.  Is there no function to sum a logical vector?
		LogicalVector isRow = randomRows == *row;
		int nRowSampled = 0;
		for(int i = 0; i < isRow.size(); i++) {
			if(x[i] == TRUE) {
			nRowSampled++;
			}
		}

		// randomly sample from interval
//		randomValues(randomRows == row*) = ceil(runif(nrows, x(row*,0), x(row*,1)));
		NumericVector RandomFloats nrows, x(row*,0), x(row*,1))
		test  = ceil(runif(nrows, x(row*,0), x(row*,1)));
//		int xmin = x(*row,0);
//		int max = as<int>nrows;
//		NumericVector cat = runif(nrows, min, max);
//		NumericVector cat = runif(nrows,1,2);

	}

	return test;
//	return randomValues;

}

    //int counter = 0;
    //for(int i = 0; i < x.size(); i++) {
      //  if(x[i] == TRUE) {
        //    counter++;
       // }
//	}
