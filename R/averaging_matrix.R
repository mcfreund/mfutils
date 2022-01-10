#' Build averaging matrix from character vector of condition labels.
#'
#' Let X be a data matrix (n_features by n_obs), in which each column j is a pattern vector for observation j, which
#' belongs to class g.
#' Applying the averaging matrix A to X computes the class-mean matrix, X_bar (n_features by n_classes), in which each
#' column is the mean pattern for class g.
#'
#' NB: this function calls \code{indicator()}, which alphabetically sorts the columns of the output.
#'
#' @param conditions character vector of length n_obs that indicates the condition or class to which each observation
#'  belongs.
#'
#' @return matrix X_bar (n_features by n_classes)
#' @export
#'
averaging_matrix <- function(conditions) {
  A <- mfutils::indicator(conditions)
  As <- tcrossprod(A, diag(1/colSums(A)))
  colnames(As) <- colnames(A)
  As
}
