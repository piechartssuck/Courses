## ---- 
library(tidyverse)
library(viridis)
library(RColorBrewer)
library(ggthemes)
library(ggtext)


## ----
## income_data <- read_csv("income.csv")


## ----
names(income_data)


## ----
glimpse(income_data)


## ----
ggplot(income_data, aes(x = Location, 
                        y = Lower_2000, 
                        fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       xlab("City and State") +
       ylab("Average Income in 2000 Lower Class")


## ----
not_top10_income_data <- income_data %>%
                         select(Location, Lower_2000) %>%
                         slice_max(Lower_2000, n = 10); not_top10_income_data


## ----
top10_income_data <- income_data %>%
                     select(Location, Lower_2000) %>%
                     head(10); top10_income_data


## ----
ggplot(top10_income_data, aes(x = Location, 
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = Location, 
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       scale_fill_viridis_c() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       scale_fill_viridis_c() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       scale_fill_viridis_c() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
## ?theme


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       scale_fill_viridis_c() +
       theme(axis.text.x = element_text(angle = 33,
                                        face = "bold",
                                        vjust = 0.5),
             axis.title = element_text(size = 14,
                                       face = "bold"),
             legend.position = "right",
             legend.direction = "vertical",
             panel.grid.minor.x = element_blank(),
             panel.grid.minor.y = element_line(),
             panel.grid.major.x = element_blank(),
             panel.grid.major.y = element_line()) +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_grey() + # or theme_gray()
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_bw() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_linedraw() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_light() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_dark() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_minimal() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_classic() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_void() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_few() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_fivethirtyeight() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_gdocs() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_hc() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_igray() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_solarized() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_solid() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_tufte() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_tufte() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_wsj() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(stat = "identity") +
       theme_excel() +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class")


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(position = 'dodge',
                stat = "identity") +
       scale_fill_viridis_c() +
       theme_fivethirtyeight() +
       theme(axis.text.x = element_text(angle = 45,
                                        vjust = 0.5),
             legend.position = "right",
             legend.direction = "vertical") +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class") +       
       guides(fill=guide_legend(title="Income"))


## ----
ggplot(top10_income_data, aes(x = reorder(Location, -Lower_2000),
                              y = Lower_2000, 
                              fill = Lower_2000)) +
       geom_bar(position = 'dodge',
                width = 0.9,
                stat = "identity",
                color = "#FFFFFF") +
       geom_richtext(aes(label = Location),
                     color = "#FFFFFF",
                     position = position_dodge(width = 0.9), 
                     hjust = 0,
                     vjust = -0.1,
                     angle = 45,
                     fontface = "bold",
                     show.legend = FALSE) +
       scale_fill_gradient(low = "#52bf90",
                           high = "#317256") +
       theme_minimal() +
       theme(axis.text.x = element_blank(),
             axis.title = element_text(size = 14,
                                       face = "bold"),
             legend.position = "right",
             legend.direction = "vertical",
             panel.grid.minor.x = element_blank(),
             panel.grid.minor.y = element_line(),
             panel.grid.major.x = element_blank(),
             panel.grid.major.y = element_line()) +
       xlab("Top 10 Cities and States") +
       ylab("Average Income in 2000 Lower Class") +       
       guides(fill = guide_legend(title = "Income",
                                  reverse = TRUE)) + 
       expand_limits(x=c(0,14), 
                     y=c(0, 60))

