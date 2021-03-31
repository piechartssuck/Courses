library(tidyverse)
library(patchwork)
library(brms)
library(rstanarm)
library(raster)
library(baseballr)
library(tidybayes)
library(bayesplot)
library(showtext)
font_add("Jost* Semi", "Jost-600-Semi.otf")
font_add("Jost* Semi Italic", "Jost-600-SemiItalic.otf")
font_add("Jost* Black", "Jost-900-Black.otf")
font_add("Jost* Medium", "Jost-500-Medium.otf")
font_add("Jost* Light", "Jost-300-Light.otf")
font_add("Jost* Heavy", "Jost-800-Heavy.otf")
showtext_auto()

# Note: Use the following two lines to install the `baseballr` package -
# install.packages("devtools")
# devtools::install_github("BillPetti/baseballr")

# Github poge: https://github.com/BillPetti/baseballr
# Some examples and explanations: https://billpetti.github.io/baseballr/


randomthings <- tibble(
  age = c(38, 45, 52, 61, 80, 74), 
  prop = c(0.146, 0.241, 0.571, 0.745, 0.843, 0.738)
)

jv <- rbind(pitcher_game_logs_fg(playerid = 8700, year = 2010),
            pitcher_game_logs_fg(playerid = 8700, year = 2011),
            pitcher_game_logs_fg(playerid = 8700, year = 2012),
            pitcher_game_logs_fg(playerid = 8700, year = 2013),
            pitcher_game_logs_fg(playerid = 8700, year = 2014),
            pitcher_game_logs_fg(playerid = 8700, year = 2015),
            pitcher_game_logs_fg(playerid = 8700, year = 2016),
            pitcher_game_logs_fg(playerid = 8700, year = 2017),
            pitcher_game_logs_fg(playerid = 8700, year = 2018),
            pitcher_game_logs_fg(playerid = 8700, year = 2019),
            pitcher_game_logs_fg(playerid = 8700, year = 2020)
) %>%
  as_tibble() %>%
  separate(Date, into = c("Year", "Month", "Day"))
 
  
full <- jv %>%
  dplyr::select(Year, Month, FIP, BABIP) %>%
  mutate(FIP = as.numeric(FIP),
         BABIP = as.numeric(BABIP),
         Year = as.numeric(Year)) %>%
  group_by(Year, Month) %>%
  summarize(avg_FIP = mean(FIP, na.rm = TRUE),
            avg_BABIP = mean(BABIP, na.rm = TRUE)) %>%
  filter(avg_BABIP >=0.30) %>%
  mutate(avg_BABIP = fct_reorder(as_factor(avg_BABIP), Year)) %>%
  unite("MoYr", 
        c("Month", "Year"), 
        sep = "/",
        remove = FALSE)
  

# Observe the data ----

ggplot(full, aes(x = as.numeric(avg_BABIP), 
                 y = avg_FIP,
                 fill = "avg_FIP")) + 
  theme_minimal() + 
  theme(plot.title = element_text(size=22,
                             hjust = 0.5,
                             margin = margin(b = 20)),
        axis.title.x = element_text(size=18,
                                    margin = margin(t = 20)),
        axis.title.y = element_text(size=18,
                                    margin = margin(r = 20)),
        axis.text.x = element_text(size=12,
                                 angle = 45),
        axis.text.y = element_text(size=12),
        panel.grid.major.x = element_line(color = "#addfee"), 
        panel.grid.major.y = element_blank(),
        panel.grid.minor = element_blank()) +
  expand_limits(y = 0:10)  +
  geom_line(method="lm", 
            stat = "smooth",
            se=TRUE, 
            formula = y ~ poly(x, 3, 
                               raw=TRUE),
            color="#ff6347",
            alpha = 0.65, 
            size = 2,
            show.legend = FALSE) +
  geom_point(color = "#333333", 
             shape = 21,
             size = 3, 
             alpha = 0.7,
             stroke = 1.3,
             show.legend = FALSE) + 
  scale_fill_manual(values = c("#4682b4")) +
  scale_x_continuous(breaks=seq(1,21,1),
                     labels = unique(full$MoYr)) +
  labs(title = "Justin Verlander BABIP vs FIP Over the Years",
       x = "Average BABIP by Month",
       y = "Average FIP")

# Subset ----
priors <- full %>%
  filter(!Year <= 2015) 

  ggplot(priors, aes(x = as.numeric(avg_BABIP), 
             y = avg_FIP, 
             fill = "avg_FIP")) + 
  theme_minimal() + 
  theme(axis.title.x = element_text(size=18,
                                    margin = margin(t = 20))) +
  theme(axis.title.y = element_text(size=18,
                                 margin = margin(r = 20))) +
  expand_limits(y = 0:10) +
  geom_line(method="lm", 
            stat = "smooth",
              se=TRUE, 
              formula = y ~ poly(x, 3, 
                                 raw=TRUE),
              color="#ff6347",
              alpha = 0.65, 
              size = 2,
              show.legend = FALSE) +
  geom_point(color = "#333333", 
             shape = 21,
             size = 3, 
             alpha = 0.7,
             stroke = 1.3,
             show.legend = FALSE) + 
  scale_fill_manual(values = c("#4682b4")) +
  labs(x = "Average BABIP by Annum",
       y = "Average FIP")


form  <- lm(avg_FIP ~ poly(as.numeric(avg_BABIP, 3,
                              raw=TRUE)),
             data = priors)

predict(form)

# BABIP: Batting Average on Balls in Play
# https://www.espn.com/blog/statsinfo/post/_/id/61715/mlb-stat-definition-babip

# FIP: Fielding Independent Pitching
# https://www.espn.com/blog/statsinfo/post/_/id/62051/mlb-stat-definition-what-is-fip

fit <- stan_glm(avg_FIP ~ avg_BABIP, data = priors)
posterior <- as.matrix(fit)

mcmc_areas(posterior,
         #  pars = c("avg_BABIP"),
           prob = 0.8) 

color_scheme_set("red")
ppc_dens_overlay(y = fit$y,
                 yrep = posterior_predict(fit, draws = 50))

# also works nicely with piping
color_scheme_set("brightblue")

fit %>%
  posterior_predict(draws = 500) %>%
  ppc_stat_grouped(y = priors$avg_FIP,
                   group = as.numeric(priors$avg_BABIP),
                   stat = "median")
