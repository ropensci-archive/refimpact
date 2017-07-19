#' Call the REF Impact Case Studies API
#'
#' This function calls the REF Impact Case Studies API, and returns the dataset
#' as a tibble. See the vignette for more details about how to use this
#' function.
#'
#' Details about the API can be found at
#' \url{http://impact.ref.ac.uk/CaseStudies/APIhelp.aspx}.
#'
#' @param api_method text, the API method you wish to call. Valid methods
#'   are summarised below, and documented on the REF Impact Case Studies website
#'   linked above, as well as in the vignette.
#' @param tag_type integer, for ListTagValues method only. This is the ID of the
#' tag type you wish to retrieve. See example usage below.
#' @param query list, search parameters for use with the SearchCaseStudies
#' method. See example usage below.
#'
#' @section Valid API methods:
#' \itemize{
#'   \item ListInstitutions (no arguments)
#'   \item ListTagTypes (no arguments)
#'   \item ListTagValues (tag_type is a compulsory argument)
#'   \item ListUnitsOfAssessment (no arguments)
#'   \item SearchCaseStudies (query is a compulsory argument - see below)
#' }
#'
#' @section SearchCaseStudies query argument:
#' This argument is used to pass search parameters through to the API. These
#' parameters are passed as a named list, and you must provide at least one
#' parameter for this method. There are 5 parameters:
#' \itemize{
#' \item ID - Takes a single ID or a vector of IDs. If you use this parameter
#' you cannot use any of the other 4 parameters.
#' \item UKPRN (UK Provider Reference Number) - takes a single UKPRN. You can
#' get a list of valid values using the ListInstitutions method.
#' \item UoA - This is a code referencing a Unit of Assessment, and you can get
#' a list of valid values from the ListUnitsOfAssessment method. Takes a single
#' UoA.
#' \item tags - This is one or more codes referencing tags from the
#' ListTagValues method. When multiple tags are provided to the search method,
#' it will only return rows which contain both tags. To help you discover tags
#' that you can use here, you can look at the ref_tags dataset (bundled with
#' this package)
#' \item phrase - You can search the database using a text query. The query must
#' conform to Lucene search query syntax.
#' }
#' For more information about how to use these parameters, see the vignette.
#'
#' @return Returns a \code{\link[tibble]{tibble}} with nested data frames. To
#'   access the nested data frames, subset the tibble using the [[]] syntax. For
#'   more information, see the vignette.
#'
#' @examples
#' \donttest{
#' institutions <- ref_get("ListInstitutions")
#' units_of_assessment <- ref_get("ListUnitsOfAssessment")
#' tag_types <- ref_get("ListTagTypes")
#' tag_type_5 <- ref_get("ListTagValues", 5L)
#' ref_get("SearchCaseStudies", query = list(ID     = c(27121,1698)))
#' ref_get("SearchCaseStudies", query = list(UKPRN  = 10007777))
#' ref_get("SearchCaseStudies", query = list(UoA    = 5))
#' ref_get("SearchCaseStudies", query = list(tags   = c(11280, 5085)))
#' ref_get("SearchCaseStudies", query = list(phrase = "hello"))
#' ref_get("SearchCaseStudies", query = list(UKPRN  = 10007146, UoA = 3))
#' }
#'
#' @export
ref_get <- function(api_method, tag_type = NULL, query = NULL) {

  # Set the user agent string so that the API maintainers can group all
  # package users together if they ever look at the logs
  ua <- httr::user_agent("http://github.com/perrystephenson/refimpact")

  # Check that the API method is one of the known (and supported) methods
  if (!(api_method %in% c("ListInstitutions",
                        "ListTagTypes",
                        "ListTagValues",
                        "ListUnitsOfAssessment",
                        "SearchCaseStudies"))) {
    stop("ref_get: api_method is not a recognised method for this API.\n",
         "See `?ref_get` for valid API methods.")
  }

  # The ListTagValues method requires tag_type to be appended to the end of the
  # URL. Check logic for this is in the input_validation.R file, and if it is
  # all good then we can append the tag_type to the api_method string.
  ListTagValues_validate(api_method, tag_type)
  if (!is.null(tag_type)) {
    api_method <- paste0(api_method, "/", as.integer(tag_type))
  }

  if (api_method == "SearchCaseStudies") {
    query <- SearchCaseStudies_prepare(query)
  } else {
    if (!checkmate::test_null(query)) {
      stop("ref_get: The query argument should only be used with the",
           " SearchCaseStudy method.")
    }
  }

  # Build the URL using httr
  api_url <-
    httr::build_url(structure(list(
      scheme   = "http",
      hostname = "impact.ref.ac.uk",
      path     = paste0("casestudiesapi/REFAPI.svc/", api_method),
      query    = query
    ), class = "url"))

  # Call the API and store the response
  r <- httr::GET(api_url, ua)

  # Check that we got a JSON back
  if (httr::http_type(r) != "application/json") {
    tmp <- xml2::read_xml(r)
    stop("ref_get: API did not return json.\n",
         "API returned the following text:\n",
         xml2::xml_text(tmp), call. = FALSE)
  }

  # Parse the JSON response
  parsed <- jsonlite::fromJSON(httr::content(r, as = "text"))

  # If there was a HTTP error, throw an R error with debug info
  if (httr::http_error(r)) {
    stop(
      sprintf(
        "ref_get: API request failed [%s]\n<%s>",
        httr::status_code(r),
        parsed
      ),
      call. = FALSE
    )
  }

  # Return the parsed data as a tibble
  tibble::as_tibble(parsed)
}
