library(tidycensus)
library(tidyverse)

# Input your Census key
# census_api_key("YOUR CENSUS API KEY")
## get a key!: https://api.census.gov/data/key_signup.html

# Reload the .Renviron marker
# readRenviron("~/.Renviron")


wv_pop <- get_acs(geography = "county", 
                     variables = "B01003_001", 
                     state = "WV",
                     geometry = TRUE) %>%
          tibble() %>%
          select(Location = NAME,
                 Population = estimate) %>%
          separate(Location, c("County", "State"), sep = ",") %>%
          mutate(County = str_remove_all(County, " County")) %>%
          mutate(State = str_squish(State)); wv_pop

write_csv(wv_pop, "wv_pop.csv")

plot(factor(wv_pop$County), wv_pop$Population, type="p")


height <- c(145, 167, 176, 123, 150)
weight <- c(51, 63, 64, 40, 55)

plot(height,weight)
