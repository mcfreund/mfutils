#' Parcellate an image using an atlas.
#'
#' @param x to-be-parcellated data matrix, with vertices/voxels as rows
#' @param atlas an atlas object, defined in the same space as the data matrix \code{x}
#' @param col_roi character giving the name of the column in \code{atlas$key} that defines the regions of interest
#' (ROIs) into which the image are parcellated.
#' See XXX for more information.
#'
#' @return a list of matrices, one per ROI
#' @export
#'
#' @examples
#' x <- as.matrix(1:nrow(schaefer2018_7_100_fsaverage5$data))
#' x_parc <- parcellate(x, schaefer2018_7_100_fsaverage5)
#' str(x_parc)

parcellate <- function (x, atlas, col_roi = "parcel") {

  if (!(is.matrix(x) || is.array(x))) stop("x must be a matrix")
  if (!identical(atlas, validate_atlas(atlas))) stop("argument atlas not valid atlas")
  if (nrow(x) != length(atlas$data)) stop("data and atlas spaces mismatched")
  if (is.character(col_roi) && length(col_roi) != 1) stop("col_roi must be length 1 character")

  rois <- unique(atlas$key[[col_roi]])
  out <- enlist(rois)
  idx <- atlas$key$idx
  ndims <- length(dim(x))
  blank_els <- as.list(rep(TRUE, ndims - 1))
  x <- list(x)
  for (roi_i in seq_along(rois)) {

    which_parcels <- idx[atlas$key[[col_roi]] == rois[roi_i]]
    is_roi <- list(atlas$data %in% which_parcels)
    out[[roi_i]] <- do.call('[', c(x, is_roi, blank_els))  ## first is data; next is row; final is all other dims

  }

  out

}
