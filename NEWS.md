# bedr 1.1.2


## Added

- Add LICENSE.md to repository
- Update DESCRIPTION to include URL and BugReports links

## Changed

- Update changelog to Markdown `NEWS.md` format 


# bedr 1.1.1


## Changed

- Update CI/CD action

## Removed

- Remove unnecessary package manual file


# bedr 1.1.0


## Added

- Add vcf2bedpe module to convert structural variant calls obtained from Manta, GRIDSS and Delly v0.7.8


# bedr 1.0.7


## Changed

- forced vcf2bed not to print genomic coordinates in R scientific notation for interoperability with other processors


# bedr 1.0.6


## Fixed

- Updated support for tabix version >1.1. tabix deprecated option -B is now replaced with -R <regions file>


# bedr 1.0.5


## Fixed

- fixed incorrect ordering of chromosome table returned by get.chr.length() - [rolled back]


# bedr 1.0.4


## Changed

- Added rmarkdown in Suggests section
- Parameterised test.region.similarity() with gaps.file and repeats.file to support custom files
- Exposed utility function bed2index() via NAMESPACE to support its direct usage

## Fixed

- Fixed bug when bedtools 'coverage' output is post-processed in bedr
- Fixed is.valid.seq() to comply with inputs and outputs as described in docs


# bedr 1.0.3


## Changed

- Standardised function name; renamed snm() to bedr.snm.region()
- Listed SystemRequirements to the package metadata
- Added support for Human hg38 genome assembly


# bedr 1.0.2


## Fixed

- Fixed compatibility with data.table >= v1.9.6 for data.table::fread() call 


# bedr 1.0.1


## Fixed

- Fixed sort --version command as Solaris does not support --version which is GNU specific


# bedr 1.0.0

## Added

- Initial release
