library(tidyverse)
library(infer)
library(patchwork)
library(viridis)

gss_nasa<-"https://raw.githubusercontent.com/piechartssuck/RWDataSets/master/gss_nasa.csv" %>%
  read_csv()

names(gss_nasa)

gss_select <- gss_nasa %>%
  select(party, space)

gss_select %>%
  head()

gss_select %>%
  select(party) %>%
  unique()

gss_select %>%
  select(space) %>%
  unique()

https://raw.githubusercontent.com/piechartssuck/RWDataSets/master/GSS%20Extract%20Data%20Set.csv +
  theme_minimal_vgrid()

str(gss_select)

library(gapminder)

levels(gapminder$continent)

gss_factors <- gss_select %>%
  mutate(party = as.factor(party)) %>%
  mutate(space = as.factor(space))

factor(levels(gss_factors$party))

gss_factors %>%
  pull(space) %>%
levels()

levels(gss_factors$party)
levels(gss_factors$space)

gss_newlevels <- gss_factors %>%
  mutate(party = factor(party, levels = c("Dem", "Rep", "Ind"))) %>%
  mutate(space = factor(space, levels = c("TOO MUCH", "ABOUT RIGHT", "TOO LITTLE")))

gss_newlevels %>%
  pull(space) %>%
  levels()

gss_newlevels %>%
  pull(party) %>%
  levels()

gss_newlevels %>% 
  ggplot(aes(x=party, fill = space)) + 
  geom_bar() +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal_vgrid()

gss_newlevels %>% 
  ggplot(aes(x=party, fill = space)) + 
  geom_bar(position = "fill") +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal_vgrid() + 
  ylab("within group percentage")

gss_newlevels %>%
   count()

gss_newlevels %>%
  summary()


legend_order <- c("k = 5", "k = 15",  "k = 30", "k = 60", "k = 90")

data.frame(chisq = 0:7000 / 100) %>% 
  mutate("k = 5" = dchisq(x = chisq, df = 5),
         "k = 15"  = dchisq(x = chisq, df = 15),
         "k = 30"  = dchisq(x = chisq, df = 30),
         "k = 60"  = dchisq(x = chisq, df = 60),
         "k = 90"  = dchisq(x = chisq, df = 90)
         ) %>%
  gather(key = "df", value = "density", -chisq) %>%
  mutate(df = factor(df, levels = legend_order)) %>%
  ggplot() +
  geom_line(aes(x = chisq, y = density, color = df), size = 1.2) +
  labs(title = "Chi-Square at Various Degrees of Freedom",
       x = "Chi-square",
       y = "Density") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#85929E"))


chisq.test(gss_newlevels$party, gss_newlevels$space) 
observed_stat <- chisq.test(gss_newlevels$party, gss_newlevels$space)$stat

gss_newlevels %>%
  mutate(random_1 = sample(space),
         random_2 = sample(space))

gss_newlevels %>% 
  specify(space ~ party)  %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "Chisq") %>% 
  visualize() +
  geom_vline(aes(xintercept = observed_stat), color = "red")


gss_newlevels %>% 
  specify(space ~ party)  %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "Chisq") %>% 
  summarise(p_val = mean(stat > observed_stat))


gss_newlevels %>% 
  specify(space ~ party)  %>% 
  hypothesize(null = "independence") %>% 
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "Chisq")
