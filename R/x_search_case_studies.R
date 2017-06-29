#' Search and download case studies
#'
#' DEPRECATED - USE ref_get. This function uses the \code{SearchCaseStudies}
#' method from the database API. The method requires at least one filtering
#' parameter, which means you need to provide at least one argument to this
#' function.
#'
#' This function returns a data_frame (from the \code{tibble} package) as it
#' deals nicely with the nested data structures provided by the API. See the
#' example code below for a demonstration of this behaviour.
#'
#' @param ID integer, can return multiple case studies if provided as a numeric
#'   vector. If this argument is provided then all other arguments will be
#'   ignored.
#' @param UKPRN integer, filter for a specific institution using its UKPRN.
#' @param UoA integer, filter for a specific Unit of Assessment.
#' @param tags integer, filter for specific tag IDs. Can combine multiple tags
#'   if provided as a numeric vector. Multiple tags are combined with logical
#'   AND.
#' @param phrase string, filter for a specific phrase. Currently only supports
#'   single words.
#'
#' @return Returns a data_frame (from the \code{tibble} package).
#'
#' @examples
#' \dontrun{
#' studies <- get_case_studies(ID = c(27,29))
#' studies
#' studies[1,"Continent"] # [] gives list element
#' studies[[1,"Continent"]] # [[]] gives contents
#' }
#'
#'
#' @export
get_case_studies <- function(ID = NULL,
                             UKPRN = NULL,
                             UoA = NULL,
                             tags = NULL,
                             phrase = NULL) {
  .Deprecated("ref_get")

  ##### Check inputs #####

  check_inputs_get_case_studies(ID, UKPRN, UoA, tags, phrase)

  # If ID is present, make everything else NULL like we promised
  if (!is.null(ID)) {
    UKPRN = NULL; UoA = NULL; tags = NULL; phrase = NULL
  }

  ##### Build Query #####

  base_url <- "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/SearchCaseStudies"

  # Build a list of arguments we want to use in the query
  arg_list <- list("ID"     = ID,
                   "UKPRN"  = UKPRN,
                   "UoA"    = UoA,
                   "tags"   = tags,
                   "phrase" = phrase)
  keep <- c(!is.null(ID), !is.null(UKPRN), !is.null(UoA), !is.null(tags), !is.null(phrase))
  arg_list <- arg_list[keep]

  query_url <- base_url
  for (i in seq_along(arg_list)) {
    filter_url <- paste0(ifelse(i==1,"?","&"),
                         names(arg_list)[[i]],
                         "=",
                         paste0(arg_list[[i]], collapse=","))
    query_url <- paste0(query_url,filter_url)
  }

  ##### Call the API #####
  tmp <- tibble::as_data_frame(jsonlite::fromJSON(query_url))

  return(tmp)

}



# Private function (not exported)
check_inputs_get_case_studies <- function(ID = NULL,
                                          UKPRN = NULL,
                                          UoA = NULL,
                                          tags = NULL,
                                          phrase = NULL) {

  if (all(is.null(ID), is.null(UKPRN), is.null(UoA), is.null(tags), is.null(phrase))) {
    stop("You must provide at least one filter argument.")
  }

  if (!is.null(ID) & any(!is.null(UKPRN),!is.null(UoA),!is.null(tags),!is.null(phrase))) {
    warning("When the ID argument is used, all other arguments will be ignored.")
  }

  if (!is.null(ID) & class(ID) != "numeric") {
    stop("ID must be either a single numeric value, or a vector of numeric values.")
  }

  if (!is.null(UKPRN) & class(UKPRN) != "numeric" | length(UKPRN) > 1) {
    stop("UKPRN must be a single numeric value.")
  }

  if (!is.null(UoA) & class(UoA) != "numeric" | length(UoA) > 1) {
    stop("UoA must be a single numeric value.")
  }

  if (!is.null(tags) & class(tags) != "numeric") {
    stop("tags must be either a single numeric value, or a vector of numeric values.")
  }

  if (!is.null(phrase) & class(phrase) != "character") {
    stop("phrase must be a single word.")
  } else if (!is.null(phrase)) {
    if (grepl(" ",phrase)) stop("phrase must be a single word.")
  }

}
