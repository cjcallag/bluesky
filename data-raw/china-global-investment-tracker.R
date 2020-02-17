library(data.table)
print.data.table <- function(x) print(tibble::as_tibble(x))

target_url <- "https://www.aei.org/wp-content/uploads/2020/01/China-Global-Investment-Tracker-2019-Fall-FINAL.xlsx"


temp_file <- tempfile(fileext = ".xlsx")
download.file(target_url, destfile = temp_file)

sheets <- readxl::excel_sheets(temp_file)
names(sheets) <- c("investments", "construction_contracts", 
                   "troubled_transactions", "combined")


cgit <- lapply(sheets, function(.x) {
  readxl::read_excel(temp_file, sheet = .x, skip = 5)
})


names(cgit) <- paste0("cgit_", names(cgit), "_df")


for (i in seq_along(cgit)) {
  name <- names(cgit)[[i]]
  obj <- cgit[[i]]
  
  assign(name, obj)
  do.call(usethis::use_data, list(as.name(name), overwrite = TRUE))
}
