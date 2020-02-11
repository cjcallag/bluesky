# https://e-reporting.eitimongolia.mn/portalMap


library(data.table)
print.data.table <- function(x, ...) print(tibble::as_tibble(x), ...)


prep_file <- function(x) {
  parsed <- jsonlite::parse_json(file(x))
  
  prepped <- lapply(lapply(parsed, `[[`, "cordinate"), function(.x) {
    if (is.null(.x[["APPLICATION_DATE"]])) {
      .x[["APPLICATION_DATE"]] <- NA_character_
    }
    .x
  })
  
  
  rbindlist(prepped, use.names = TRUE)
}


extract_poly <- function(x) {
  init <- gsub("\\(+|\\)+", "", x)
  
  vec <- strsplit(init, ",|\\s")[[1L]]
  
  mat <- matrix(as.double(vec), ncol = 2L, byrow = TRUE)
  
  sf::st_cast(sf::st_multipoint(mat), "POLYGON")
}


all_files <- dir("inst/raw-data/eiti-mongolia/", full.names = TRUE)

date_cols <- c("APPLICATION_DATE", "GIVEN_DATE", "EXPIRED_DATE")

res <- rbindlist(
  lapply(all_files, prep_file), use.names = TRUE
  )[, geometry := sf::st_sfc(lapply(poly, extract_poly), crs = 4326L)
    ][, poly := NULL
      ][, (date_cols) := lapply(.SD, as.Date), 
        .SDcols = date_cols]


setnames(res, tolower(names(res)))

setnames(res, old = "area_m2", new = "area_hectares")
res[, area_hectares := as.double(area_hectares) * 10000]

eitim_licenses_sf <- sf::st_sf(tibble::as_tibble(res))

usethis::use_data(eitim_licenses_sf, overwrite = TRUE)


#######################################
curl_cmd <- "curl 'https://e-reporting.eitimongolia.mn/reportListAppend/' -H 'Connection: keep-alive' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'X-Requested-With: XMLHttpRequest' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Origin: https://e-reporting.eitimongolia.mn' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-Mode: cors' -H 'Referer: https://e-reporting.eitimongolia.mn/reportList' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: _ga=GA1.2.2101689258.1581379559; _gid=GA1.2.862298955.1581379559; PHPSESSID=ju9nnvi0ord5562v9tsv6t59p3; fileDownload=true' --data 'year=&yearFilter=&sumDuureg=&aimagId=&IsAudited=&isSubmited=2&entityName=&entityTin=&licenseNumber=&mineralType=&ownershipTypeId=&sEcho=1&pageSize=10000&draw=1&sortType=asc&sortColumn=' --compressed"
res <- system(command = curl_cmd, intern = TRUE)
parsed_comps <- jsonlite::parse_json(res)
res_comps <- data.table::rbindlist(
  lapply(parsed_comps$data, function(.x) {
    if (is.null(.x[["ID"]])) {
      .x[["ID"]] <- NA_character_
    }
    .x
  }), use.names = TRUE
)

names(res_comps) <-  tolower(names(res_comps))

eitim_companies_df <- tibble::as_tibble(res_comps)

usethis::use_data(eitim_companies_df, overwrite = TRUE)