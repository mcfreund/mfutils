library(here)
library(gifti)
library(data.table)
library(dplyr)
library(tidyr)

nparcs <- seq(100, 1000, 100)
nnetws <- c(7, 17)
spaces <- c("fsaverage", "fsaverage5", "fsaverage6")

## create keys

base_dir <- "/data/nil-external/ccp/freund/atlases/Schaefer2018/Parcellations/"
out_dir <- "/data/nil-external/ccp/freund/atlases/Schaefer2018/giftis/"

read_key <- function(nm, nparc){
  fin <- file(fname, 'rt')
  tmp <- readLines(fin)
  close(fin)
  unlink(fin)
  stopifnot(length(tmp) == nparc*2)
  tmp[seq(1, nparc*2, 2)]
}

idx <- 1
l <- list("list", nparcs*nnetws)
for (nparc_i in seq_along(nparcs)) {
  for (nnetw_i in seq_along(nnetws)) {
    atlas <- paste0("Schaefer2018_", nparcs[nparc_i], "Parcels_", nnetws[nnetw_i], "Networks")
    fname <- paste0(base_dir, "HCP/fslr32k/cifti/", atlas, "_order_info.txt")
    l[[idx]] <- read_key(fname, nparcs[nparc_i])
    names(l)[idx] <- atlas
    idx <- idx + 1
  }
}
length(l)  ## n atlases
lapply(l, length)  ## n roi per atlas
names(l)  ## names atlases

for (i in seq_along(l)) {
  write.table(l[[i]], file = paste0(out_dir, names(l)[[i]], ".txt"), col.names = FALSE, row.names = FALSE)
}


## create atlas objects


for (nparc_i in seq_along(nparcs)) {
  for (nnetw_i in seq_along(nnetws)) {

    ## create key

    k <- fread(
      here("data-raw", "schaefer2018",
           paste0("Schaefer2018_", nparcs[nparc_i], "Parcels_", nnetws[nnetw_i], "Networks", ".txt")
           ),
      header = FALSE, col.names = "parcel"
    )
    info <- separate(k, parcel, into = c("prefix", "hemi", "network"), extra = "drop")
    k$idx <- 1:nrow(k)
    k$hemi <- info$hemi
    k$network <- info$network


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


      ## create atlas object

      name <- paste0("schaefer2018_", nnetws[nnetw_i], "_", nparcs[nparc_i])

      atlas <- list(
        data = d,
        key = k,
        name = name,
        space = spaces[space_i]
      )

      atlas <- mfutils::new_atlas(atlas)
      atlas <- mfutils::validate_atlas(atlas)

      name_obj <- paste0(name, "_", spaces[space_i])
      assign(name_obj, atlas)
      save(
        list = name_obj,
        file = here("data", paste0(name, "_", spaces[space_i], ".RData")),
        compress = "bzip2",
        version = 2
        )

    }
  }
}
