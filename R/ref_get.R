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
#'   \item ListInstitutions
#'   \item ListTagTypes
#'   \item ListTagValues
#'   \item ListUnitsOfAssessment
#'   \item SearchCaseStudies
#' }
#'
#' @return Returns a \code{\link[tibble]{tibble}} with nested data frames. To
#'   access the nested data frames, subset the tibble using the [[]] syntax. For
#'   more information, see the vignette.
#'
#' @examples
#' institutions <- ref_get("ListInstitutions")
#' units_of_assessment <- ref_get("ListUnitsOfAssessment")
#' tag_types <- ref_get("ListTagTypes")
#' tag_type_5 <- ref_get("ListTagValues", 5L)
#' cases <- ref_get("SearchCaseStudies", query = list(ID = c(27121,1698)))
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
