#' Concatenate gifti data from each hemisphere.
#'
#' Convenience function for working with objects of class gifti (see gifti package).
#'
#' @param l a list of giftis. must be of length 2, where each element contains a single gifti, one per hemisphere.
#' @param hemis a character vector indicating which list element is L or R. Default order: c("L", "R")
#' @param pattern (optional) regexp for extracting only images with matching labels
#'
#' @return matrix of N_vertex by N_images, where N_vertex includes all L and R vertices.
#' @export
#'
concat_hemis <- function(l, hemis = c("L", "R"), pattern = NULL) {
  if (class(l) != "list" || !identical(vapply(l, class, ""), c("gifti", "gifti"))) stop("l must be list of 2 giftis")
  stopifnot(sort(hemis) == c("L", "R"))
  abind::abind(lapply(l[order(hemis)], extract_data, pattern = pattern), along = 1)
}
