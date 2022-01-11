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
crcor <- function (x1, x2, idx1, idx2){
  stopifnot(is.matrix(x1) || is.matrix(x2) || is.matrix(idx1) || is.matrix(idx2) || nrow(idx1) == nrow(idx2))
  A1 <- mfutils::averaging_matrix(colnames(idx1))
  A2 <- mfutils::averaging_matrix(colnames(idx2))
  res <- mfutils::.crcor_r(x1 = x1, x2 = x2, idx1 = idx1, idx2 = idx2, A1 = A1, A2 = A2)
  dimnames(res) <- list(colnames(A1), colnames(A2))
  res
}
