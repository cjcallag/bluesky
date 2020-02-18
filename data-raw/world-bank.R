library(data.table)
print.data.table <- function(x) print(tibble::as_tibble(x))

## download (almost) always fails...
# data_url <- "http://databank.worldbank.org/data/download/WDI_csv.zip"
# temp_file <- tempfile(fileext = ".zip")
# download.file(data_url, temp_file)

temp_file <- "inst/raw-data/WDI_csv.zip"
temp_dir <- tempdir(check = TRUE)

unzip(temp_file, exdir = temp_dir)

target_file <- dir(temp_dir, pattern = "^WDIData\\.csv$", full.names = TRUE)

init <- fread(target_file, header = TRUE
              # )[`Country Name` == "Mongolia"
                )[, V65 := NULL
                  ]

year_cols <- intersect(names(init), as.character(1900:2020))
res <- melt(init, measure.vars = year_cols, variable.name = "year",
            variable.factor = FALSE
            )[!is.na(value)
              ][, year := as.integer(year)
                ]

chr_cols <- names(res)[vapply(res, is.character, logical(1L))]
res[, (chr_cols) := lapply(.SD, function(.x) {
  factor(.x, levels = unique(.x))
  }), .SDcols = chr_cols]

setnames(res, gsub(" ", "_", tolower(names(res))))


world_bank_df <- tibble::as_tibble(res)


usethis::use_data(world_bank_df, overwrite = TRUE)
