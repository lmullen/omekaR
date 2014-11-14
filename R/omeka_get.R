#' GET request to an Omeka API
#'
#' Use this function to send a GET request to an Omeka site, e.g., to get site
#' details or items. See the details section or the
#' \href{http://omeka.readthedocs.org/en/latest/Reference/api/}{Omeka REST API
#' documentation}.
#'
#' @param resource The resource, such as \code{items} or \code{site}, to
#'   request.
#' @param id The (optional) id of a single item to request.
#' @param ... Additional arguments to be passed to \code{httr::GET()}.
#'
#' @details The resources currently available in Omeka include the following:
#'
#'   \itemize{ \item \code{collections} \item \code{items} \item \code{files}
#'   \item \code{item_types} \item \code{elements} \item \code{element_sets}
#'   \item \code{items} }
#'
#' @references See the
#'   \href{http://omeka.readthedocs.org/en/latest/Reference/api/}{Omeka REST API
#'   documentation} for more information about the API request you might pass to
#'   an Omeka site.
#' @export
omeka_get <- function(resource, id = NULL, ...) {

  end <- omeka_endpoint()
  path <- paste("api", resource, id, sep = "/")

  # Only pass the API key if it exists
  key <- omeka_key()
  if(is.null(key)) {
    req <- GET(end, path = path, ...)
  } else {
    if(hasArg(query)) {
      query$key <- key
    } else {
      query <- list(key = key)
    }
    req <- GET(end, path = path, query = query, ...)
  }

  warn_for_status(req)

  text <- content(req, as = "text")
  if (identical(text, "")) stop("")
  fromJSON(text, simplifyVector = FALSE)
}
