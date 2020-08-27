# Graphic for the bottom of the main page 

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects ----
rm(list = ls())

# Libraries
library(tidyverse)
library(RColorBrewer)
library(ggpomological)
library(ggridges)
library(hexSticker)
library(wesanderson)
library(showtext)
font_add("Kit&Caboodle Regular", "KitAndCaboodle.otf")
showtext_auto()

# library
library(ggplot2)
library(dplyr)

# Create data (this takes more sense with a numerical X axis)
x <- seq(0, 2*pi, 
         length.out=50)

data <- data.frame(
  x=x, 
  y=sin(x) + 
    rnorm(500, 
          sd=0.2)
)

# Add a column with your condition for the color
data <- data %>% 
  mutate(mycolor = ifelse(y > 0, 
                          "type1", 
                          "type2"))

# plot
sin_w <- ggplot(data, aes(x=x, 
                 y=y)) +
  geom_segment(aes(x=x, 
                    xend=x, 
                    y=0, 
                    yend=y, 
                    color=y), 
                size=0.1, 
                alpha=0.9,
               show.legend = FALSE) +
  scale_color_gradient(low = "#ff5b77",
                       high = "#5bc0de") +
  theme_void()

  
sticker(sin_w, 
        package="EDP 613", 
        p_size=9.5, 
        s_x=1.0, 
        s_y=1.0, 
        s_width=1.5, 
        s_height=1.5,
        h_fill="#292A30",
        h_color="#293840",
        p_family = "Kit&Caboodle Regular",
        filename="course_hex.png")

