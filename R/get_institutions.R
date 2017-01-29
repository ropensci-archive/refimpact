#' List Institutions
#'
#' This function uses the \code{ListInstitutions} method from the database API
#' and returns a list of institutions and associated metadata, including the
#' UKPRN.
#'
#' @return Returns a tibble (from the \code{tibble} package).
#'
#' @examples
#' \donttest{
#' ref_institutions()
#' }
#'
#' @export
ref_institutions <- function() {

  ua <- httr::user_agent("http://github.com/perrystephenson/refimpact")

  r <- httr::GET(
    "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/ListInstitutions", ua)

  if (httr::http_type(r) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(r, as = "text"))

  if (httr::http_error(r)) {
    stop(
      sprintf(
        "API request failed [%s]\n%s\n<%s>",
        httr::status_code(r),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  tibble::as_tibble(parsed)

}
