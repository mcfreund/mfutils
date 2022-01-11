#' Estimate cross-run correlation matrix with downsampling.
#'
#' Internal function. Call \code{crcor()} instead.
#'
#' @param x1 data matrix from fold (run) 1
#' @param x2 data matrix from fold (run) 1
#' @param idx1 integer matrix of resampled indices for fold 1 (created with \code{resample_idx()})
#' @param idx2 integer matrix of resampled indices for fold 2 (created with \code{resample_idx()})
#' @param A1 averaging matrix for fold 1 (created with \code{averaging_matrix()})
#' @param A2 averaging matrix for fold 2 (created with \code{averaging_matrix()})
#' @return cross-correlation matrix
#' @export
#'
.crcor_r <- function(x1, x2, idx1, idx2, A1, A2) {
  res <- matrix(0, ncol = ncol(A2), nrow = ncol(A1), dimnames = list(colnames(A1), colnames(A2)))
  for (ii in seq_len(nrow(idx1))) {
    x1i <- x1[, idx1[ii, ], drop = FALSE]
    x2i <- x2[, idx2[ii, ], drop = FALSE]
    res <- res + atanh(stats::cor(x1i %*% A1, x2i %*% A2))
  }
  tanh(res / nrow(idx1))
}
