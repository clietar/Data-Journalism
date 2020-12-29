# Read in Land data.
library(sf)
land <- st_read("ne_10m_admin_0_countries_lakes.shp") # file avaialable at https://github.com/nvkelso/natural-earth-vector/blob/master/10m_cultural/ne_10m_admin_0_countries_lakes.shp

# Get underlying data in shapefiles.
# ADMIN, ABBREV are Labels.
# scalerank, LABELRANK, TINY are admin levels I considered as filters.
land_data2 <- 
  land %>% 
  as.data.frame() %>%
  select(scalerank, LABELRANK, ADMIN, ABBREV, TINY) %>%
  as_data_frame()


# Create empty data frame to load data into.
land_data <-
  data_frame(
    longitude = double(),
    latitude = double(),
    set = double(),      # Data are nested.
    subset = double(),   # These are nesting
    subsubset = double() # identifiers.
  )

land <- st_geometry(land)

# sort through highest level (countries).
for(i in 1:length(land)) {
  level_1 <-
    land %>%
    .[[i]] %>%
    stringr::str_split("MULTIPOLYGON \\(")
  
  # Sort through second level. (subset)
  for(j in 1:length(level_1)) {
    level_2 <-
      level_1 %>%
      .[[j]] %>%
      stringr::str_split("list\\(") %>%
      .[[1]] %>%
      .[. != ""] %>%
      stringr::str_split("c\\(") %>%
      .[[1]] %>%
      .[. != ""]

# Sort through third level get data and add to dataframe. (subsubset)    
    for(k in 1:length(level_2)) {
      level_2 %>%
        .[k] %>%
        stringr::str_replace_all("\\)", "") %>%
        stringr::str_split(",") %>%
        .[[1]] %>%
        stringr::str_trim() %>%
        as.numeric() %>%
        .[!is.na(.)] %>%
        matrix(ncol = 2) %>%
        as_data_frame() %>%
        rename(
          longitude = V1,
          latitude = V2
        ) %>%
        mutate(
          set = i,
          subset = j,
          subsubset = k
        ) %>%
        bind_rows(land_data) ->
        land_data
    }
  }
}

# Sort data by set, subset, subsubset.    
land_data  = land_data %>%
  arrange(set, subset, subsubset)

# Join underlying data.    
land_data = land_data %>%
  mutate(set = as.character(set)) %>%
  left_join(
    as_data_frame(land_data2) %>%
    tibble::rownames_to_column("set")
  )

land_data = land_data %>%
  mutate(
    name = "Land",
    altitude = 1
  ) %>%
  group_by(set, subset) %>%
  mutate(
    index = row_number()
  )

# Build great circle. 
library(dplyr)
outline <-
  data_frame(
    index = seq(0, 360, 1/3), 
    altitude = 1,
    set = "Outline" # Create a data point every 1/3 of a degree.
  ) %>%
  mutate(
    latitude = altitude * cos(2*pi*(index/360)),
    longitude = altitude * sin(2*pi*(index/360)),
    index = index*3
  )

outline

final = land_data %>% bind_rows(outline)


write.csv(final, "polygones_countries.csv")