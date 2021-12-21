#' Average a square matrix over the diagonal
#'
#' For a square matrix \code{x}, a 'folded' matrix \code{xbar} will have element
#' \code{xbar[i, j]} = \code{xbar[j, i]} = (\code{x[i, j]} + \code{x[j, i]})/2
#'
#' @param x numeric square matrix
#'
#' @keywords computation, matrix
#'
#' @return numeric square symmetric matrix (\code{xbar})
#' @export
fold <- function(x) {
  stopifnot(is_square_mat(x))
  (x + t(x))/2
}
