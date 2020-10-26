## ----echo = FALSE, eval = TRUE, message=FALSE------------------------------
library(tidyverse)


## ----echo = FALSE----------------------------------------------------------
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


## ----eval = TRUE, echo = FALSE---------------------------------------------
errors <- tibble(
Decision = c("Reject Null",
             "Fail to Reject Null"),

`Null is True` = c("Type I Error<br>(aka False Positive)",
                   "Correct Outcome<br>(aka True Negative)"),

`Null is False` = c("Correct Outcome<br>(aka True Positive)",
                    "Type II Error<br>(aka False Negative)")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(errors, 
      escape = FALSE,
      align = 'lll') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE---------------------------------------------
decision_gen <- tibble(
`Reality` = c("Null is True",
             "Null is False"),

`Did Not Reject Null` = c("Correct decision<br><br>1-α<br><br>Level of Confidence",
                   "Type II Error<br><br>β<br><br>Underpower"),

`Rejected Null` = c("Type I Error<br><br>α<br><br>Level of Significance",
                    "Correct Decision<br><br>1-β<br><br>Statistical Power!")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(decision_gen, 
      escape = FALSE,
      align = 'lll') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE---------------------------------------------
example_gen <- tibble(
Reality = c("Forecast was right",
             "Forecast was wrong"),

`Did not reject the forecast` = c("Did not take an umbrella and you're dry",
             "Did not take an umbrella AND you're wet"),

`Rejected forecast` = c("Took an umbrella AND you're dry but may look silly (or fancy)",
                    "Took an umbrella AND you're dry")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(example_gen, 
      escape = FALSE,
      align = 'lll') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE---------------------------------------------
sig_est <- tibble(
Classification = c("Process",
             "Outcomes"),

`Hypothesis Testing` = c("Determine the probability of getting that mean if the Null is true",
             "Gain information about the population mean"),

`Rejected forecast` = c("Estimate the value of a population mean",
                    "Gain information about the population mean")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(sig_est, 
      escape = FALSE,
      align = 'lll') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")


## ----eval = TRUE, echo = FALSE---------------------------------------------
hyp_est <- tibble(
Question = c("Do we know the population mean?",
             "What is the process use dto determine?",
             "What is learned?",
             "What is our decision?"),

`Hypothesis Testing` = c("Yes its the Null hypothesis",
             "The chance of obtaining a sample mean", 
             "Whether the population mean is likely correct",
             "To retain or reject the null hypothesis"),

`Point/Interval Estimation` = c("No we're trying to estimate it",
                    "The value of a population mean",
                    "The range of values within which the population mean is probably contained",
                    "No actual decison")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(hyp_est, 
      escape = FALSE,
      align = 'lll') %>%
  kable_styling(full_width = FALSE) %>%
  column_spec(1, width = "10em") %>%
  column_spec(2, width = "10em") %>%
  column_spec(3, width = "10em") %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121") %>%
  row_spec(4, background = "#212121")


## ----eval = TRUE, echo = FALSE---------------------------------------------
conf <- tibble(
Probability = c("0.90",
                "0.95",
                "0.99"),

`z-score` = c("1.645",
                "1.96", 
                "2.576")
)


## ----message=FALSE, warning=FALSE, eval = TRUE, echo = FALSE---------------
kable(conf, 
      escape = FALSE,
      align = 'cc') %>%
  kable_styling(full_width = FALSE) %>%
  row_spec(0, background = "#212121") %>%
  row_spec(2, background = "#212121")

