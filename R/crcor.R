#' Estimate cross-run correlation matrix with downsampling.
#'
#' @param x1 data matrix from fold (run) 1
#' @param x2 data matrix from fold (run) 1
#' @param idx1 integer matrix of resampled indices for fold 1 (created with \code{resample_idx()})
#' @param idx2 integer matrix of resampled indices for fold 2 (created with \code{resample_idx()})
#'
#' @return cross-correlation matrix
#' @export
#'
crcor <- function(x1, x2, idx1, idx2) {
  stopifnot(length(dim(x1)) == 2 || length(dim(x2)) == 2)

  A1 <- averaging_matrix(colnames(idx1))
  A2 <- averaging_matrix(colnames(idx2))

  res <- crcor_rcpp(x1 = x1, x2 = x2, idx1 = idx1 - 1L, idx2 = idx2 - 1L, A1 = A1, A2 = A2)  ## Cpp uses 0-based idx
  dimnames(res) <- list(colnames(A1), colnames(A2))

  res

}
