#' refimpact: API wrapper for the UK REF 2014 Impact Case Studies Database
#'
#' This package provides wrapper functions around the UK Research Excellence
#' Framework 2014 Impact Case Studies Database API
#' (\url{http://impact.ref.ac.uk/}). The database contains relevant publication
#' and research metadata about each case study as well as several paragraphs of
#' text from the case study submissions. Case studies in the database are
#' licenced under a CC-BY 4.0 licence
#' (\url{http://creativecommons.org/licenses/by/4.0/legalcode}).
#'
#' To get started, see \code{\link{ref_get}} and read the vignette using
#' \code{vignette('refimpact')}.
#'
#' @docType package
#' @name refimpact
NULL

#' Table of all REF Impact Case Study tags.
#'
#' This table contains the complete set of REF Impact Case Study tags, saving
#' the user the effort of iteratively querying the API for each tag type.
#'
#' @format A data frame with 9,400 rows and 4 variables:
#' \describe{
#'   \item{ID}{integer, the Tag ID for use in the SearchCaseStudies method}
#'   \item{Name}{string, the name of the tag}
#'   \item{TypeID}{integer, the Tag Type ID used in the ListTagValues method}
#'   \item{TagType}{string, the Tag Type for each tag}
#' }
#' @source \url{http://impact.ref.ac.uk/}
"ref_tags"
