
<!-- README.md is generated from README.Rmd. Please edit that file -->
refimpact
=========

[![Build Status](https://travis-ci.org/ropensci/refimpact.svg?branch=master)](https://travis-ci.org/ropensci/refimpact) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/dhg4rs9s3f3n1wj6/branch/master?svg=true)](https://ci.appveyor.com/project/perrystephenson/refimpact-vc6tf/branch/master) [![codecov](https://codecov.io/gh/ropensci/refimpact/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/refimpact) [![](https://ropensci.org/badges/78_status.svg)](https://github.com/ropensci/onboarding/issues/78) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/refimpact)](https://CRAN.R-project.org/package=refimpact)

**refimpact** provides an API wrapper for the UK Research Excellence Framework 2014 Impact Case Studies Database. You can find more information about this database at <http://impact.ref.ac.uk/CaseStudies/>.

The data may be of interest to you if you are interested in:

-   text mining
-   directed graphs
-   policies for research funding

Case studies in the database are licenced under a CC-BY 4.0 license. The full license can be found [here](https://creativecommons.org/licenses/by/4.0/legalcode) and a more user-friendly version of the license can be be obtained [here](https://creativecommons.org/licenses/by/4.0/).

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

Installation
------------

### Install from CRAN

``` r
install.packages("refimpact")
```

### Install from Github

``` r
install.packages("devtools")
devtools::install_github("perrystephenson/refimpact")
```

Usage
-----

See the vignette:

``` r
vignette("refimpact")
```

More Information
----------------

For more information about a specific function you can use the help commands (for example `?ref_get`).

To raise bug reports and issues, please use the issue tracker in Github.

[![ropensci\_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)
