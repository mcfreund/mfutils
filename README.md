
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mfutils

<!-- badges: start -->
<!-- badges: end -->

The mfutils package is a collection of various R functions that I
frequently use. Most of these functions I have created myself, however
some I have found on stackexchange (and included the attribution/url in
the documentation).

These functions can be sorted into different categories:

-   **general** utilities for constructing and manipulating base R
    objects, such as character vectors and lists
-   common **matrix** operations
-   **plotting** (mostly ggplot2 enhancements)
-   tools for implementing **representational similarity analysis
    (RSA)**, including spatial prewhitening and various distance
    measures
-   convenience functions for working with **gifti** objects from the
    `gifti` package (for surface fMRI data)

Although these categories are pretty different, I currently prefer to
have these functions all within a single package (e.g., rather than a
separate package for RSA), just to keep things simple.

## Installation

You can install the released version of mfutils from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("mfutils")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mcfreund/mfutils")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(mfutils)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
