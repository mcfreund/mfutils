#' Quickly plot a melted matrix
#'
#' A convenience function that ggplots numeric matrices with sensible defaults.
#' This function takes a dataframe \code{x}, possibly the output of \code{melt_mat()}, as input, along with
#' three strings, \code{.row}, \code{.col}, \code{.value}, which indicate the names of the associated columns
#' in the data.frame.
#'
#' #' The default arguments are set to work with the labels that \code{reshape2::melt()} uses when names(dimnames(x)) are not set.
#'
#' @param x a long-form data.frame
#' @param .row character, name of column in \code{x} that holds labels for matrix rows
#' @param .col  character, name of column in \code{x} that holds labels for matrix cols
#' @param .value character, name of column in \code{x} that holds numeric values for matrix cells
#' @param geom "raster" (for \code{geom_raster}) or "tile" for (\code{geom_tile}), defaults to "raster" for speed, esp.
#' with larger matrices.
#' @param rotate_xaxis_text boolean, should x-axis text (column labels) be rotated 90 degrees? useful with long labels /
#'  large matrices.
#'
#' @return a ggplot object
#' @export
plot_melted_mat <- function(
  x,
  .row = "Var1",
  .col = "Var2",
  .value = "value",
  geom = "raster",
  rotate_xaxis_text = TRUE
  ){

  stopifnot(is.data.frame(x) && is.character(.row) && is.character(.col) && is.character(.value))

  p <- ggplot2::ggplot(x, ggplot2::aes_string(.col, .row, fill = .value))

  if (geom == "raster") {
    p <- p + ggplot2::geom_raster()
  } else if (geom == "tile") {
    p <- p + ggplot2::geom_tile(color = "grey50")
  }
  if (rotate_xaxis_text) p <- p + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 0))

  p

}

#https://stackoverflow.com/questions/10504724/change-the-default-colour-palette-in-ggplot
