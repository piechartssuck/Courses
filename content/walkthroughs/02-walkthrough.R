
## library("tidyverse")


## install.packages("fivethirtyeight", dependencies = TRUE)


## library("fivethirtyeight")


?tarantino


data("drinks", package = "fivethirtyeight")


drinks


class(drinks)

## drinks <- read_csv("drinks.csv")

## drinks

drinks[c(1, 2, 3, 4, 5), ]

slice(drinks, 1:5)


## drinks[, "beer_servings"]
## drinks$beer_servings
## drinks[["beer_servings"]]

drinks$beer_servings

drinks[1:5, "beer_servings"]

drinks %>%
  slice(1:5) %>%
  select(beer_servings)

drinks %>%
  slice(1:5) %>%
  select(country, beer_servings)

drinks %>%
  slice(1:5) %>%
  select(-spirit_servings)

## write_csv(drinks, "new_drinks.csv")

?write_csv

## write_sav(drinks, "new_drinks.sav")

