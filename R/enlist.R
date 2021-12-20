#' Create named list from character vector.
#'
#' A wrapper for setNames(vector())
#'
#' @param nms (character) names for list
#'
#' @return list
#' @export
#'
#' @keywords lists, iteration
#'
#' @examples
#' enlist(letters)
enlist <- function(nms) {
  stopifnot(is.character(nms) && is.null(dim(nms)))
  stats::setNames(vector("list", length(nms)), nms)
}
