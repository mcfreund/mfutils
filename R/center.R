#' Mean-center columns of a matrix.
#'
#' @param x to-be-centered matrix
#'
#' @return centered matrix
#' @export
#'
#' @keywords computation, matrix
#'
#' @examples
#' center(row(diag(10)))
center <- function(x) {
  stopifnot(length(dim(x)) == 2)
  x - rep(colMeans(x), rep.int(nrow(x), ncol(x)))
}
