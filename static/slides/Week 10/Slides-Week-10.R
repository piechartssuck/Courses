## ----echo = FALSE, eval = TRUE, message=FALSE-----------------------------------
library(tidyverse)


## ----echo = FALSE---------------------------------------------------------------
shading_geq <- function(x, lower_bound) {
  y = dnorm(x, mean = m, sd = stdev)
  y[x < lower_bound] <- NA
  return(y)
}

shading_leq <- function(x, upper_bound) {
  y = dnorm(x, mean = m, sd = stdev)
  y[x > upper_bound] <- NA
  return(y)
}

shading_beq <- function(x, lower_bound, upper_bound) {
  y = dnorm(x, mean = m, sd = stdev)
  y[x < lower_bound | x > upper_bound] <- NA
  return(y)
}

shading_neq <- function(x, lower_bound, upper_bound) {
  y = dnorm(x, mean = m, sd = stdev)
  y[x > lower_bound | x < upper_bound] <- NA
  return(y)
}


## ----echo = FALSE, eval= TRUE, warning = FALSE, out.width = '30%'---------------
ggplot(NULL, aes(c(-3,3))) +
 geom_area(stat = "function", fun = dnorm, fill = "#428bca", xlim = c(-3, 1), color = "#000000", size = 0.4) +
  geom_area(stat = "function", fun = dnorm, fill = "#FFFFFF", xlim = c(1, 3), color = "#000000", size = 0.4) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_blank())


## ----echo = FALSE, eval= TRUE, warning = FALSE, out.width = '30%'---------------
ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#FFFFFF", xlim = c(-3, 1), color = "#000000", size = 0.4) +
  geom_area(stat = "function", fun = dnorm, fill = "#428bca", xlim = c(1, 3), color = "#000000", size = 0.4) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_blank())


## ----echo = FALSE, eval= TRUE, warning = FALSE, out.width = '30%'---------------
ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#428bca", xlim = c(-3, 1), color = "#000000", size = 0.4) +
  geom_area(stat = "function", fun = dnorm, fill = "#428bca", xlim = c(1, 3), color = "#000000", size = 0.4) +
    geom_segment(aes(x = 1, y = 0, xend = 1, yend = 0.25), linetype=1, size = 2, color = "#FFFFFF") +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_blank())


## ----eval = TRUE, echo = FALSE--------------------------------------------------
income <- tibble(
Region = c("United States",
             "West Virginia"),

`Per Capita Income` = c("$27,334",
                        "$19,443"),

`Median Household Income` = c("$51,914",
                              "$38,380"),

`Median Family Income` = c("$62,982",
                           "$48,896"),

Population = c("308,745,538",
                "1,852,994"),

Households = c("116,716,292",
                "763,831")

)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE--------------------
kable(income, 
      escape = FALSE,
      align = 'cccccc') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  column_spec(4, width = "10em") %>%
  column_spec(5, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE--------------------------------------------------
heart <- tibble(
`During Heartbeats` = c(93, 90, 95, 92, 95, 91),

`Between Heartbeats` = c(98,94,96,91,97,97)

)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE--------------------
kable(heart, 
      escape = FALSE,
      align = 'cc') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE--------------------------------------------------
heart_diff <- tibble(
`During Heartbeats` = c(93, 90, 95, 92, 95, 91, NA),

`Between Heartbeats` = c(98,94,96,91,97,97,NA),

Difference = c(-5,-4,-1,1,-2,-6,-17),

`Variance of Difference` = c(25,16,1,1,4,36,83)

)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE--------------------
kable(heart_diff , 
      escape = FALSE,
      align = 'cc') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  column_spec(4, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")

