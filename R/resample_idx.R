#'  Generate indices for resampling data.
#'
#' @param conditions character vector
#' @param n_resamples integer
#' @param resample_to integer
#' @param replace boolean
#'
#' @return
#' @export
#'
#' @examples
resample_idx <- function(conditions, n_resamples, resample_to = NULL, replace = FALSE) {
  stopifnot(is.character(conditions) || is.numeric(n_resamples))

  groups_list <- split(seq_along(conditions), conditions)  ## sorts list elements alphabetically
  global_min <- Reduce(min, lapply(groups_list, length))
  if (is.null(resample_to)) {
    resample_to <- global_min
  } else {
    if (!replace && resample_to > global_min) stop("When replace=FALSE, cannot draw more obs than the global min.")
  }

  idx <- replicate(n_resamples, unlist(lapply(groups_list, resample, size = resample_to), use.names = FALSE))
  idx <- t(idx)  ## resamples as rows, conditions as columns
  colnames(idx) <- rep(names(groups_list), each = resample_to)  ## add back names alphabetically

  idx

}
