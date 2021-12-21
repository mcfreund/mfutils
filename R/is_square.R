#' Check if number, vector, or matrix is 'square'
#'
#' \code{is_square(x)} checks if a scalar value is a perfect square.
#' \code{is_square_mat(x)} checks if a matrix \code{x} is square (n by n).
#' \code{is_square_vec(x)} and \code{is_square_tri(x)} work on vectors.
#' \code{is_square_vec(x)} tests if the vector could be from/formed into a vectorized square matrix (i.e., all elements),
#' whereas \code{is_square_tri(x)} tests if the vector could be from a triangle of a square matrix (using quadratic formula).
#'
#' @keywords matrix
#'
#' @param x vector or matrix
#'
#' @return boolean
#' @export
is_square <- function(x) {
  sqrt(x) == round(sqrt(x))
}

#' @rdname is_square
is_square_mat <- function(x) {
  stopifnot(is.matrix(x))
  nrow(x) == ncol(x)
}

#' @rdname is_square
is_square_vec <- function(x) {
  stopifnot(is.vector(x))
  is_square(length(x))
}

#' @rdname is_square
is_square_tri <- function(x) {
  stopifnot(is.vector(x))
  n <- sqrt(0.25 + 2*length(x)) + 0.5
  n == round(n)
}
