#' Get all Omeka items
#'
#' Get all the Omeka items in a site. This function tries to get all the items
#' responsibly by waiting between requests, but be careful with this function.
get_all_items <- function() {
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
  link <- link[str_detect(link, "last")]
  last <- as.numeric(str_extract(link, "\\d+"))

  # Prepare the results list
  results <- vector(mode = "list", length = last)
  results[[1]] <- content(req)

  lapply(2:last, function(x) {
    Sys.sleep(5)
    message(paste("Requesting page", x))
    query$page <- x
    req <- GET(end, path = path, query = query)
    warn_for_status(req)
    results[[x]] <<- content(req)
  })

  results

}
