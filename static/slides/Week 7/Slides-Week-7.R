# ----
library(tidyverse)


# ----
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


# ----
minimum = 2.5
maximum = 3
m = 2.83
n = 85
stdev = 1.2

f <- function(x) n*x*pnorm(x)^(n-1)*dnorm(x) 
num <- integrate(f,-Inf,Inf) 
ci <- 2 * num$value

lb <- m - ci
ub <- m + ci

ll <- round(lb)
ul <- round(ub)

ggplot(data.frame(x = c(lb, ub)), aes(x = x)) + 
  stat_function(fun = dnorm, args = list(mean = m, sd = stdev)) + 
  stat_function(fun = shading_beq, args = list(lower_bound = minimum,
                                           upper_bound = maximum), 
            geom = "area", fill = "#3d8ba9", alpha = 0.6) +
  scale_x_continuous(breaks = seq(ll, ul, stdev),
                 limits = c(2, 3.5)) + 
  geom_vline(xintercept = m, color = "#65737e") +
  theme_minimal(base_size = 22) +
  theme(panel.border = element_blank(), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
    )


# ----
minimum = 2.5
maximum = 3
m = 2.00
n = 180
stdev = 0.8

f <- function(x) n*x*pnorm(x)^(n-1)*dnorm(x) 
num <- integrate(f,-Inf,Inf) 
ci <- 2 * num$value

lb <- m - ci
ub <- m + ci

ll <- round(lb)
ul <- round(ub)

ggplot(data.frame(x = c(lb, ub)), aes(x = x)) + 
  stat_function(fun = dnorm, args = list(mean = m, sd = stdev)) + 
  stat_function(fun = shading_beq, args = list(lower_bound = minimum,
                                           upper_bound = maximum), 
            geom = "area", fill = "#3d8ba9", alpha = 0.6) +
  scale_x_continuous(breaks = seq(ll, ul, stdev),
                 limits = c(2, 3.5)) + 
  geom_vline(xintercept = m, color = "#65737e") +
  theme_minimal(base_size = 22) +
  theme(panel.border = element_blank(), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
    )


# ----
pnorm(16.77) - pnorm(8.38)

