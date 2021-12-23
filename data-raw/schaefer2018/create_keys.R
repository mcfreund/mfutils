nparcs <- seq(100, 1000, 100)
nnetws <- c(7, 17)
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
