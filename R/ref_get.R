#' Call the REF Impact Case Studies API
#'
#' This function calls the REF Impact Case Studies API.
#'
#' @param api_method text string specifying the API method you wish to call.
#' @param tag_type integer, the ID of the tag type you wish to retrieve (see
#'   below)
#' @param query list, search parameters for use with the case_studies method
#'   (see below)
#'
#' @return Returns a tibble (from the \code{tibble} package).
#'
#' @examples
#' institutions <- ref_get("institutions")
#' units_of_assessment <- ref_get("uoa")
#' tag_types <- ref_get("tag_types")
#' tag_type_5 <- ref_get("tag_values", 5L)
#'
#' @export
ref_get <- function(api_method, tag_type = NULL, query = NULL) {

  ua <- httr::user_agent("http://github.com/perrystephenson/refimpact")

  api_method <- switch(api_method,
                       institutions = "ListInstitutions",
                       tag_types    = "ListTagTypes",
                       tag_values   = "ListTagValues/",
                       uoa          = "ListUnitsOfAssessment",
                       case_studies = "SearchCaseStudies")

  if(!is.null(tag_type)) {
    if (!checkmate::check_integerish(tag_type)) {
      stop("tag_type needs to be an integer.")
    }
    api_method <- paste0(api_method, tag_type)
  }

  api_url <-
    httr::build_url(structure(list(
      scheme   = "http",
      hostname = "impact.ref.ac.uk",
      path     = paste0("casestudiesapi/REFAPI.svc/", api_method)
    ), class = "url"))

  r <- httr::GET(api_url, ua)

  if (httr::http_type(r) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(r, as = "text"))

  if (httr::http_error(r)) {
    stop(
      sprintf(
        "API request failed [%s]\n<%s>",
        httr::status_code(r),
        parsed
      ),
      call. = FALSE
    )
  }

  tibble::as_tibble(parsed)
}
