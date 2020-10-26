## ----echo = FALSE, eval = TRUE, message=FALSE------------------------------
library(tidyverse)
library(mosaic)
library(ggplot2movies)

# ----
head(movies)

# ----
dim(movies)

# ----
names(movies)

# ----
select_movies <- movies %>%
  select(Action, Animation, Comedy, Drama, Documentary, Romance, Short) %>%
  pivot_longer(
    everything(),
    names_to = "genre"
  )

select_movies

# ?pivot_longer

# ----
juniors_multiple <- tribble(
  ~ "baker", ~"cinnamon_1", ~"cardamom_2", ~"nutmeg_3",
  "Emma", 1L,   0L, 1L,
  "Harry", 1L,   1L, 1L, 
  "Ruby", 1L,   0L, 1L, 
  "Zainab", 0L, NA, 0L
)


# ----
juniors_multiple


# ----
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl3.png")

# ----
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 

# ----
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 

# ----
juniors_multiple %>%
  pivot_longer(-baker,
                names_to = c('spice', 'order'),
                names_sep = '_',
                values_to = 'correct')

# ----
glimpse(juniors_multiple)

# ----
juniors_multiple_full <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", 
  ~ "guess_1", ~"guess_2", ~"guess_3",
    "Emma", 1L,   0L, 1L, "cinnamon", "cloves", "nutmeg",
    "Harry", 1L,   1L, 1L, "cinnamon", "cardamom", "nutmeg",
    "Ruby", 1L,   0L, 1L, "cinnamon", "cumin", "nutmeg",
    "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
  )

# ----
juniors_multiple_full

# ----
glimpse(juniors_multiple_full)

# ----
juniors_multiple_full %>% 
  # Don't do anything with the baker column
    pivot_longer(-baker, 
                 # Treat all columns the same and order them
                 names_to = c(".value", "order"), 
                 # Control how the column names are broken up
                 names_sep = "_")

# ----
movies_by_genre <- movies %>%
            select(Action, Animation, Comedy,
                   Drama, Documentary, Romance, Short) %>%
            pivot_longer(everything(),
                         names_to = "genre") %>%
            group_by(genre) %>%
            dplyr::tally(value)

movies_by_genre

# ----
ggplot(movies_by_genre,
       aes(x = genre, 
           y = n, 
           fill = -n)) +
  geom_bar(stat='identity', 
           show.legend = FALSE) +
  labs(title = "Count of Genre", x = "Genre", y = "Count") +
  theme_minimal()

# ----
pop <- movies %>% 
  ggplot(aes(x = rating, fill = -..count..)) +
  geom_histogram(color = "white", 
                 bins = 20,
                 show.legend = FALSE) +
  theme_minimal()

pop

# ----
set.seed(999) # Random number generator
movies_sample <- movies %>% 
  sample_n(70)

# ----
ggplot(movies_sample, aes(x = rating, fill = -..count..)) +
       geom_histogram(color = "white", 
                      bins = 20,
                      show.legend = FALSE) +
       theme_minimal()

# ----
(movies_sample_mean <- movies_sample %>% 
   summarize(mean = mean(rating)))

# ----
resample(movies_sample) %>%
  arrange(orig.id) %>% 
  summarize(mean = mean(rating))

# ----
do(10) * 
  (resample(movies_sample) %>% 
     summarize(mean = mean(rating)))

# ----
not_lame <- do(10000) * summarize(resample(movies_sample), 
                                  mean = mean(rating))

# ----
samp <- ggplot(data = not_lame , 
       mapping = aes(x = mean,
                     fill = -..count..)) +
  geom_histogram(bins = 30, 
                 color = "white",
                 show.legend = FALSE) +
  theme_minimal()

samp


# ----
(ci95_mean <- confint(not_lame, 
                      level = 0.95, 
                      method = "quantile"))

# ----
(ci95_mean <- confint(not_lame, 
                      level = 0.95, 
                      method = "stderr"))
