# Graphic for the bottom of the main page 

# Set the working directory as source  (if needed) ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects (if needed) ----
rm(list = ls())
 
library(tidyverse)
library(viridis)
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

  n <- 9000 # number of participants
  position <- 1:n
  evaluand <- factor(rep(1:8, each=n/8))
  p.value <- runif(n)
  emotib <- tibble(position = position, 
                   Sentiment = evaluand, 
                   p.value = p.value,
                   Scale = log(p.value)^2) %>%
            mutate(Sentiment = case_when(
              Sentiment == 8 ~ "Trust",
              Sentiment == 7 ~ "Surprise",
              Sentiment == 6 ~ "Sadness",
              Sentiment == 5 ~ "Joy",
              Sentiment == 4 ~ "Fear",
              Sentiment == 3 ~ "Disgust",
              Sentiment == 2 ~ "Anticipation",
              Sentiment == 1 ~ "Anger"
            ))

scatter <- ggplot(emotib %>% mutate(log.p.value = -log(p.value)),
         aes(x = position, 
             y = log.p.value/pi^2*2, 
             color = Sentiment,
             fill = Sentiment,
             size = Scale)) +
    geom_point(show.legend = FALSE) +
    scale_color_viridis_d(option = "D",
                          alpha = 0.50) +
    scale_fill_viridis_d(option = "D",
                         direction = -1) +
    coord_flip() +
    theme_void() +
 #   theme(legend.position = "bottom",
 #         legend.direction = "horizontal",
 #         text = element_text(family="Canela Text Medium")
 #        ) +
    guides(size = FALSE,
           color = guide_legend(override.aes = list(size=3)))

scatter

  ggsave("scatter.png",
         scatter,
         width = 210, 
         height = 50, 
         units = "mm")
  
  