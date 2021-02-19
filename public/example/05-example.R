library(tidyverse)



unique(mpg$manufacturer)



mpg %>%
  select(manufacturer) %>%
  distinct()



glimpse(mpg)



ggplot(mpg, aes(x = manufacturer, fill = manufacturer)) +
  geom_bar() +
  geom_text(stat = 'count', 
             aes(label = after_stat(count)), 
             vjust = -0.5) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1.3,
                                   hjust = 1)) 
  



mpg %>%
  select(manufacturer) %>%
  group_by(manufacturer) %>%
  tally() %>%
  ungroup()


## ---- eval=FALSE------------------------------------------------
## Get the `mpg` tibble %>%
##   Only show me the column `manufacturer` %>%
##    Perform any wrangling by car manufacturer %>%
##    Count by car manufacturer %>%
##    Dont do any more wrangling by car manufacturer



mpg %>%
  select(manufacturer) %>%
  tally() 



names(mpg)



ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) 



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "#002855")



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy,
##                            color = "blue"))



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy),
##              color = c("#34738f", "#122f3d", "#be3e2b", "#ed8a45", "#f6de6c"))



mpg$class



unique(mpg$class)



length(unique(mpg$class))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = class)) +
  scale_color_manual(values = c("#490A3D", "#BD1550", "#E97F02", "#F8CA00", "#8A9B0F", "#95C7D8", "#FFBFF5"))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 2) +
  scale_color_manual(values = c("#490A3D", "#BD1550", "#E97F02", "#F8CA00", "#8A9B0F", "#95C7D8", "#FFBFF5"))



## ggplot(data = mpg)
## + geom_point(mapping = aes(x = displ, y = hwy))



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 2) +
  scale_color_manual(values = c("#490A3D", "#BD1550", "#E97F02", "#F8CA00", "#8A9B0F", "#95C7D8", "#FFBFF5")) +
 facet_wrap(~ class, nrow = 2)



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 2) +
  scale_color_manual(values = c("#490A3D", "#BD1550", "#E97F02", "#F8CA00", "#8A9B0F", "#95C7D8", "#FFBFF5")) +
  facet_grid(drv ~ cyl)



ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 2) +
  scale_color_manual(values = c("#490A3D", "#BD1550", "#E97F02", "#F8CA00", "#8A9B0F", "#95C7D8", "#FFBFF5")) +
  facet_grid(. ~ cyl)



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = drv, y = cyl))



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy)) +
##   facet_grid(drv ~ .)



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy)) +
##   facet_grid(. ~ cyl)



## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = displ, y = hwy)) +
##   facet_wrap(~ class, nrow = 2)

