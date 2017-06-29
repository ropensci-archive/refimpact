#' List Tag Values
#'
#' DEPRECATED - USE ref_get. This function uses the \code{ListTagValues} method
#' from the database API and returns a list of Tag Values for the supplied tag
#' type.
#'
#' @param tag_type numeric, a valid tag type ID. Use \code{get_tag_types()} to find valid
#'   tag types.
#'
#' @return Returns a data_frame (from the \code{tibble} package).
#'
#' @examples
#' \dontrun{
#' get_tag_values(3) # Tag Type 3 (Subject)
#' }
#'
#' @export
get_tag_values <- function(tag_type) {
  .Deprecated("ref_get")

  ##### Check values #####
  if (class(tag_type) != "numeric") {
    stop("tag_type must be a single numeric value. Use get_tag_types() to find valid tag types.")
  }

  if (!(tag_type %in% c(1,3:13,15))) {
    warning("You may have picked an invalid tag type. Use get_tag_types() to find valid tag types.")
  }

  ##### Call the API #####
  query_url <- "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/ListTagValues/"
  query_url <- paste0(query_url, tag_type)
  tmp <- tibble::as_data_frame(jsonlite::fromJSON(query_url))

  return(tmp)

}
