
library(ggmap)
library(maps)
library(mapdata)
library(rgdal) 
library(tidyverse)
library(tools)
library(viridis)
library(censusapi)

Sys.setenv(CENSUS_KEY="YOUR API KEY HERE")



readRenviron("~/.Renviron") # You may get a warning...ignore it



Sys.getenv("CENSUS_KEY")



availableapis <- listCensusApis()



datatable(availableapis)





nrow(availableapis)



availableapis %>%
  filter_all(any_vars(grepl("income", .))) %>%
  datatable()





availableapis %>%
  filter(str_detect(description, 'income')) %>%
  datatable()





availableapis %>%
  filter(str_detect(description, c('geo'))) %>%
  filter(str_detect(description, c('demo'))) %>%
  drop_na(vintage) %>%
  arrange(-vintage) %>%
  datatable()





listCensusMetadata(name = "acs/acs5/profile", 
                   vintage = 2018,
                   type = "geography") %>%
  as_tibble() %>%
  unnest(cols = c()) 



vars <- listCensusMetadata(name = "acs/acs5/profile",
                           vintage = 2018, 
                           type = "variables") 



vars %>%
  as_tibble() %>%
    datatable()





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
library(tools) 
library(sf)
# For ore information on sf: https://r-spatial.github.io/sf/articles/sf1.html
library(DT) 
library(ggthemes)
library(wesanderson)
options(tigris_use_cache = TRUE) 







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



vars <- listCensusMetadata(name = "acs/acs5/profile",
                           vintage = 2018, 
                           type = "variables") 



vars %>%
  as_tibble() %>%
    filter(str_detect(label, "relate"))





poverty_data <- getCensus(name = "acs/acs5/profile", # same as above
                          vintage = 2018,
                          vars = c("NAME", "DP03_0126PE"), # column/variable name
                          key = Sys.getenv("CENSUS_KEY"), # using the census key from before
                          region = "county:*",# any county
                          regionin = "state:*") # any state



poverty_data_cleaned <- poverty_data %>%
                        separate(NAME, into = paste0('thing', 1:2), sep = '[,]') %>%
                        mutate(thing1 = str_replace_all(thing1, " County", "")) %>% # Remove the term County (with a space in front) 
                        mutate(thing2 = str_squish(thing2)) %>%
                        select(-c(state, county)) %>% # Get rid of these because we'll be using state and county names to merge
                        rename(county = thing1, 
                               state = thing2,
                               poverty_percentage = DP03_0126PE) %>%
                        mutate(poverty_percentage = replace(poverty_percentage,
                                                            which(poverty_percentage <= 0),
                                                            NA)) %>%
                        arrange(state, county)



poverty_data_cleaned %>% 
  head()



county_data <- map_data("county") %>% 
               rename(state = region, # rename because we'll use this to merge with the income_data_cleaned set
                      county = subregion) %>% # rename because we'll use this to merge with the income_data_cleaned set
               mutate(state = str_to_title(state)) %>% # make into a title case
               mutate(county = str_to_title(county)) # make into a title case 



county_data %>% 
  head()



map_data <- left_join(county_data, 
                      poverty_data_cleaned, 
                      by = c("state","county")) 



map_data %>% 
  head()



estimate_map <- 
  ggplot() + 
  geom_polygon(data = map_data, aes(x = long, 
                                    y = lat, 
                                    fill = poverty_percentage, 
                                    group = group),
               color = "#f8f8fa", 
               size = 0.20, 
               show.legend = TRUE) +
  geom_polygon(data=subset(map_data("state")), 
               aes(x = long, 
                   y = lat, 
                   group = group), 
               size = 0.5,
               color="white", 
               fill = NA) +
  scale_fill_gradient(name="Estimates", 
                      low = "#fa9fb5", 
                      high = "#7a0177",
                      breaks = c(0, 25, 50, 75, 100),
                      limits = c(0,100), 
                      na.value = "#c9d3d9",
                      labels = c(str_wrap("0.00% - 24.99%", 10), 
                                 str_wrap("25.00 - 49.99%", 10),
                                 str_wrap("50.00% - 74.99%", 10),
                                 str_wrap("75.00% - 99.99%", 10),
                                 "100%"),
                      guide = "legend") +
  theme(plot.title = element_text(size = 13,
                                  color ="#4682b4", 
                                  vjust = -1,
                                  hjust = 0.5,
                                  face = "bold"),
        plot.caption = element_text(size = 8,
                                    color ="#4682b4",
                                    face = "italic",
                                    margin = margin(t = 1, 
                                                    unit = "cm")),
        legend.position = "bottom",
        legend.direction = "horizontal",
        legend.key = element_rect(size = 5, 
                                  color = NA),
        legend.key.width = unit(2, 
                               "cm"),
        legend.key.height = unit(0.3, 
                               "cm"),
        legend.text = element_text(size = 8, 
                                   color = "#4682b4"),
        legend.title.align = 0.5,
        legend.title = element_text(size = 10, 
                                    color = "#4682b4"),
        legend.background = element_rect(linetype = 0, 
                                         size = 0.5, 
                                         color = 1),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(title = str_to_title(str_wrap("2014-2018 estimate of families with female householder, no husband present with related children of the householder under 18 years", 50)),
       caption = "Source: 2018 American Community Survey: 5-Year Estimates") +
  guides(fill = guide_legend(title.position = "top",
                             label.position = "bottom", 
                             label.hjust = 0.5)) 


----
estimate_map


----
estimate_map + 
  coord_map("albers", 
            lat0 = 39, 
            lat1 = 45)


----
estimate_map + 
  coord_quickmap()


----
estimate_map + 
  coord_map("azequalarea")


----
estimate_map + 
  coord_map("bonne", 
            lat0 = 50)


----
estimate_map + 
  coord_map("cylindrical")


----
estimate_map + 
  coord_map("gilbert")


----
estimate_map + 
  coord_map("lagrange")


----
estimate_map + 
  coord_map("mercator")



estimate_map +
  coord_map()


----
estimate_map + 
  coord_map("orthographic")


----
estimate_map + 
  coord_map("stereographic")



poverty_estimates_albers <- estimate_map +
                            coord_map("mercator")



ggsave("poverty_estimates.pdf",
       poverty_estimates_albers,
       width = 297,
       height = 210,
       units = "mm")

