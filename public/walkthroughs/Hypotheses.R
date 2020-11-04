# ----
# install.packages('patchwork')


# ----
library(tidyverse)
library(patchwork)


# ----
# t.test(x, y = NULL, alternative = c("two.sided", "less", "greater"), mu = 0,
#        paired = FALSE, var.equal = FALSE, conf.level = 0.95)

# ----
#  t.test(x, alternative = "greater", mu = 47)


# ----
head(midwest)


# ----
head(midwest$percollege, 10)

summary(midwest$percollege)


# ----
p1 <- ggplot(midwest, aes(x = percollege)) + 
        geom_histogram(aes(fill = ..count..), color = "#ccccaa") +
        scale_fill_gradient("Frequency", low = "#5cb85c", high = "#428bca") +
        theme_minimal() +
        theme(legend.position = "bottom",
              legend.direction = "horizontal")



p2 <- ggplot(midwest, aes(x = percollege)) + 
        geom_histogram(aes(fill = ..count..), color = "#ccccaa") +
        scale_fill_gradient("Frequency", low = "#5cb85c", high = "#428bca") +
        scale_x_log10() +
        theme_minimal() +
        theme(legend.position = "bottom",
              legend.direction = "horizontal")


p1 + p2


# ----
t.test(midwest$percollege, mu = 37, alternative = "less")


# ----
t.test(log(midwest$percollege), mu = log(37), alternative = "less")


# ----
ohio_mi <- midwest %>%
        filter(state == "OH" | state == "MI") %>%
        select(state, percollege)


# ----
# Ohio summary stats
summary(ohio_mi %>% 
          filter(state == "OH") %>% 
          .$percollege)


# ----
# Ohio summary stats
summary(ohio_mi %>% 
          filter(state == "MI") %>% 
          .$percollege)


# ----
ggplot(ohio_mi, aes(x = state, y = percollege, fill = state)) +
        geom_boxplot(alpha = 0.5) +
        scale_fill_manual(values = c("#00274C", "#BB0000")) +
        theme_minimal() 


# ----
p3 <- ggplot(ohio_mi, aes(x = percollege)) +
        geom_histogram(aes(fill = ..count..), color = "#ccccaa") +
        scale_fill_gradient("Frequency", low = "#5cb85c", high = "#428bca") +
        facet_wrap(~ state) +
        theme_minimal() +
        theme(legend.position = "bottom",
              legend.direction = "horizontal")
    

p4 <- ggplot(ohio_mi, aes(x = percollege)) +
        geom_histogram(aes(fill = ..count..), color = "#ccccaa") +
        scale_fill_gradient("Frequency", low = "#5cb85c", high = "#428bca") +
        facet_wrap(~ state) + 
        scale_x_log10() +
        theme_minimal() +
        theme(legend.position = "bottom",
              legend.direction = "horizontal")

p3 + p4


# ----
t.test(percollege ~ state, data = ohio_mi)


# ----
t.test(log(percollege) ~ state, data = ohio_mi)


# ----
sleep


# ----
ggplot(sleep, aes(group, extra, fill = group)) +
        geom_boxplot(alpha = 0.5) +
        scale_fill_manual(values = c("#00274C", "#BB0000")) +
        theme_minimal() 


# ----
t.test(extra ~ group, data = sleep, paired = TRUE)


# ----
sleep <- sleep %>%
  mutate(group = as.numeric(group))

t.test(sleep$extra, sleep$group, paired = TRUE)
