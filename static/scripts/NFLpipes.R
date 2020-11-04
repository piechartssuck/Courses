# ----
library(tidyverse)
library(gapminder)

## install.packages("tidyverse")
## install.packages("gapminder")

# ----
head(gapminder)


# ----
gapminder %>% 
  head()


# ----
gapusa_filter <- filter(gapminder, country == "United States")

gapusa_filter


# ----
gapusa_select <- select(gapusa_filter, -continent, -lifeExp)

gapusa_select


# ----
gapusa <- gapminder %>% 
  filter(country == "United States") %>%
  select(-continent, -lifeExp) 

gapusa


# ----
gapminder %>%
  mutate(gdp = pop * gdpPercap)


# ----
gapminder %>%
  filter(continent == "Europe",
         year == 2007) %>%
  mutate(pop_thousands = pop/1000) %>%
  select(country, year, pop_thousands) #this cleans up the dataframe but isn't necessary


# ----
gapminder %>%
  filter(year == 2002) %>%
  group_by(continent) %>% 
  mutate(cont_pop = sum(pop))


# ----
gapminder %>%
  group_by(continent) %>%
  summarize(cont_pop = sum(pop)) %>%
  ungroup()


# ----
gapminder %>%
  group_by(continent, year) %>%
  summarize(cont_pop = sum(as.numeric(pop))) %>%
  ungroup()


# ----
gapminder %>%
  group_by(continent, year) %>%
  summarize(cont_pop = sum(as.numeric(pop))) %>%
  arrange(year) %>%
  ungroup()


# ----
gapminder %>%
  mutate(gdp = pop * gdpPercap) %>%
  group_by(continent) %>%
  mutate(max_gdp = max(gdp)) %>%
  filter(gdp == max_gdp) %>%
  select(-country)


# ----
nfl2014 <- read_csv("2014-average-ticket-price.csv")

# ----
str(nfl2014)


# ----
glimpse(nfl2014)


# ----
nfl2014 %>%
  select(Division, `Avg TP, $`) %>%
  group_by(Division) %>%
  na.omit() %>%
  summarize(Mean_by_Division = mean(`Avg TP, $`, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(Mean_by_Division))


# ----
nfl2014 %>%
select(Division, `Avg TP, $`) %>%
  filter(str_detect(Division, "AFC")) %>%
  na.omit() %>%
  summarize(AFC_mean = mean(`Avg TP, $`, na.rm = TRUE))




# ----
drinks <- read_csv("drinks2010andBeyond.csv")

# ----
drinks %>%
  filter(`Beverage Types` == "Beer" | `Beverage Types` == "Wine") %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  group_by(year, Country) %>%
  summarize(avg = mean(measure)) %>%
  top_n(n=1, avg)


# ----
drinks %>%
  filter(`Beverage Types` == "Spirits") %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  group_by(year, Country) %>%
  summarize(avg = mean(measure)) %>%
  top_n(n=1, avg)


# ----
drinks %>%
  filter(`Beverage Types` == "All types")  %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  group_by(year, Country) %>%
  summarize(avg = mean(measure)) %>%
  top_n(n=1, avg)


# ----
# USA only
drinks %>%
  filter(`Beverage Types` == "Beer" & Country == "United States of America") %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  summarize(avg = mean(measure), stanDev = sd(measure)) 

# Remaining countries
drinks %>%
  filter(`Beverage Types` == "Beer" & Country != "United States of America") %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  summarize(avg = mean(measure), stanDev = sd(measure)) 


# ----
drinks %>%
  mutate(`2016` = 33.814022 * `2016`) %>%
  rename(`2016 (using garbage measurements)` = `2016`)


# ----
drinks %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  mutate(`measure` = 33.814022 * `measure`) %>%
  rename(`Measures (in ounces because that's apparently easy)` = `measure`)


# ----
coalesce_by_column <- function(df) {
  return(dplyr::coalesce(!!! as.list(df)))
}

drinks %>%
  gather(key = "year", value = "measure", -Country, -`Beverage Types`) %>%
  na.omit() %>%
  rowid_to_column("Country ID") %>%
  spread(`Beverage Types`, value = `measure`) %>%
  select(-`Country ID`) %>%
  group_by(Country, year) %>%
  summarise_all(coalesce_by_column) %>%
  na_if(0)

