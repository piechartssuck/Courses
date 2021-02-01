# Graphic for the bottom of the main page 

# Set the working directory as source  (if needed) ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove objects (if needed) ----
rm(list = ls())
 
library(tidyverse)
library(viridis)
library(showtext)
font_add("Canela Medium Italic", "Canela-MediumItalic.otf")
font_add("Canela Bold", "Canela-Bold.otf")
font_add("Canela Text Black", "Canela-Black.otf")
showtext_auto()

  n <- 9000 # number of participants
  position <- 1:n
  evaluand <- factor(rep(1:8, each=n/8))
  p.value <- runif(n)
  emotib <- tibble(`Sentiment Evaluation` = position, 
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
  

scatter <- ggplot(emotib %>% mutate(Strength = -log(p.value)/pi^2*2),
         aes(x = reorder(Sentiment, desc(Sentiment)),
             y = Strength, 
             color = Strength,
             fill = Sentiment,
             size = 0.5/Strength*10)) +
    geom_point(shape = 21, 
               show.legend = FALSE, 
               alpha = 1, 
               stroke = 0.2,
               color = "white") +
    scale_fill_manual(values =c("#02416a", "#e64a21", "#770301",
                                "#722d61", "#008080", "5e576e",
                                "#7e90ac", "#006699")) +
  scale_y_reverse(expand = expansion(add = c(0.2, 0.4))) +
    theme_void() +
  theme(plot.margin = unit(c(-0.2,1,-0.35,1), "cm"))

scatter

  ggsave("scatter.png",
         scatter,
         width = 80, 
         height = 40, 
         units = "mm")
  
  
