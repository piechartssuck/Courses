# Graphic for the bottom of the main page 

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects ----
rm(list = ls())

# Libraries
library(tidyverse)
library(RColorBrewer)
library(hexSticker)
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

# Wrangle ----
spiral_data <- data.frame(date = seq.Date(from = as.Date("2018-01-01"), 
                                     to = as.Date("2020-12-31"), 
                                     by = 1),
                     day_num = 1:1096,
                     temp = rnorm(1096, 5, 5)) %>%
                     mutate(inv_temp = 1/temp)

spiral <- ggplot(spiral_data, aes(x = day_num %% 365, 
                   y = 0.07*day_num + temp/2,
                   height = temp,
                   fill = temp, 
                   color = inv_temp)) + 
          geom_tile() + 
          scale_y_continuous(limits = c(-20, NA)) +
          scale_x_continuous(breaks = 100*0:11, 
                             minor_breaks = NULL) +
          coord_polar() + 
          scale_fill_viridis_c(option = "B") + 
          theme_void() +
          guides(fill = FALSE,
                 color = FALSE)

spiral

# Save the various types of hex ----
sticker(spiral, 
        package="EDP 617", 
        p_size=7, 
        p_x = 1,
        p_y = 1.41,
        s_x=1.0, 
        s_y=0.75, 
        s_width=1.2, 
        s_height=1.2,
        h_fill="#292A30",
        h_color="#293840",
        p_family = "Canela Text Black",
        filename="course_hex.png")

sticker(spiral, 
        package="EDP 617", 
        p_size=7, 
        p_x = 1,
        p_y = 1.41,
        s_x=1.0, 
        s_y=0.75, 
        s_width=1.2, 
        s_height=1.2,
        h_fill="#292A30",
        h_color="#293840",
        p_family = "Canela Text Black",
        filename="hex.png")

sticker(spiral, 
        package="", 
        s_x=1.0, 
        s_y=1.0, 
        s_width=1.6, 
        s_height=1.6,
        h_fill="#292A30",
        h_color="#293840",
        filename="icon.png")

ggsave("slack_hex.png",
       spiral,
       bg = "#293840")

# init borrowed from https://stackoverflow.com/questions/52939337/how-to-create-a-time-series-spiral-graph-using-r