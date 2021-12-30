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
parcellate <- function(x, atlas, col_roi = "id") {

  if (!is.matrix(x)) stop("x must be a matrix")
  if (!identical(atlas, validate_atlas(atlas))) stop("argument atlas not valid atlas")
  if (nrow(x) != length(atlas$data)) stop("data and atlas spaces mismatched")
  if (is.character(col_roi) && length(col_roi) != 1) stop("col_roi must be length 1 character")

  roi <- atlas$key[[col_roi]]
  id  <- atlas$key$id
  idx <- atlas$key$idx

  out <- enlist(roi)
  for (roi_i in seq_along(roi)) {
    which_parcels <- idx[id == roi[roi_i]]
    is_roi <- atlas$data %in% which_parcels
    out[[roi_i]] <- x[is_roi, ]
  }

  out

}
