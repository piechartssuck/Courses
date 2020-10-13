# ----
library(tidyverse)


# ----
data(starwars)


# ----
starwars


# ----
head(starwars)


# ----
nrow(starwars %>%
       select(name))


# ----
length(starwars$name)


# ----
str(starwars)


# ----
glimpse(starwars)


# ----
starwars %>%
  count(sex)


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(mean(birth_year)) %>%
  rename(`mean age by species` = `mean(birth_year)`) %>%
  ungroup()


# ----
banana_data <- tibble(
  id = c(1,2,3,4,5),
  cav_cat = c("Excellent", "Above Average", "Very Poor", "Average", 
              "Excellent"),
  cav_code = c(5,4,1,3,5),
  ic_cat = c("Excellent", "Excellent", "Above Average", "Excellent", 
             "Excellent"), 
  ic_code = c(5,5,4,5,5)
)


# ----
banana_data


# ----
mean(banana_data$cav_code)


# ----
mean(banana_data$ic_code)


# ----
banana_data %>%
  summarise(mean_cav = mean(cav_code), 
            mean_ic = mean(ic_code)) %>%
  mutate(range_means = mean_ic - mean_cav)


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(median(birth_year)) %>%
  rename(`median age by species` = `median(birth_year)`) %>%
  ungroup()


# ----
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(Mode(birth_year)) %>%
  rename(`mode age by species` = `Mode(birth_year)`) %>%
  ungroup()


# ----
starwars %>%
  filter(gender == "feminine") %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(mean(birth_year)) %>%
  rename(`female mean age by species` = `mean(birth_year)`) %>%
  ungroup() %>%
  na.omit()


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(sd(birth_year)) %>%
  rename(`age standard deviation by species` = `sd(birth_year)`) %>%
  ungroup() %>%
  na.omit()


# ----
pop_sd <- function(x) sd(x) * (length(x)-1) / length(x)


# ----
starwars %>%
 group_by(species) %>%
 na.omit() %>%
 summarise(pop_sd(birth_year)) %>%
 rename(`age standard deviation by species` = `pop_sd(birth_year)`) %>%
 ungroup() %>%
 na.omit()


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(var(birth_year)) %>%
  rename(`age variance by species` = `var(birth_year)`) %>%
  ungroup() %>%
  na.omit()


# ----
pop_var <- function(x) var(x) * (length(x)-1) / length(x)


# ----
starwars %>%
 group_by(species) %>%
 na.omit() %>%
 summarise(pop_var(birth_year)) %>%
 rename(`age variance by species` = `pop_var(birth_year)`) %>%
 ungroup() %>%
 na.omit()


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(max(birth_year)) %>%
  rename(`maximum age by species` = `max(birth_year)`) %>%
  ungroup() %>%
  na.omit()


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(min(birth_year)) %>%
  rename(`minimum age by species` = `min(birth_year)`) %>%
  ungroup() %>%
  na.omit()


# ----
starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(max(birth_year), min(birth_year)) %>%
  rename(`max` = `max(birth_year)`) %>%
  rename(`min` = `min(birth_year)`) %>%
  ungroup() %>%
  na.omit() %>%
  mutate(`age range by species` = max - min) 


# ----
starwars_by_species <- starwars %>%
  group_by(species) %>%
  na.omit() %>%
  summarise(mean(birth_year)) %>%
  rename(`mean age by species` = `mean(birth_year)`) %>%
  ungroup() %>%
  arrange(`mean age by species`)


# ----
ggplot(starwars_by_species, aes(x = species, 
                                y = `mean age by species`, 
                                fill = `mean age by species`)) +
  geom_bar(stat='identity') +
  scale_fill_gradient(low = "tomato", 
                      high = "steelblue") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45))


# ----
ggplot(starwars_by_species, aes(x = reorder(species, 
                                            `mean age by species`), 
                                y = `mean age by species`, 
                                fill = `mean age by species`)) +
       geom_bar(stat='identity') +
       scale_fill_gradient(low = "tomato", 
                           high = "steelblue") +
       theme_minimal() +
  theme(axis.text.x = element_text(angle = 45))


 # ----echo = TRUE, eval = TRUE, fig.align='center', out.width = "25%"# ----
ggplot(starwars_by_species, aes(x = reorder(species, 
                                            -`mean age by species`), 
                                y = `mean age by species`, 
                                fill = `mean age by species`)) +
       geom_bar(stat='identity') +
       scale_fill_gradient(low = "tomato", 
                           high = "steelblue") +
       theme_minimal() +
  theme(axis.text.x = element_text(angle = 45))


# ----
ggplot(starwars_by_species, aes(x = reorder(species, 
                                            `mean age by species`),
                                y = `mean age by species`,
                                group = 1,
                                fill = `mean age by species`)) +
 geom_line(size = 1.5)+
  geom_point(size = 4) +
  scale_fill_gradient(low = "tomato", 
                      high = "steelblue") +
  theme_minimal()

# ----
 starwars_by_species_pc <- starwars_by_species %>%
   arrange(desc(`mean age by species`)) %>%
   mutate(prop = `mean age by species` /
            sum(starwars_by_species$`mean age by species`) *100) %>%
   mutate(ypos = cumsum(prop)- 0.5*prop )


# ----
  ggplot(starwars_by_species_pc, aes(x = "",
                                    y = prop,
                                    fill = `mean age by species`)) +
   geom_bar(stat="identity",
            width=1,
            color="white")  +
   coord_polar("y", start = 0) +
   geom_label(aes(y = ypos,
                  label = `species`),
              color = "white",
              size=6) +
   scale_fill_gradient(low = "tomato",
                       high = "steelblue") +
   theme_void()


# ----
starwars_by_species_pc <- starwars_by_species %>%
  arrange(desc(`mean age by species`)) %>%
  mutate(prop = `mean age by species` / sum(starwars_by_species$`mean age by species`) * 100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

 ggplot(starwars_by_species_pc, aes(x = "", 
                                   y = prop, 
                                   fill = `mean age by species`)) +
  geom_bar(stat="identity", 
           width=1, 
           color="white")  +
  coord_polar("y", start = 0) +
  geom_label(aes(y = ypos, 
                 label = `species`), 
             color = "white", 
             size=6) +
  scale_fill_gradient(low = "tomato", 
                      high = "steelblue") +
  theme_void()

