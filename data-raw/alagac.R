# https://marine.rutgers.edu/~cfree/gis-data/mongolia-gis-data/

sf_from_url <- function(url) {
  file_ext <- stringr::str_extract(url, "(zip|rar)$")
  
  if (file_ext == "zip") {
    temp_file <- tempfile(fileext = ".zip")
  } else if (file_ext == "rar") {
    temp_file <- tempfile(fileext = ".rar")
  } else {
    stop("unknown file extension.")
  }
  
  download.file(url, destfile = temp_file)
  temp_dir <- tempdir(check = TRUE)
  target_dir <- paste0(temp_dir, "/", basename(url))
  dir.create(target_dir, recursive = TRUE)
  on.exit(unlink(target_dir, force = TRUE, recursive = TRUE))
  
  if (file_ext == "zip") {
    unzip(zipfile = temp_file, exdir = target_dir)
  } else {
    cmd <- sprintf("unrar e %s %s", temp_file, target_dir)
    system(command = cmd)
  }
  
  shp <- dir(target_dir, pattern = "\\.shp$", full.names = TRUE)
  
  sf::read_sf(shp)
}

alagac_urls <- c(
  roads = "http://marine.rutgers.edu/~cfree/files/gis-files/roads_alagac.zip",
  railroads = "http://marine.rutgers.edu/~cfree/files/gis-files/railroads_alagac.zip",
  aimag_centers = "http://marine.rutgers.edu/~cfree/files/gis-files/aimag_centers.zip",
  aimag_boundaries = "http://marine.rutgers.edu/~cfree/files/gis-files/aimag_boundaries.zip",
  soum_centers = "http://marine.rutgers.edu/~cfree/files/gis-files/soum_centers.zip",
  soum_boundaries = "http://marine.rutgers.edu/~cfree/files/gis-files/soum_boundaries.zip",
  national_boundary = "http://marine.rutgers.edu/~cfree/files/gis-files/mongolia.zip",
  major_lakes = "http://marine.rutgers.edu/~cfree/files/gis-files/lakes_alagac.zip",
  major_rivers = "http://marine.rutgers.edu/~cfree/files/gis-files/rivers_alagac.zip"
)

alagac <- lapply(alagac_urls, bluesky:::sf_from_url)
names(alagac) <- paste0("alagac_", names(alagac), "_sf")

for (i in seq_along(alagac)) {
  name <- names(alagac)[[i]]
  obj <- alagac[[i]]
  
  assign(name, obj)
  do.call(usethis::use_data, list(as.name(name), overwrite = TRUE))
}
