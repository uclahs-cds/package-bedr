context("determine.input")

test.that("check that input format is correctly identified", {

	regions <- get.example.regions()
	region.a.bed.df1 <- index2bed(regions$a)
	region.a.bed.df2 <- index2bed(regions$a)
	colnames(region.a.bed.df2) <- c("a","b","c")
	region.a.index.df1 <- data.frame(index=regions$a, score = 1:length(regions$a), stringsAsFactors=F)
	region.a.index.df2 <- data.frame(matrix(ncol=3,nrow=length(regions$a)), row.names=regions$a, stringsAsFactors=F)

	# index
	expect.equal(determine.input(regions$a, verbose = F), 0);

	# bed
	expect.equal(determine.input(region.a.bed.df1, verbose = F), 1) # df with correct names
	expect.equal(determine.input(as.matrix(region.a.bed.df1), verbose = F), 1) # matrix with correct names
	expect.equal(determine.input(region.a.bed.df2, verbose = F), 1) # df with incorrect names

	# column index
	expect.equal(determine.input(region.a.index.df1, verbose = F), 2);

	# row index 
	expect.equal(determine.input(region.a.index.df2, verbose = F), 3);

	expect.equal(determine.input(as.matrix(region.a.bed.df2), verbose = F), 4) # matrix with incorrect names fails due to string conversion
	expect.equal(determine.input(as.matrix(regions$a), verbose = F), 4); # need to be more explicit
	expect.equal(determine.input(NA, verbose = F), 4) # a vector but it doesn't look like an index
	

	})
