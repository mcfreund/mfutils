#' Convert an array or matrix into a long-form \code{data.frame}
#'
#' Useful for subsequently plotting matrices with ggplot2().
#' This function is a wrapper for \code{reshape2::melt()}.
#' \code{reshape2::melt()} is used here because it nicely preserves \code{dimnames(x)} as long-form variable columns.
#' This wrapper function simply formats the variable columns created by \code{reshape2::melt()}
#'  to play nice with ggplot2.
#'  Specifically, it reverses one factor's levels such that the diagonal of the matrix plotted by ggplot2 runs from
#'  top-left to  bottom-right.
#'
#' @param x matrix or array
#' @param col numeric index or name of column for which the level ordering should be reversed
#'  (defaults to 1; you will likely not need to tweak this)
#' @param ... additional optional arguments to \code{reshape2::melt()}
#'
#' @return long-form data.frame
#' @export
melt_mat <- function(x, col = 1, ...) {
  stopifnot(is.array(x))
  m <- reshape2::melt(x, ...)
  m[[col]] <- factor(m[[col]], levels = rev(unique(m[[col]])))  ## reverse one factor's levels so diag is topL->bottomR
  m
}
