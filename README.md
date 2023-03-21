# bedr

1. [Description](#description)
2. [Installation](#installation)
3. [Resources](#resources)
4. [Getting help](#getting-help)
5. [Contributors](#contributors)
6. [Citation information](#citation-information)
7. [License](#license)

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
    author = {Syed Haider and Daryl Waggott and Emilie Lalonde and Clement Fung and Fei-Fei Liu and Paul C. Boutros},
  }
```

## License

Author: Syed Haider, Daryl Waggott, Emilie Lalonde, Clement Fung, Helena Winata, Dan Knight, Takafumi Yamaguchi, Nicholas Wang & Paul C. Boutros (PBoutros@mednet.ucla.edu)

bedr is licensed under the GNU General Public License version 2. See the file LICENSE.md for the terms of the GNU GPL license.

bedr is a R package for genomic region processing using tools such as `BEDTools`, `BEDOPS`, and `Tabix`.

Copyright (C) 2014-2018 Ontario Institute for Cancer Research and 2018-2023 University of California Los Angeles ("Boutros Lab") All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
