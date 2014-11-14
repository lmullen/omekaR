#' Get all Omeka items
#'
#' Get all the Omeka items in a site. This function tries to get all the items
#' responsibly by waiting between requests, but be careful with this function.
#' You may irritate the site owner, get your IP address blocked, or have your
#' API key revoked.
#' @param wait The number of seconds to wait between requests. No matter what
#'   value you pass the function, it will wait at least 10 seconds between
#'   requests.
#' @return A list of Omeka items
#' @export
get_all_items <- function(wait = 10) {

  if(wait < 10) wait <- 10

  end <- omeka_endpoint()
  path <- paste("api", "items", sep = "/")
  query <- list(page = 1)

  # Only pass the API key if it exists
  key <- omeka_key()
  if(!is.null(key)) query$key <- key

  # Get the first page of results
  message(paste("Requesting page", 1))
  req <- GET(end, path = path, query = query)
  warn_for_status(req)

  # Figure out how many pages there are
  link <- headers(req)$link
  link <- unlist(stringr::str_split(link, ", "))
  link <- link[stringr::str_detect(link, "last")]
  last <- as.numeric(stringr::str_extract(link, "\\d+"))

  # Prepare the results list
  results <- vector(mode = "list", length = last)
  results[[1]] <- content(req)

  # Get the remaining pages
  lapply(2:last, function(x) {
    Sys.sleep(wait)
    message(paste("Requesting page", x, "of", last))
    query$page <- x
    req <- GET(end, path = path, query = query)
    warn_for_status(req)
    results[[x]] <<- content(req)
  })

  unlist(results, recursive = FALSE)

}
