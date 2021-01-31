# Graphic for the bottom of the main page 

# Set the working directory as source  (if needed) ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects (if needed) ----
rm(list = ls())
 
library(tidyverse)
library(here)
library(showtext)
font_add("Jost* Light", "Jost-300-Light.otf")
font_add("Jost* Medium", "Jost-500-Medium.otf")
font_add("Jost* Semi", "Jost-600-Semi.otf")
font_add("Jost* Semi Italic", "Jost-600-SemiItalic.otf")
font_add("Jost* Bold", "Jost-700-Bold.otf")
font_add("Jost* Heavy", "Jost-800-Heavy.otf")
font_add("Jost* Black", "Jost-900-Black.otf")
font_add("Canela Text Medium", "Canela-Medium.otf")
font_add("Canela Text Bold", "Canela-Bold.otf")
font_add("Canela Text Black", "Canela-Black.otf")
showtext_auto()

bird_counts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-18/bird_counts.csv")

confused <- bird_counts %>%
  mutate(
    pair = case_when(
      species == "Hairy Woodpecker" | 
        species == "Downy Woodpecker" ~ "A",
      species == "American Tree Sparrow" | 
        species == "House Sparrow" ~ "B",
      species == "Sharp-shinned Hawk" | 
        species == "Cooper's Hawk" ~ "C",
      TRUE ~ "")
  ) %>%
  filter(pair != 0)

confusedSplit <- split(confused, f = confused$pair)

confusedSplit$A %>%
  filter(how_many_counted < 20)

p1 <- confusedSplit$A %>%
  filter(how_many_counted < 280) %>%
  ggplot(aes(year, how_many_counted, group = species)) +
  geom_area(aes(fill = species), alpha = 0.98, show.legend = FALSE) +
  scale_y_continuous(position = "right", breaks = c(0, 20),
                     expand = expansion(mult = 2.3)) +
  scale_fill_manual(values = c("#419873", "#edc951")) +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "transparent",colour = NA),
    plot.background = element_rect(fill = "transparent",colour = NA),
    legend.position = "top",
    legend.direction = "vertical",
    panel.grid = element_blank(),
    axis.line.x = element_line(size = rel(0.4)),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks = element_line(),
    axis.ticks.length = unit(5, "points"),
    panel.spacing = unit(3, "lines")
  ) +
  theme_void() +
  theme(plot.margin=grid::unit(c(0,0,0,0), "mm"))

p1

ggsave("scatter.png", 
       p1, 
       bg = "transparent",
       width=11, 
       height=8.5)

# adapted from https://github.com/gkaramanis/tidytuesday/blob/master/week-25/xBirdCounts.R
  
  