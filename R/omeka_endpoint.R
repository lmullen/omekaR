#' Get or set the Omeka endpoint
#'
#' Pass a URL to this function to set the Omeka API endpoint for the rest of
#' your script. Call this function without an argument to get the currently set
#' endpoint.
#'
#' @param endpoint The URL of the Omeka endpoint you are using
#'
#' @return The URL of the Omeka endpoint
#'
#' @examples
#' omeka_endpoint("http://20.rrchnm.org/api")
#' omeka_endpoint()
#'
#' @export
omeka_endpoint <- function(endpoint = NULL) {

  if(is.null(endpoint)) {
    endpoint <- Sys.getenv("OMEKA_ENDPOINT")
    if(endpoint == "") stop("You set an Omeka API endpoint.")
  } else {
    Sys.setenv(OMEKA_ENDPOINT = endpoint)
  }

  endpoint

}
