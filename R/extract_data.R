#' Extract data from gifti object.
#'
#' Convenience function for working with objects of class gifti (see gifti package).
#'
#' @param gifti object of class gifti from library(gifti)
#' @param pattern (optional) regexp for extracting only images with matching labels
#'
#' @return matrix of N_vertex by N_images
#' @export
extract_data <- function(gifti, pattern = NULL) {
  stopifnot(class(gifti) == "gifti")
  data <- abind::abind(gifti$data)
  colnames(data) <- extract_labels(gifti)
  if (!is.null(pattern)) data <- data[, grep(pattern, colnames(data))]
  data
}
