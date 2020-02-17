#' Data from the Administration of Land Affairs, Geodesy, and Cartography of Mongolia (ALAGaC)
#' 
#' @template author-bk
#' 
#' @examples 
#' library(ggplot2)
#'
#'ggplot() +
#'  geom_sf(aes(color = "alagac_soum_boundaries_sf"),
#'          fill = "transparent",
#'          data = alagac_soum_boundaries_sf) +
#'  geom_sf(aes(color = "alagac_aimag_boundaries_sf"), 
#'          fill = "transparent",
#'          data = alagac_aimag_boundaries_sf) +
#'  geom_sf(aes(color = "alagac_national_boundary_sf"), 
#'          fill = "transparent",
#'          data = alagac_national_boundary_sf) +
#'  labs(title = "Administrative Boundaries") +
#'  NULL
#'
#'ggplot() +
#'  geom_sf(data = alagac_national_boundary_sf) +
#'  geom_sf(aes(color = "alagac_aimag_centers_sf"), 
#'          fill = "transparent",
#'          show.legend = "point",
#'          data = alagac_aimag_centers_sf) +
#'  geom_sf(aes(color = "alagac_soum_centers_sf"), 
#'          fill = "transparent",
#'          show.legend = "point",
#'          data = alagac_soum_centers_sf) +
#'  labs(title = "Administrative Centers") +
#'  NULL
#'
#'ggplot() +
#'  geom_sf(data = alagac_national_boundary_sf) +
#'  geom_sf(aes(color = "alagac_major_lakes_sf"), 
#'          data = alagac_major_lakes_sf) +
#'  geom_sf(aes(color = "alagac_major_rivers_sf"), 
#'          data = alagac_major_rivers_sf) +
#'  labs(title = "Major Bodies of Water") +
#'  NULL
#'
#'ggplot() +
#'  geom_sf(data = alagac_national_boundary_sf) +
#'  geom_sf(aes(color = "alagac_roads_sf"), 
#'          data = alagac_roads_sf) +
#'  geom_sf(aes(color = "alagac_railroads_sf"), 
#'          data = alagac_railroads_sf) +
#'  labs(title = "Transportation") +
#'  NULL
#'
#' @source [marine.rutgers.edu](https://marine.rutgers.edu/~cfree/gis-data/mongolia-gis-data/)
#' 
"alagac_roads_sf"

#' @rdname alagac_roads_sf
"alagac_railroads_sf"

#' @rdname alagac_roads_sf
"alagac_aimag_centers_sf"

#' @rdname alagac_roads_sf
"alagac_aimag_boundaries_sf"

#' @rdname alagac_roads_sf
"alagac_soum_centers_sf"

#' @rdname alagac_roads_sf
"alagac_soum_boundaries_sf"

#' @rdname alagac_roads_sf
"alagac_national_boundary_sf"

#' @rdname alagac_roads_sf
"alagac_major_lakes_sf"

#' @rdname alagac_roads_sf
"alagac_major_rivers_sf"
