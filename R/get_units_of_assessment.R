#' List Units of Assessment
#'
#' This function uses the \code{ListUnitsOfAssessment} method from the database
#' API and returns a list of Units of Assessment and associated metadata.
#'
#' @return Returns a data_frame (from the \code{tibble} package).
#'
#' @examples
#' \dontrun{
#' get_units_of_assessment()
#' }
#'
#' @export
get_units_of_assessment <- function() {

  ##### Call the API #####
  query_url <- "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/ListUnitsOfAssessment"
  tmp <- tibble::as_data_frame(jsonlite::fromJSON(query_url))

  return(tmp)

}
