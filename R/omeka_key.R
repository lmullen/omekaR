#' Get or set the Omeka API key
#'
#' Pass an Omeka API key to this function to set the Omeka API key for the rest
#' of your script. Call this function without an argument to get the currently
#' set endpoint. If you do not set an Omeka API key, then this function returns
#' NULL and the API will be accessed without passing along a key. You can set
#' your API key as the \code{OMEKA_KEY} system environment variable.
#'
#' @param key The Omeka API key to the site that you are using.
#'
#' @return The current Omeka API key, or NULL if none is set.
#'
#' @examples
#' omeka_key()
#'
#' @export
omeka_key <- function(key = NULL) {

  if(is.null(key)) {
    key <- Sys.getenv("OMEKA_KEY")
    if(key == "") key <- NULL
  } else {
    Sys.setenv(OMEKA_KEY = key)
  }

  key

}
