library(tidyverse) # ggplot2, dplyr, tidyr, readr, 
# purrr, tibble, stringr, forcats
library(viridis)

heads <- rbinom(100000, 50, 0.5) %>%
  as_tibble() %>%
  rename(heads = value) %>% 
  mutate(events = ifelse(heads > 25, "> 25", "< 25"))

binom <- heads %>%  
  ggplot(aes(x=heads, fill = events)) + 
  geom_histogram(binwidth = 0.5,
                 show.legend = FALSE) + 
  scale_fill_manual(values = c("#836575", "#658373")) +
  theme_void() 

binom

ggsave("binom.pdf",
       binom
       )
