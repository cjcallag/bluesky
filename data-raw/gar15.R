library(data.table)

target_url <- "https://earthworks.stanford.edu/download/file/stanford-qp731cx6447-geojson.json"

init <- sf::read_sf(target_url, stringsAsFactors = FALSE)
setDT(init)

replacements <- c(
  "^bed" = "health",
  "^edu" = "education",
  "^emp" = "employment",
  "^ic" = "housing",
  "cr$" = "capital_stock_rural_usd",
  "cu$" = "capital_stock_urban_usd",
  "^tot" = "total",
  "val$" = "capital_stock",
  "pob$" = "population",
  "agr" = "agricol",
  "gov" = "government",
  "ind" = "industrial",
  "ser" = "service",
  "high" = "high_income_group",
  "low" = "low_income_group",
  "mhg" = "upper_middle_income_group",
  "mlw" = "lower_middle_income_group",
  "pu" = "urban_population",
  "pr" = "rural_population",
  "prv" = "private",
  "pub" = "public"
)


renamed <- copy(init)
setnames(renamed, stringr::str_replace_all(names(init), replacements))

usd_cols <- names(renamed)[grepl("usd$", names(renamed))]
corrected_usd <- copy(
  renamed
  )[, (usd_cols) := lapply(.SD, function(.x) .x * 1e6),
    .SDcols = usd_cols
    ]

finalize <- function(x) {
  init <- sf::st_sf(tibble::as_tibble(x))
  out <- sf::st_buffer(
    sf::st_transform(init, 3857),
    units::as_units(2.49, "km")
  )
  
  sf::st_geometry(out) <- sf::st_as_sfc(
    do.call(
      rbind,
      lapply(out$geometry, function(.x) {
        sf::st_as_sfc(sf::st_bbox(.x), crs = sf::st_crs(out))
      })
    ),
    crs = sf::st_crs(out)
  )
  
  out
}




gar15_sf <- finalize(corrected_usd) 

mapview::mapview(gar15_sf)



# target_url <- "https://stacks.stanford.edu/file/druid:qp731cx6447/data.zip"
target_url <- "https://data.humdata.org/dataset/9f0bc134-4a21-4b2a-8d10-7bfe68b295ab/resource/6486ee8b-5c31-4c62-a794-423208ed7791/download/mng.zip"
temp_file <- tempfile(fileext = ".zip")
temp_dir <- tempdir(check = TRUE)
download.file(target_url, destfile = temp_file)
unzip(temp_file, exdir = temp_dir)
shp <- dir(temp_dir, pattern = "\\.shp$", full.names = TRUE)

sf::read_sf(shp)



















