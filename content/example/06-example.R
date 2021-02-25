## ----message=FALSE----------------------------------------------------------------------------------------------
library(tidyverse)
library(tidycensus)
library(viridis)
library(tools)




## ----eval = FALSE, echo=TRUE------------------------------------------------------------------------------------
## # Input your Census key
## census_api_key("YOUR CENSUS API KEY")
## 
## # Reload the .Renviron marker
## readRenviron("~/.Renviron")


## ---------------------------------------------------------------------------------------------------------------
acs16 <- load_variables(2016, "acs5", cache = TRUE) 


## ---------------------------------------------------------------------------------------------------------------
head(acs16) # or View(acs16) if you prefer


## ---------------------------------------------------------------------------------------------------------------
title <- acs16 %>% # use the acs_16 data set we created
  filter(name == "B19013_001") %>% # filter everything else out except where we find B19013_001
  select(concept) # select the column concept that provides a very brief description

# Convert to title case. We have to go in a funny way simply due to the encoding of text within the Census API
title <- tolower(title) %>%
          toTitleCase()

title


## ---------------------------------------------------------------------------------------------------------------
us_county_income <-  get_acs(geography = "county", 
          variables = "B19013_001", 
          shift_geo = TRUE, 
          geometry = TRUE)


## ---------------------------------------------------------------------------------------------------------------
ggplot(us_county_income) + 
  geom_sf(aes(fill = estimate), color = NA) + 
  # Removes the graticule lines from the plot
  coord_sf(datum = NA) + 
  theme_minimal() + 
  scale_fill_viridis()


## ---------------------------------------------------------------------------------------------------------------
wv_pop <- get_acs(geography = "county", 
                     variables = "B01003_001", 
                     state = "WV",
                     geometry = TRUE)


## ---------------------------------------------------------------------------------------------------------------
head(wv_pop) # or View(wv_pop) if you prefer


## ---------------------------------------------------------------------------------------------------------------
library(leaflet) # a JavaScript library for interactive maps
library(stringr) # Well I lied...this isn't new!
library(sf) # A very nice package that allows us to us a standardized way to encode spatial vector data, aka spatial objects.


## ---------------------------------------------------------------------------------------------------------------
pal <- colorQuantile(palette = "viridis", domain = wv_pop$estimate, n = 10)


## ---------------------------------------------------------------------------------------------------------------
wv_pop %>%
  st_transform(crs = "+init=epsg:4326") %>% 
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(NAME, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "Population percentiles",
            opacity = 1)


## ---------------------------------------------------------------------------------------------------------------
# Use the acs_16 data set we created
acs16 %>% 
  # filter everything else out except where we find B01003_001
  filter(name == "B01003_001") %>% 
  # select the column concept that provides a very brief description
  select(concept) 


## ---------------------------------------------------------------------------------------------------------------
# Pretty much the exact same pull we did above...
pa_pop <- get_acs(geography = "county", 
                    variables = "B01003_001", 
                    state = "PA",
                    geometry = TRUE)


## ---------------------------------------------------------------------------------------------------------------
# ... but this time we'll color it differently.
pal <- colorNumeric(palette = "plasma", 
                    domain = pa_pop$estimate)


## ---------------------------------------------------------------------------------------------------------------
# GIS things. Look at the code. Most of it is repetitive and for the most part, I think you should be able to figure out what's generally going on. 
pa_pop %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(NAME, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "County Populations",
            opacity = 1)


## ---------------------------------------------------------------------------------------------------------------
# Again, use the acs_16 data set we created
fl_pop <- get_acs(geography = "county", 
                  variables = "B01003_001", 
                  state = "FL",
                  geometry = TRUE)


## ---------------------------------------------------------------------------------------------------------------
# Assign out color palette for comparison
pal <- colorNumeric(palette = "plasma", 
                    domain = fl_pop$estimate)


## ---------------------------------------------------------------------------------------------------------------
# GIS things again. Notice that the base code is consistent.
fl_pop %>%
  st_transform(crs = "+init=epsg:4326") %>%
  leaflet(width = "100%") %>%
  addProviderTiles(provider = "CartoDB.Positron") %>%
  addPolygons(popup = ~ str_extract(NAME, "^([^,]*)"),
              stroke = FALSE,
              smoothFactor = 0,
              fillOpacity = 0.7,
              color = ~ pal(estimate)) %>%
  addLegend("bottomright", 
            pal = pal, 
            values = ~ estimate,
            title = "County Populations",
            opacity = 1)

