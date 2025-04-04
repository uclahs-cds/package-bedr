# bedr 1.1.3 (2025-04-04)


## Added

- Add `method` argument to `in.region` function

## Changed

- Update changelog to Markdown `NEWS.md` format
- Use updated `renv` GitHub action for `R CMD check`
- Rename internal helper function `parse.vcf.header()` to `prep.vcf.header()` to avoid naming conflict with base R `parse()` S3 method.

## Fixed

- Replace outdated `autostart` in `fread` with `skip`.
- Fix cross-reference format in manual
- Update GitHub links


# bedr 1.1.2 (2024-01-24)


## Added

- Add LICENSE.md to repository
- Update DESCRIPTION to include URL and BugReports links


# bedr 1.1.1 (2023-08-24)


## Changed

- Update CI/CD action

## Removed

- Remove unnecessary package manual file


# bedr 1.1.0 (2022-03-01)


## Added

- Add vcf2bedpe module to convert structural variant calls obtained from Manta, GRIDSS and Delly v0.7.8


# bedr 1.0.7 (2019-04-01)


## Changed

- forced vcf2bed not to print genomic coordinates in R scientific notation for interoperability with other processors


# bedr 1.0.6 (2019-01-12)


## Fixed

- Updated support for tabix version >1.1. tabix deprecated option -B is now replaced with -R <regions file>


# bedr 1.0.5


## Fixed

- fixed incorrect ordering of chromosome table returned by get.chr.length() - [rolled back]


# bedr 1.0.4 (2017-10-12)


## Changed

- Added rmarkdown in Suggests section
- Parameterised test.region.similarity() with gaps.file and repeats.file to support custom files
- Exposed utility function bed2index() via NAMESPACE to support its direct usage

## Fixed

- Fixed bug when bedtools 'coverage' output is post-processed in bedr
- Fixed is.valid.seq() to comply with inputs and outputs as described in docs


# bedr 1.0.3 (2016-08-23)


## Changed

- Standardised function name; renamed snm() to bedr.snm.region()
- Listed SystemRequirements to the package metadata
- Added support for Human hg38 genome assembly


# bedr 1.0.2 (2015-09-21)


## Fixed

- Fixed compatibility with data.table >= v1.9.6 for data.table::fread() call 


# bedr 1.0.1 (2015-09-05)


## Fixed

- Fixed sort --version command as Solaris does not support --version which is GNU specific


# bedr 1.0.0 (2015-09-03)

## Added

- Initial release
