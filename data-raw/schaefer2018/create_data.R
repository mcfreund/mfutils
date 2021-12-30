library(here)
library(gifti)
library(data.table)
library(dplyr)
library(tidyr)

nparcs <- seq(100, 1000, 100)
nnetws <- c(7, 17)
spaces <- c("fsaverage", "fsaverage5", "fsaverage6")

for (nparc_i in seq_along(nparcs)) {
  for (nnetw_i in seq_along(nnetws)) {
    for (space_i in seq_along(spaces)) {
      
    fnames <- here(
      "data-raw", "schaefer2018", 
      paste0(
        "Schaefer2018_", nparcs[nparc_i], "Parcels_", nnetws[nnetw_i], "Networks", "_order_", c("L", "R"), "_",
        spaces[space_i], ".label.gii"
        )
      )
    
    ## create data
    
    g <- lapply(fnames, read_gifti)
    L <- mfutils::extract_data(g[[1]])
    R <- mfutils::extract_data(g[[2]]) + nparcs[nparc_i]/2
    R[R == nparcs[nparc_i]/2] <- 0
    
    stopifnot(length(unique(L[L > 0])) == (nparcs[nparc_i]/2))  ## check if appropriate num parcels
    stopifnot(length(unique(R[R > 0])) == (nparcs[nparc_i]/2))
    stopifnot(all(range(unique(L)) == c(0, (nparcs[nparc_i]/2))))  ## check if appropriate range
    stopifnot(all(range(unique(R)) == c(0, nparcs[nparc_i])))
    stopifnot(all(range(unique(R[R > 0])) == c(nparcs[nparc_i]/2 + 1, nparcs[nparc_i])))
    
    d <- rbind(L, R)
    
    ## create key
    
    k <- fread(
      paste0("Schaefer2018_", nparcs[nparc_i], "Parcels_", nnetws[nnetw_i], "Networks", ".txt"), 
      header = FALSE, col.names = "id"
      )
    info <- separate(k, id, into = c("prefix", "hemi", "network"), extra = "drop")
    k$idx <- 1:nrow(k)
    k$hemi <- info$hemi
    k$network <- info$network
    
    ## create atlas object
    
    atlas <- list(
      data = d, 
      key = k, 
      name = paste0("schaefer2018_", nnetws[nnetw_i], "_", nparcs[nparc_i]), 
      space = spaces[space_i]
      )
    
    atlas <- new_atlas(atlas)
    
    }
  }
}
