#' Average select columns of matrix together.
#'
#' Given an N by P matrix M, where each column p in 1, ..., P belongs to a group g of G total groups, this function computes the mean column vector per group.
#'
#' @param M numeric matrix
#' @param g (character) vector that indicates groups of columns of M
#'
#' @return An N by G matrix M_bar
#' @export
#' @keywords computation, matrix
#'
#' @examples
#' M <- diag(6)
#' g <- rep(letters[1:2], 3)
#' length(g) == ncol(M)
#' M_bar <- average(M, g)
#' ncol(M_bar) == length(unique(g))
average <- function(M, g) {
  if (!is.matrix(M) & is.character(g)) stop("M must be matrix, g must be character")
  if (nrow(M) != length(g)) stop("nrow(M) != length(g)")
  A <- indicator(g)
  A_scale <- tcrossprod(A, diag(1/colSums(A)))
  mat_bar <- M %*% A_scale
  colnames(mat_bar) <- colnames(A)
  mat_bar
}
