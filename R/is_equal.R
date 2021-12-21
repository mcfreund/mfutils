#' Vectorized test for numeric equivalence.
#' From Johan Larsson's answer here https://stackoverflow.com/questions/35097815/vectorized-equality-testing
#'
#' @param x numeric vector
#' @param y numeric vector
#' @param tol tolerance. defaults to .Machine\$double.eps^0.5
#'
#' @keywords computation
#'
#' @return boolean vector
#' @export
is_equal <- function(x, y, tol = .Machine$double.eps^0.5) {
  abs(x - y) < tol
}
