#' Extract labels from a gifti object.
#'
#' Convenience function for working with objects of class gifti (see gifti package).
#'
#' @param gifti object of class gifti from library(gifti)
#'
#' @return character vector of labels of gifti images
#' @export
#' @keywords fmri, gifti
#'
extract_labels <- function(gifti) {
  stopifnot(class(gifti) == "gifti")
  vapply(gifti$data_meta, function(x) x[1, "vals"], character(1))
}
