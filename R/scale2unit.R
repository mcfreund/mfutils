#' Divisively normalize a vector or columns of matrix to length 1.
#'
#' Divides each element of column (vector) by square root of sum of squares.
#'
#' @param x to-be-scaled matrix or vector
#'
#' @return scaled matrix or vector
#' @export
#'
#' @keywords computation, matrix
#'
#' @examples
#' scale2unit(row(diag(10)))
scale2unit <- function(x) {
  stopifnot(is.matrix(x) || is.vector(x))
  if (is.vector(x)) {
    x / sqrt(sum(x^2))
  } else if (is.matrix(x)) {
    x %*% diag(1 / sqrt(colSums(x^2)))
  }
}
