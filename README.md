# refimpact

[![Build Status](https://travis-ci.org/perrystephenson/refimpact.svg?branch=master)](https://travis-ci.org/perrystephenson/refimpact)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/perrystephenson/refimpact?branch=master&svg=true)](https://ci.appveyor.com/project/perrystephenson/refimpact)
[![codecov](https://codecov.io/gh/perrystephenson/refimpact/branch/master/graph/badge.svg)](https://codecov.io/gh/perrystephenson/refimpact)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/refimpact)](https://CRAN.R-project.org/package=refimpact)

**refimpact** provides an API wrapper for the UK Research Excellence Framework
2014 Impact Case Studies Database. You can find more information about this
database at
[http://impact.ref.ac.uk/CaseStudies/](http://impact.ref.ac.uk/CaseStudies/).

The data may be of interest to you if you are interested in:

- text mining
- directed graphs
- policies for research funding

Case studies in the database are licenced under a CC-BY 4.0 license. The full
license can be found 
[here](https://creativecommons.org/licenses/by/4.0/legalcode) and a more 
user-friendly version of the license can be be obtained 
[here](https://creativecommons.org/licenses/by/4.0/).

## Installation

### CRAN (not yet published)

``` r
# install.packages("refimpact")
```

### Github

``` r
install.packages("devtools")
devtools::install_github("perrystephenson/refimpact")
```

## Usage

Let's skip the explanations and jump straight in! We'll be using the excellent 
[tibble](https://github.com/hadley/tibble) package by Hadley Wickham to navigate
the data_frame.

``` r
library(refimpact)
library(tibble)
data <- get_case_studies(UoA = 3)
glimpse(data)
View(data) # This only works inside RStudio
```

You will note that a lot of the metadata columns contain nested data structures;
this is entirely intentional. Maintaining the nesting keeps the data within its
intended context, and you can always separate it out later if you like. 
Accessing the nested data is straight-forward using the standard tibble subset
syntax: [[row, column]].

``` r
data[[1, "Continent"]]
```

Using the double [ notation allows you to access the nested data as a data.frame
object - essentially a data.frame within a data_frame. You can still use the 
double [ syntax for accessing normal values, so it's a good habit to get into.

``` r
cat(data[[1, "ImpactDetails"]])
```

The API also provides fairly useful search functionality, and this is replicated
in the refimpact package. You can search on any of the following:

- UoA (Unit of Assessment)
- UKPRN
- tags
- phrase (limited to a single word when using the refimpact package)

Using these search methods (except phrase) requires a unique integer reference 
as an argument - the code below shows some functions to find these references:

``` r
units <- get_units_of_assessment()
ukprn <- get_institutions()
types <- get_tag_types()
value <- get_tag_values(3) # Takes a tag type reference as an argument
```

You can use these as arguments to the `get_case_studies()` function to search
for case studies meeting the criteria; multiple conditions are joined with 
logical `AND`.

``` r
data <- get_case_studies(UoA = 5, UKPRN = 10007774)
```

You can use the same function to retrieve one or more case studies where you 
already know the ID. This cannot be used in conjunction with other search 
arguments.

``` r
ex1 <- get_case_studies(ID = 941)
ex2 <- get_case_studies(ID = c(941, 942, 1014))
```

There is currently no way to download all of the data from the API in a single
API call. The most efficient way to collect all of the data is to iterate
through the list of all Units of Assessment (from `get_units_of_assessment()`) 
and calling `get_case_studies()` for each value.

## More Information

For more information about a specific function you can use the help commands 
(for example `?get_case_studies`). 

To raise bug reports and issues, please use the issue tracker in Github.
