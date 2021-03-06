% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/combo_paste.R
\name{combo_paste}
\alias{combo_paste}
\title{Paste all combinations of elements of a set of character vectors.}
\usage{
combo_paste(a, b, ..., sep = "")
}
\arguments{
\item{a}{(character) vector 1, left-hand side of output}

\item{b}{(character) vector 2, right-hand side of output}

\item{...}{optional, additional arguments to expand.grid  (e.g., character vectors to combine)}

\item{sep}{(character) separates the results}
}
\value{
A character vector.
}
\description{
A wrapper for apply(expand.grid())
}
\examples{
combo_paste(letters[1:2], letters[3:4], sep = "_")
combo_paste(letters[1:2], letters[3:4], LETTERS[24:26], sep = "_")  ## accommodates >2 vectors
}
\keyword{strings}
