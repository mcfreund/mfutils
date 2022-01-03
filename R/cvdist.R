#' Compute the cross-validated Euclidean distance.
#'
#'
#' @param x1 Data matrix (n_features by n_conditions) from fold i
#' @param x2 Data matrix (n_features by n_conditions) from fold j, j=/=i
#' @param m Contrast matrix constructed via \code{contrast_matrix()}.
#' The default is to compute this matrix on the fly.
#' However, this arguemnt allows for a contrast matrix to be precomputed and supplied
#' (i.e., if \code{cvdist} is to be called iteratively on multiple data matrices with the same set of conditions).
#' @param nms Optional character vector of condition names.
#' @param center Boolean: mean center each condition's pattern prior to computation?
#' @param scale Boolean: divisively normalize each condition's pattern to unit length (sqrt(ssq)=1) prior to computation?
#'
#' @return a cross-validated euclidean distance matrix (n_condition by n_condition)
#' @export
#'
#' @name
cvdist <- function(x1, x2, m = mfutils::contrast_matrix(ncol(x1)), nms = NULL, center = FALSE, scale = FALSE) {

  stopifnot(is.matrix(x1) && is.matrix(x2))
  stopifnot(is.numeric(x1) && is.numeric(x2))
  if (all(dim(x1) != dim(x2))) stop("x1 and x2 must be same size")

  if (center) {
    x1 <- center(x1)
    x2 <- center(x2)
  }
  if (scale) {
    x1 <- scale2unit(x1)
    x2 <- scale2unit(x2)
  }
  D <- .cvdist(x1, x2, m)
  if (!is.null(nms)) dimnames(D) <- list(nms, nms)
  D

}

#' @rdname cvdist
.cvdist <- function(x1, x2, m) {
  D <- rowMeans(tcrossprod(m, x1) * tcrossprod(m, x2))  ## means to scale by num verts
  dim(D) <- sqrt(rep(length(D), 1))  ## must be square in current implementation
  D
}
