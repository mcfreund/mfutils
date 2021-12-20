#' Efficiently compute row-wise or column-wise variance of a matrix.
#'
#' Reproduced from David Arenburg's answer here: https://stackoverflow.com/questions/25099825/row-wise-variance-of-a-matrix-in-r
#'
#' @param x N by P numeric matrix
#' @param dim dimension along which to compute variance (1 == row, 2 == col)
#' @param ... (optional) arguments for rowSums/colMeans calls (e.g., na.rm)
#'
#' @return a vector containing the variances
#' @export
#' @keywords computation, matrix
#'
#' @examples
#' x <- row(matrix(0, 3, 4))
#' length(Var(x)) == nrow(x)
#' length(Var(x, 2)) == ncol(x)
Var <- function(x, dim = 1, ...) {
  if(dim == 1){
    rowSums((x - rowMeans(x, ...))^2, ...)/(dim(x)[2] - 1)
  } else if (dim == 2) {
    rowSums((t(x) - colMeans(x, ...))^2, ...)/(dim(x)[1] - 1)
  } else stop("Please enter valid dimension")
}
