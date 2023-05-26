# bedr

1. [Description](#description)
2. [Installation](#installation)
3. [Usage examples](#usage-examples)
4. [Resources](#resources)
5. [Getting help](#getting-help)
6. [Contributors](#contributors)
7. [Citation information](#citation-information)
8. [License](#license)

## Description

Genomic regions processing using open-source command line tools such as `BEDTools`, `BEDOPS` and `Tabix`.
These tools offer scalable and efficient utilities to perform genome arithmetic e.g indexing, formatting and merging.
bedr API enhances access to these tools as well as offers additional utilities for genomic regions processing.

## Installation

To install the latest public release of bedr from CRAN:

```R
install.packages('bedr');
```

Or to install the latest development version from Github:

```R
# If `devtools` is not already installed, run:
# install.packages('devtools');

devtools::install_github('uclahs-cds/public-R-bedr');
```

## Usage examples

As a suite of tools for genomic interval processing, bedr utilities can be combined to perform powerful genomic arithmetic.
Working examples of some key functions is covered below:

### Sorting and merging

It is recommended to confirm that inputs are sorted to avoid unexpected results and take advantage of optimized algorithms.

```R
# Load bedr library
library('bedr');

regions <- get.example.regions();
region <- regions[[1]];

# Validate region
is.valid <- is.valid.region(region);

# Check if region is already sorted
is.sorted <- is.sorted.region(region);
```

If the region is valid and not already sorted, bedr can be used to sort intervals either lexicographically or naturally:

```R
# Lexicographical sort
region.sort <- bedr.sort.region(region);

# Natural sort
region.sort.natural <- bedr.sort.region(
    region,
    method = 'natural'
    );
```

Where the respective outputs look like:

```R
# region.sort: chr1:10-100 chr1:101-200 chr1:200-210 chr1:211-212 chr10:50-100 chr2:10-50 chr2:40-60 chr20:1-5

# region.sort.natural: chr1:10-100 chr1:101-200 chr1:200-210 chr1:211-212 chr2:10-50 chr2:40-60 chr10:50-100 chr20:1-5
```

Once regions are sorted, bedr supports identification of overlapping redundant regions which can be collapsed to avoid unexpected results during downstream analysis.

```R
# Check if interval is already merged (non-overlapping regions)
is.merged <- is.merged.region(region.sort);

# Merge regions
region.merge <- bedr.merge.region(region.sort);

# region.merge: chr1:10-100 chr1:101-210 chr1:211-212 chr10:50-100 chr2:10-60 chr20:1-5
```

Sort and merge can be combined into one step given that they are typically run as a tandem preprocessing step.

```R
region.snm <- bedr.snm.region(region);
```

The output of the combined step will be the same as if sort and merge was run separately.

### Joining

The join functionality identifies sub-regions of the first set which overlap with the second set of regions, returning a table of chromosome names and coordinates of overlapping sub-region.

```R
region.a <- bedr.snm.region(regions[[1]]);
region.b <- bedr.snm.region(regions[[2]]);

# Joining regions
regions.ab <- bedr.join.region(
    x = region.a,
    y = region.b
    );
```

The above code will generate the following output, containing regions of regions.a in the first column, while any overlapping regions from regions.b are listed in columns 2 to 4 (chr, start, end).
Regions in regions.a with no overlap are encoded as: . and -1

```R
##          index   V4  V5  V6
## 1  chr1:10-100    .  -1  -1
## 2 chr1:101-210 chr1 111 250
## 3 chr1:211-212 chr1 111 250
## 4 chr10:50-100    .  -1  -1
## 5   chr2:10-60 chr2  40  60
## 6    chr20:1-5    .  -1  -1
```

Similarly, another bedr function `bedr.join.multiple.region()` creates an intersect table for multiple sets of regions:

```R
region.c <- bedr.snm.region(regions[[4]]);

bedr.join.multiple.region(
    a = region.a,
    b = region.b,
    c = region.c
    );
```

The generated table lists all the sub-regions and their presence across the three sets of region objects (region.a, region.b, and region.c) passed to the function.
For instance, sub-region chr1:1-10 (column: index) overlaps with 2 region objects (b and c).
This presence is shown as comma separated list in ‘names’ column as well as a truth table in the subsequent columns.
The number of columns representing the truth table will match the number of region objects passed to the function, 3 in this example.

```R
##                       index n.overlaps names a b c
## 1                 chr1:1-10          1     b 0 1 0
## 2               chr1:10-100          1     a 1 0 0
## 3              chr1:101-111          1     a 1 0 0
## 4              chr1:111-210          2   a,b 1 1 0
## 5              chr1:210-211          1     b 0 1 0
## 6              chr1:211-212          2   a,b 1 1 0
## 7              chr1:212-250          1     b 0 1 0
## 8            chr1:2000-2010          1     b 0 1 0
## 9    chr1:36536614-36567843          1     c 0 0 1
## 10   chr1:39531896-39551738          1     c 0 0 1
## 11   chr1:96595818-96615660          1     c 0 0 1
## 12 chr1:106145780-106177820          1     c 0 0 1
## 13 chr1:114839604-114858053          1     c 0 0 1
## 14 chr1:157500398-157528956          1     c 0 0 1
## 15 chr1:157946862-157967135          1     c 0 0 1
## 16 chr1:159613032-159634262          1     c 0 0 1
## 17 chr1:173615144-173638442          1     c 0 0 1
## 18 chr1:182664052-182696092          1     c 0 0 1
## 19 chr1:184743714-184757316          1     c 0 0 1
## 20 chr1:190087700-190109266          1     c 0 0 1
## 21 chr1:204724529-204744802          1     c 0 0 1
## 22 chr1:225534034-225555264          1     c 0 0 1
## 23 chr1:247803076-247824306          1     c 0 0 1
## 24             chr10:50-100          1     a 1 0 0
## 25            chr10:100-150          1     b 0 1 0
## 26                 chr2:1-5          1     b 0 1 0
## 27               chr2:10-40          1     a 1 0 0
## 28               chr2:40-60          2   a,b 1 1 0
## 29                chr20:1-5          1     a 1 0 0
## 30               chr20:6-10          1     b 0 1 0
```

### Subtracting and intersecting

The subtract utility identifies regions that are exclusive to the first region object passed to the function.

```R
region.sub <- bedr.subtract.region(
    x = region.a,
    y = region.b
    );

# region.sub: chr1:10-100 chr10:50-100 chr20:1-5
```

The intersect function identifies sub-regions of first set which overlaps with the second set of regions.

```R
# Check if present in region
region.intersect <- in.region(
    x = region.a,
    y = region.b
    );

# Alternative R-like command
region.intersect <- region.a %in.region% region.b

# region.intersect: FALSE TRUE TRUE FALSE TRUE FALSE
```

For additional utilities and detailed explanations of functions included in `bedr`, see resources listed below.

## Resources

Available resources for bedr include the package [CRAN page](https://cran.r-project.org/web/packages/bedr/index.html), [reference manual](https://cran.r-project.org/web/packages/bedr/bedr.pdf) and [vignette](https://cran.r-project.org/web/packages/bedr/vignettes/Using-bedr.html).

## Getting help

For guidance or support with bedr check out [Discussions](https://github.com/uclahs-cds/public-R-bedr/discussions)

See [Issues](https://github.com/uclahs-cds/public-R-bedr/issues) to submit bugs, suggest new features or view current works

[Pull requests](https://github.com/uclahs-cds/public-R-bedr/pulls) are also open for discussion.

## Contributors

Contributors to this package can be viewed [here](https://github.com/uclahs-cds/public-R-bedr/graphs/contributors) on GitHub.

## Citation information

To cite package `bedr` in publications, use:

Haider, S., Waggott, D., Lalonde, E. et al. A bedr way of genomic interval processing. _Source Code Biol Med_ **11**, 14 (2016). https://doi.org/10.1186/s13029-016-0059-5

A BibTeX entry for LaTeX users is:

```BibTeX
@Article{,
    title = {A bedr way of genomic interval processing},
    journal = {Source Code for Biology and Medicine},
    doi = {10.1186/s13029-016-0059-5},
    url = {https://doi.org/10.1186/s13029-016-0059-5},
    volume = {11},
    number = {14},
    year = {2016},
    month = {December},
    day = {15},
    issn = {1751-0473},
    author = {Syed Haider and Daryl Waggott and Emilie Lalonde and Clement Fung and Fei-Fei Liu and Paul C. Boutros}
  }
```

## License

Author: Syed Haider, Daryl Waggott, Emilie Lalonde, Clement Fung, Helena Winata, Dan Knight, Takafumi Yamaguchi, Nicholas Wang & Paul C. Boutros (PBoutros@mednet.ucla.edu)

bedr is licensed under the GNU General Public License version 2. See the file LICENSE.md for the terms of the GNU GPL license.

bedr is a R package for genomic region processing using tools such as `BEDTools`, `BEDOPS`, and `Tabix`.

Copyright (C) 2014-2018 Ontario Institute for Cancer Research and 2018-2023 University of California Los Angeles ("Boutros Lab") All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
