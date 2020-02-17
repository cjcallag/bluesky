# sf_from_url <- function(url) {
#   file_ext <- stringr::str_extract(url, "(zip|rar)$")
#   
#   if (file_ext == "zip") {
#     temp_file <- tempfile(fileext = ".zip")
#   } else if (file_ext == "rar") {
#     temp_file <- tempfile(fileext = ".rar")
#   } else {
#     stop("unknown file extension.")
#   }
#   
#   download.file(url, destfile = temp_file)
#   temp_dir <- tempdir(check = TRUE)
#   target_dir <- paste0(temp_dir, "/", basename(url))
#   dir.create(target_dir, recursive = TRUE)
#   on.exit(unlink(target_dir, force = TRUE, recursive = TRUE))
#   
#   if (file_ext == "zip") {
#     unzip(zipfile = temp_file, exdir = target_dir)
#   } else {
#     cmd <- sprintf("unrar e %s %s", temp_file, target_dir)
#     system(command = cmd)
#   }
#   
#   shp <- dir(target_dir, pattern = "\\.shp$", full.names = TRUE)
#   
#   sf::read_sf(shp)
# }
