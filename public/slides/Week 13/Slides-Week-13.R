## ----echo = FALSE, eval = TRUE, message=FALSE---------------------------------
library(tidyverse)


## ----eval = TRUE, echo = FALSE------------------------------------------------

study1 <- tibble(
  
`Low Calorie` = c("8",
                 "9",
                 "6",
                 "7",
                 "3"),
  
`Low Fat` = c("2",
              "4",
              "3",
              "5",
              "1"),

`Low Carbohydrate` = c("3",
                       "5",
                       "4",
                       "2",
                       "3"),

`Control` = c("2",
              "2",
              "-1",
              "0",
              "3")
 
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE------------------

kable(study1, 
      escape = FALSE,
      align = 'cccc') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em", bold = TRUE) %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  column_spec(4, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121") %>%
  row_spec(4, background = "#212121") 



## ----eval = TRUE, echo = FALSE------------------------------------------------

study2 <- tibble(
  
`Source of Variation` = c("Between treatment",
                 "Error",
                 "Total"),
  
`Sum of Squares (SS)` = c("75.8",
              "47.4",
              "123.2"),

`Degrees of Freedom (df)` = c("4-1=3",
                       "20-4=16",
                       "20-1=19"),

`Means Squared` = c("75.8/3=25.3",
              "47.4/16",
              ""),

`F` = c("25.3/3 = 8.43",
              "",
              "")
 
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE------------------

kable(study2, 
      escape = FALSE,
      align = 'lcccc') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em", bold = TRUE) %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  column_spec(4, width = "10em") %>%
  column_spec(5, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121") 


