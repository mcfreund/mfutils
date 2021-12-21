#' Vectorize and reshape distance or correlation matrices.
#'
#' When \code{x} is a distance matrix or correlation matrix (symmetric with diagonal elements equal to 0 or 1,
#' respectively), \code{squareform()} vectorizes this matrix (i.e., "unwraps" or "flattens") into a vector (i.e., vec->mat).
#' When \code{x} is a vector (i.e., a distance matrix or correlation matrix) \code{squareform()} reshapes this vector
#' into the correspoding square matrix (i.e., mat->vec).
#'
#'
#'
#' @param x square matrix or vector
#' @param lt boolean, is only the lower-triangle (TRUE) or full matrix (all values) of interest?
#' For \code{lt = TRUE} (default): when \code{x} is a vector, only the lower-triangle will be extracted, and when
#' \code{x} is a vector, it will be assumed that it is a lower-triangle vector.
#' For convenience, this can be toggled to extract/assume the full matrix (both triangles and diagonal)
#' by setting \code{lt = FALSE}.
#'
#' @keywords matrix
#'
#' @param corr boolean (defaults to FALSE, for distance matrices), defines the value of diagonal elements
#' @param nms optional (applicable only when vec->mat), character vector that holds names of rows/cols of output matrix
#'
#' @return square matrix or vector
#' @export
squareform <- function(x, lt = TRUE, corr = FALSE, nms = NULL) {

  if (is.numeric(x)) {
    if (is.matrix(x)) {
      stopifnot(is_square_mat(x))
    } else if (is.vector(x)) {
      stopifnot(is_square_vec(x) || is_square_tri(x))
    } else stop("not square matrix or 'square' vector (see ?is_square)")
  } else stop("not numeric")

  if (is.matrix(x)) {

    if (lt) {
      res <- x[lower.tri(x)]
    } else {
      res <- c(x)
    }

  } else if (is.vector(x)) {

    if (!is.null(nms)) nms <- list(nms, nms)

    if (lt) {
      n <- sqrt(0.25 + 2*length(x)) + 0.5
      res <- matrix(as.numeric(corr), ncol = n, nrow = n, dimnames = nms)
      res[lower.tri(res)] <- x
      res <- t(res)
      res[lower.tri(res)] <- x
    } else {
      n <- length(x)
      res <- matrix(x, ncol = n, nrow = n, dimnames = list(nms, nms))
    }

  }

  res

}
