# Graphic for the bottom of the main page 

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects ----
rm(list = ls())

# Libraries
library(tidyverse)
library(ggtext)
library(cowplot)
library(patchwork)
library(showtext)
library(showtextdb)
library(glue)
library(LaCroixColoR)
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


#Read file
data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-20/beer_awards.csv')

#Make some information
data1 <- data %>%
  filter(medal=="Gold")%>%
  group_by(year, state)%>%
  mutate(count = n())%>%
  distinct(year, state, count)%>%
  filter(year > 1999)%>%
  filter(count > 5)

#Get toal gold medals
data2 <- data%>%
  filter(medal=="Gold" & year > 1999)%>%
  group_by(year)%>%
  mutate(count2 = n())%>%
  distinct(year, count2)

#Total medals
data3 <- data%>%
  filter(year >1999)%>%
  filter(medal=="Gold")

#Colors
pal <- "PassionFruit"
col1 <- lacroix_palette(pal, n = 8, type = "continuous")
col2 <- lacroix_palette(pal, n = 21, type = "continuous")



#Themes
#ggplot
p2 <- ggplot(data1, aes(x = year, y = count)) + 
  geom_col(aes(fill=state),
           alpha = 0.77,
           width = 0.9,
           show.legend = FALSE) + 
  scale_fill_manual(values = col1) +
  coord_polar(theta = "y", start=0, clip="off")+
  scale_x_continuous(limits = c(1995, 2023), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 80)) + 
  theme_void()

#Run it!
p2

p1 <- ggplot(data2, aes(x = year, y = count2, fill = factor(year))) + 
  geom_bar(aes(), stat='identity',
           width = 0.9,
           alpha = 0.77,
             show.legend = FALSE) +
  scale_fill_manual(values = col2) +
  scale_size_continuous(range = c(1, 15)) +
  scale_y_reverse(breaks=c(0,40,80), position = "right")+
  coord_flip()+
  theme_void()+
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    axis.line.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank())

ggdraw(p2) + 
      draw_plot(p1, 
            x=-0.020, 
            y=0.55, 
            width = 0.54, 
            height = 0.328) 

