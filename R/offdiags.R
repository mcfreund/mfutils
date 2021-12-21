#' Extract off-diagonals of square matrix.
#'
#' Returns vector of length n^2 - n, where n
#' @param x square matrix
#'
#' @keywords matrix
#'
#' @return vector of off-diagonal elements
#' @export
offdiags <- function(x) {
  stopifnot(is_square_mat(x))
  x[row(x) != col(x)]
}
