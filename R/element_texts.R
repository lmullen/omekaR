#' Read element texts from an Omeka item
#'
#' Omeka items as returned by the API have a deeply nested structure. Most of
#' the interesting information is stored in the element texts. This function
#' provides a convenient way of accessing those element texts. Calling this
#' function on an Omeka item returns a named character vector of all the element
#' texts. Optionally you can pass a character vector to filter the output so the
#' function returns only a particular kind of metadata, e.g., \code{"Title"}.
#'
#' @param item An Omeka item as a list
#' @param filter Which element texts to return, as a character vector
#' @return A named character vector of element texts
#' @examples
#' omeka_endpoint("http://20.rrchnm.org/api")
#' # Get the Papers of the War Department project item
#' war_dept <- omeka_get("items", 197)
#' element_texts(war_dept)
#' element_texts(war_dept, "Title")
#' element_texts(war_dept, "Content Experts")
#' element_texts(war_dept, c("Start Date", "End Date"))
#' @export
element_texts <- function(item, filter) {
  texts <- sapply(item$element_texts, `[[`, "text")
  elements <- lapply(item$element_texts, `[[`, "element")
  element_names <- sapply(elements, `[[`, "name")
  names(texts) <- element_names
  if(missing(filter)) {
    return(texts)
  } else {
    texts[names(texts) %in% filter]
  }
}
