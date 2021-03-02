
library(ggmap) # Provides the ability to visualize spatial data
library(maps) # Computes the areas of regions in a projected map
library(mapdata) # Providing both larger and higher-resolution databases.
library(rgdal) # Bindings for the Geospatial Data Abstraction Library 
               # (https://www.gdal.org/)
library(tidyverse)
library(tools) # Core package for R and is worth noting
library(viridis)
library(censusapi)

Sys.setenv(CENSUS_KEY="YOUR API KEY HERE")

readRenviron("~/.Renviron") # You may get a warning...ignore it

Sys.getenv("CENSUS_KEY")


usa <- map_data("usa")


dim(usa)



head(usa) 



tail(usa) 



ggplot() + 
  geom_polygon(data = usa, 
               aes(x=long, y = lat, group = group))



ggplot() + 
  geom_polygon(data = usa, 
               aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3) # 1.3 is a decent standard estimate



ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), color = "#1b85b8", 
               fill = "#559e83") + 
  coord_fixed(1.3)



state <- map_data("state")



California <- map_data("state", region = "CA")



Kansas <- map_data("state", region = "KS")



Michigan <- map_data("state", region = "MI")



unique(Michigan$region)



Michigan <- map_data("state", 
                     region = "Michigan")



unique(Michigan$region)



mi <- subset(state, 
             region=="michigan")



ggplot() + 
  geom_polygon(data = mi, 
                        aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)



ggplot() + 
  geom_polygon(data = mi, aes(x=long, y = lat, group = group, fill=region)) +
  scale_fill_manual(values=c("#6A0032")) +
  coord_fixed(1.3)



county <- map_data("county")



mi_count <- subset(county, region=="michigan")



par(mar = c(12, 6, 4, 2) + 0.1)



