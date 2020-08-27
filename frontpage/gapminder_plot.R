# Graphic for the bottom of the main page 

# Set the working directory as source  (if needed) ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects (if needed) ----
rm(list = ls())

# Load needed libraries ----
library(tidyverse)
library(dplyr)
library(ggiraph)
library(viridis)
library(wesanderson)
library(hrbrthemes)
library(htmlwidgets)
library(showtext)
font_add("Jost* Light", "Jost-300-Light.otf")
font_add("Jost* Medium", "Jost-500-Medium.otf")
font_add("Jost* Semi", "Jost-600-Semi.otf")
font_add("Jost* Semi Italic", "Jost-600-SemiItalic.otf")
font_add("Jost* Heavy", "Jost-800-Heavy.otf")
font_add("Jost* Black", "Jost-900-Black.otf")
showtext_auto()

library(tidyverse)
library(ggridges)
library(RColorBrewer)

gapminder_plot <- ggplot(OrchardSprays, aes(x=decrease,y=treatment,fill=treatment))+
  geom_density_ridges_gradient(scale=2.3,
                               show.legend = FALSE) + 
  theme_void()+
  scale_y_discrete(expand = c(0.5, 0)) +
  scale_x_continuous(expand = c(0.05, 0)) +
  scale_fill_brewer(palette = "Spectral")

gapminder_plot

#* Save it as a standard static plot ----
ggsave(gapminder_plot,
       file="static/img/gapminder_plot.png", 
       bg="transparent",
       width = 297,
       height = 210,
       units = "mm")
