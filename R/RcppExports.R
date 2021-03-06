# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Estimate cross-run correlation matrix with downsampling.
#'
#' For internal use. Call \code{crcor()} instead.
#'
#' @param x1 data matrix
#' @param x2 data matrix
#' @param idx1 integer matrix
#' @param idx2 integer matrix
#' @param A1 averaging matrix
#' @param A2 averaging matrix
#' @export
crcor_rcpp <- function(x1, x2, idx1, idx2, A1, A2) {
    .Call(`_mfutils_crcor_rcpp`, x1, x2, idx1, idx2, A1, A2)
}

