#' Internal functions for constructing and validating objects of type "atlas".
#'
#' Created following suggestions in https://adv-r.hadley.nz/s3.html.
#'
#' @param x a list or object of type atlas
#'
#' @return object of type atlas
#' @export
#'
#' @name new_atlas
new_atlas <- function(x = list()) {
  stopifnot(is.list(x))
  structure(x, class = "atlas")
}

#' @rdname new_atlas
validate_atlas <- function(x) {

  stopifnot(is_atlas(x))

  ## check elements:

  if (!all(c("data", "key", "space", "name") %in% names(x))) stop("missing name(s): data, key, space, name")
  if (!(is.matrix(x$data) & is.data.frame(x$key) & is.character(x$space) & is.character(x$name))) {
    stop("element of wrong type")
  }

  ## check data:

  ## length matches space:
  if (x$space == "fsaverage") {
    if (nrow(x$data) != 163842*2) stop("data is not in fsaverage space")
  } else if (x$space == "fsaverage5") {
    if (nrow(x$data) != 10242*2) stop("data is not in fsaverage5 space")
  } else if (x$space == "fsaverage6") {
    if (nrow(x$data) != 40962*2) stop("data is not in fsaverage6 space")
  } else {
    stop("provided space not yet configured")
  }

  ##  right and left inds do not overlap:
  l <- 1:(nrow(x$data)/2)
  r <- l + nrow(x$data)/2
  xl <- x$data[row(x$data) == l & x$data > 0, ]
  xr <- x$data[row(x$data) == r & x$data > 0, ]
  if (any(xl %in% xr)) stop("left and right indices overlap...")


  ## check key:

  if (!all(c("id", "idx", "hemi") %in% names(x$key))) stop("missing name(s) in key: id, idx, hemi")
  if (any(!x$key$hemi %in% c("LH", "RH"))) stop("x$key$hemi not in 'LH' or 'RH'")
  if (!(is.character(x$key$id) | is.numeric(x$key$idx) | is.character(x$key$hemi))) stop("key cols of wrong type")
  if (length(setdiff(x$key$idx[x$key$hemi == "LH"], xl)) != 0) stop("key idx does not match L hemi vals")
  if (length(setdiff(x$key$idx[x$key$hemi == "RH"], xr)) != 0) stop("key idx does not match R hemi vals")

  x

}
