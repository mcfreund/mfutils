#' Resample elements of vector.
#'
#' A safer method than sample(x), for cases where length(x) may equal 1 or >1.
#' See examples within ?sample.int.
#'
#' @param x to-be resampled vector
#' @param ... (optional) additional arguments to sample.int
#'
#' @return a vector with elements resampled
#' @export
#'
#' @keywords computation, resampling
#'
#' @examples
#' resample(1:20, replace = TRUE)  ## bootstrap
#' resample(1:20, size = 4)  ## downsample
resample <- function(x, ...) {
  x[sample.int(length(x), ...)]
}