ggplot() + 
  geom_polygon(data = mi_count, aes(x=long, y = lat, group = group, fill=subregion), 
               color = "#FFFFFF") +
  scale_fill_viridis(discrete = TRUE, 
                     alpha=0.7, 
                     option="inferno") +
  theme_bw() +
  theme(plot.title = element_text(size = 26, color ="#105456",  vjust = -1),
        legend.position ="bottom",
        legend.direction = 'vertical',
        legend.text = element_text(size=15, color = "#59595B"),
        legend.title = element_blank(),
        legend.title.align = 0.5,
        legend.spacing.x = unit(0.5, "cm"), 
        legend.spacing.y = unit(0.5, "cm"),
        legend.background = element_rect(linetype = 0, size = 0.5, colour = 1),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  coord_fixed(1.3)



ggplot() + 
  geom_polygon(data = mi_count, aes(x=long, y = lat, group = group, fill=subregion), 
               color = "#FFFFFF") +
  scale_fill_viridis(discrete = TRUE, 
                     alpha=0.7, 
                     option="inferno", 
                     guide = FALSE) + #HERE IT IS
  theme_bw() +
  theme(plot.title = element_text(size = 26, color ="#105456",  vjust = -1),
        legend.position ="bottom",
        legend.direction = 'vertical',
        legend.text = element_text(size=15, color = "#59595B"),
        legend.title = element_blank(),
        legend.title.align = 0.5,
        legend.spacing.x = unit(0.5, "cm"), 
        legend.spacing.y = unit(0.5, "cm"),
        legend.background = element_rect(linetype = 0, size = 0.5, colour = 1),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
# guides(color=FALSE) +
  coord_fixed(1.3)



apis <- listCensusApis()



View(apis)



acs2017_vars <- listCensusMetadata(name = "2017/pep/population/", 
                                 type = "variables")



head(acs2017_vars)



acs2017_geos <- listCensusMetadata(name = "2017/pep/population/", 
                                   type = "geography")



View(acs2017_geos)



library(rvest)



webpage <- read_html("https://api.census.gov/data/2017/pep/population/variables.html")



tbls <- html_nodes(webpage, "table") 



tbls # or if there are multiple tables, consider using head(tbls)



tbls_ls <- webpage %>%
        html_nodes("table") %>% # Creates a multidimensional list (i.e. a list 
                                # with layers and depth akin to folders within 
                                # folders within folders, ect.)
        .[1] %>% # We only have table so we put.[1] here. If we had multiple 
                 # tables and we wanted say the first three, we could have 
                 # used .[1:3]
        html_table(fill = TRUE) # Convert the data to a table format and populate 
                                # the entries



View(tbls_ls)



tbls_ls <- do.call(rbind.data.frame, tbls_ls) # Concatenates a list of data frames 
                                              # into a single data frame



View(tbls_ls)



filtered_tbls_ls <- tbls_ls[tbls_ls$Required == "default displayed", ] 
                                                              # Filter out the rows that
                                                              # don't have `default 
                                                              # displayed` under the 
                                                              # column **Required**

filtered_tbls_ls$Name # Just shows the Names of the required variables


library(rvest)

read_html("https://api.census.gov/data/2017/pep/population/variables.html") %>%
html_nodes("table")  %>% # Creates a multidimensional list (i.e. a list with layers 
                         # and depth akin to folders within folders within folders, 
                         # ect.)
  .[1] %>% # We only have table so we put.[1] here. If we had multiple tables and 
           # we wanted say the first three, we could have used .[1:3]
  html_table(fill = TRUE) %>% # Convert the data to a table format and populate the 
                              # entries
  bind_rows() %>% # Concatenates a list of data frames into a single data frame
  filter(Required == "default displayed") %>% # Filter out the rows that don't have
                                              # `default displayed` under the column 
                                              # **Required**
  select(Name) # Just shows the Names of the required variables



tbls_ls$Name



read_html("https://api.census.gov/data/2017/pep/population/variables.html") %>%
  html_nodes("table")  %>% # This is a multidimensional list (i.e. a list with layers)
  .[1] %>% 
  html_table(fill = TRUE) %>%
  bind_rows() %>% 
  select(Name)



getCensus(name = "2017/pep/population",
          vars = c("DENSITY"), 
          region = "state:26")



Tigers <- getCensus(name = "2017/pep/population",
                         vars = c("GEONAME", "COUNTY", "DENSITY"), 
                         region = "county:*",
                         regionin = "state:26")



head(Tigers, n=15L)



drops <- c("state", "county", "COUNTY") # Assigns column names to be dropped
Tigers <- Tigers[ , !(names(Tigers) %in% drops)] # Drops those columns 



head(Tigers)



head(mi_count)



Tigers <- Tigers %>% 
  separate(GEONAME, into = paste0('thing', 1:2), sep = '[,]')



head(Tigers)



Tigers <- setNames(Tigers, c("County","State","Density")) 



head(Tigers)



Tigers$County <- str_replace_all(Tigers$County, " County", "") 
# Find the term County in the County column and replace it nothing (given by ""). Notice 
# that there is a space between the first quote and the term County to account for the 
# space between the two words.



dropFromCensus <- c("State")
Tigers <- Tigers[ , !(names(Tigers) %in% dropFromCensus)] # Drops those columns



head(Tigers)



head(mi_count)



dropFromMapData <- c("group", "order", "region")
mi_count <- mi_count[ , !(names(mi_count) %in% dropFromMapData)] # Drops those columns
head(mi_count)



mi_count <- setNames(mi_count, c("long","lat","County")) 



head(mi_count)



mi_count$County <- str_to_title(mi_count$County)



head(mi_count)



head(Tigers)
head(mi_count)



total_thing <- left_join(mi_count, Tigers, by = c("County"))



head(mi_count)



ggplot() + 
  geom_polygon(data = total_thing, aes(x=long, y = lat, fill=Density, group=County), 
               color = "#f8f8fa", size = 0.25, show.legend = T) +
  scale_color_viridis(alpha=1, option="viridis") + # color tells R to look for discrete data to color
  theme_bw() +
  theme(plot.title = element_text(size = 26,color ="#105456",  vjust = -1),
        legend.position ="right",
        legend.direction = 'vertical',
        legend.key = element_rect(size = 5, color = NA),
        legend.key.size = unit(1.5, 'lines'),
        legend.text = element_text(size=15, color = "#59595B"),
        legend.title = element_blank(),
        legend.title.align = 0.5,
        legend.spacing.x = unit(0.5, "cm"), 
        legend.spacing.y = unit(0.5, "cm"),
        legend.background = element_rect(linetype = 0, size = 0.5, colour = 1),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  coord_fixed(1.3)



total_thing$Density <- as.numeric(as.character(total_thing$Density))



ggplot() + 
  geom_polygon(data = total_thing, aes(x=long, y = lat, fill=Density, group=County), 
               color = "#f8f8fa", size = 0.25, show.legend = T) +
  scale_fill_viridis(alpha=1, option="viridis") + # fill tells R to look for continuous data to color
  theme_bw() +
  theme(plot.title = element_text(size = 26,color ="#105456",  vjust = -1),
        legend.position ="right",
        legend.direction = 'vertical',
        legend.key = element_rect(size = 5, color = NA),
        legend.key.size = unit(1.5, 'lines'),
        legend.text = element_text(size=15, color = "#59595B"),
        legend.title = element_blank(),
        legend.title.align = 0.5,
        legend.spacing.x = unit(0.5, "cm"), 
        legend.spacing.y = unit(0.5, "cm"),
        legend.background = element_rect(linetype = 0, size = 0.5, colour = 1),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  coord_fixed(1.3)



library(tidycensus)
library(tidyverse)
library(DT)
library(tools)
library(leaflet) 
library(sf) 
library(ggthemes)
library(wesanderson)
options(tigris_use_cache = TRUE) # Keeps map shapefiles on your hard drive rather than having to download them each time



mon <- get_acs(state = "WV", 
               county = "Monongalia", 
               geography = "tract", 
               variables = "B19013_001", 
               geometry = TRUE)



datatable(mon)


wes_palette("Rushmore1")



pal <- wes_palette("Rushmore1", 
                   max(mon$estimate), 
                   type = "continuous")



mon %>%
  ggplot(aes(fill = estimate)) + 
  geom_sf(color = NA) + 
  scale_fill_gradientn(colors = pal) +
  theme_map() 



racevars <- c(White = "P005003", 
              Black = "P005004", 
              Asian = "P005006", 
              Hispanic = "P004003")



mon_race <- get_decennial(geography = "tract",
                          variables = racevars,
                          state = "WV", 
                          county = "Monongalia County", 
                          geometry = TRUE,
                          summary_var = "P001001") 



datatable(mon_race)


mon_race %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct)) +
  facet_wrap(~variable) +
  geom_sf(color = NA) + 
  scale_fill_gradientn(colors = pal) +
  theme_map() 



mon_race %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct)) +
  facet_wrap(~variable) +
  geom_sf(color = NA) + 
  scale_fill_gradientn(colors = pal,
                       trans="log10") +
  theme_map() 

