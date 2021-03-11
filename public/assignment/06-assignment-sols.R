
library(tidyverse)
library(tidycensus)
library(DT)
library(wesanderson)
library(ggthemes)
library(scales)



head(tidycensus::fips_codes)



vars_of_interest <- c(median_income = "B19013_001")



national_data <- get_acs(geography = "county",
                         variables = vars_of_interest,
                         year = 2016,
                         survey = "acs5",
                         shift_geo = TRUE,
                         geometry = TRUE) %>%
                         rename(`Median Income` = estimate)



datatable(national_data)  



wes_palette("Darjeeling2")



darj2 <- wes_palette("Darjeeling2",
                      max(national_data$`Median Income`, 
                      na.rm = TRUE), 
                      type = "continuous")



ggplot() + 
  geom_sf(data = national_data,
          mapping = aes(fill = `Median Income`),
          color = NA) + 
  coord_sf(datum = NA) +
  scale_fill_gradientn(colors = darj2)  + 
  theme_minimal() +
  theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5)) +
  ggtitle(stringr::str_wrap("2016 ACS Median Income for the United States", 35))



region1 = c("CT", "ME", "MA", "NH", "RI", "VT", "NJ", "NY", "PA")



multistate_tract_data <- get_acs(geography = "tract",
                                 variables = vars_of_interest,
                                 state = region1,
                                 year = 2016,
                                 survey = "acs5",
                                 geometry = TRUE) %>%
                          rename(`Median Income` = estimate)



datatable(multistate_tract_data)



multistate_tract_data %>%
  head() %>%
  kbl()



multistate_state_data <- get_acs(geography = "state",
                                 variables = vars_of_interest,
                                 state = region1,
                                 year = 2016,
                                 survey = "acs5",
                                 geometry = TRUE) %>%
                          rename(`Median Income` = estimate)



datatable(multistate_state_data)



multistate_tract_data %>%
  head() %>%
  kbl()



wes_palette("Darjeeling1")



darj1 <- wes_palette("Darjeeling1",
                     max(multistate_tract_data$`Median Income`, 
                         na.rm = TRUE), 
                     type = "continuous")



ggplot() + 
  geom_sf(data = multistate_tract_data,
                   mapping = aes(fill = `Median Income`),
                   color = NA) + 
  scale_fill_gradientn(colors = darj1) +
  theme_map() 



ggplot() + 
  geom_sf(data = multistate_tract_data,
                   mapping = aes(fill = `Median Income`),
                   color = NA) + 
  geom_sf(data = multistate_state_data,
                   color = "#f7f7f7",
                   fill = NA) + 
  scale_fill_gradientn(colors = darj1,
                       label = scales::dollar) +
  theme_map() +
  theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5),
        legend.position = c(0.8,0.1),
        legend.title = element_text(size = 12,
                                    face = "bold",
                                    color = "#3392a4",
                                    hjust = 0.5,
                                    margin = margin(b = 10)),
        legend.text = element_text(size = 10,
                                   face = "bold",
                                   color = "#2d8292")) +
  ggtitle("2016 ACS Median Income for Census Region 1")



state_data <- get_acs(geography = "state",
                      variables = vars_of_interest,
                      year = 2016,
                      survey = "acs5",
                      shift_geo = TRUE,
                      geometry = TRUE) %>%
                      rename(`Median Income` = estimate)



datatable(state_data)  



wes_palette("Zissou1")



ziss1 <- wes_palette("Zissou1",
                     max(state_data$`Median Income`, 
                         na.rm = TRUE), 
                     type = "continuous")



ggplot() + 
  geom_sf(data = state_data,
          mapping = aes(fill = `Median Income`),
          color = NA) + 
  scale_fill_gradientn(colors = ziss1) +
  theme_map() +
  theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5)) +
  ggtitle("2016 ACS Median Income for All US States")



lower_48 <- state_data %>%
            filter(GEOID < 60) %>%
            filter(!NAME == "Hawaii") %>%
            filter(!NAME == "Alaska")



ggplot() + 
 geom_sf(data = lower_48,
         mapping = aes(fill = `Median Income`),
         color = NA) + 
 scale_fill_gradientn(colors = ziss1) +
 theme_map() +
    coord_sf(crs = 5070, 
             datum = NA) +
 theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5)) +
  ggtitle(stringr::str_wrap("2016 ACS Median Income for the Contiguous US States", 35))



kansas <- get_acs(state = "KS", 
                  geography = "county", 
                  variables = vars_of_interest,
                  geometry = TRUE) %>%
                  rename(`Median Income` = estimate)



datatable(kansas)





wes_palette("FantasticFox1")



ffox <- wes_palette("FantasticFox1",
                     max(kansas$`Median Income`, 
                         na.rm = TRUE), 
                     type = "continuous")



kansas %>%
  ggplot(aes(fill = `Median Income`)) + 
  geom_sf(color = NA) + 
  scale_fill_gradientn(colors = ffox,
                       label = scales::dollar) +
  theme_map() +
  theme(legend.position = "bottom",
        legend.direction = "horizontal",
        legend.title.align=0.5) +   
  guides(fill = guide_legend(title.position="top")) +
 theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5)) +
  ggtitle("2016 ACS Median Income for the Counties in Kansas")



doug <- get_acs(state = "KS", 
                county = "Douglas", 
                geography = "tract", 
                variables = vars_of_interest,
                geometry = TRUE) %>%
                rename(`Median Income` = estimate)



datatable(doug)





wes_palette("Cavalcanti1")



caval <- wes_palette("Cavalcanti1",
                     max(doug$`Median Income`, 
                         na.rm = TRUE), 
                     type = "continuous")



doug %>%
  ggplot(aes(fill = `Median Income`)) + 
  geom_sf(color = NA) + 
  scale_fill_gradientn(colors = caval,
                       label = scales::dollar) +
  theme_map() +
  theme(legend.position = "bottom",
        legend.key.width = unit(3, "line")) +   
  guides(fill = guide_legend(title.position="top", 
                              title.hjust =0.5))  +
 theme(plot.title = element_text(size = 20,
                                  face = "bold",
                                  color = "#005b5b",
                                  hjust = 0.5)) +
  ggtitle(stringr::str_wrap("2016 ACS Median Income for the Census Tracts in Kansas", 35))

