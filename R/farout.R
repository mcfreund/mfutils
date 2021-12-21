#' Identify "far outlier" points using IQR method
#'
#'
#' @param x numeric vector, matrix, or array
#' @param tiles defaults to 4 (the IQR)
#' @param threshold defaults to 3 ("far" or "extreme" outliers, i.e., beyond "outer fence")
#'
#' @keywords computation
#'
#' @return boolean vector of \code{length(x)} indicating which points (if any) are outlying
#' @export
farout <- function(x, tiles = 4, threshold = 3) {
  stopifnot(is.numeric(x))
  q1 <- stats::quantile(x, 0.5 - 1/tiles)
  q2 <- stats::quantile(x, 0.5 + 1/tiles)
  iqrthresh <- (q2 - q1)*threshold
  x < (q1 - iqrthresh) | x > (q2 + iqrthresh)
}
