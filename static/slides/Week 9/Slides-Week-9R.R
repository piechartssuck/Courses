## ----echo = FALSE, eval = TRUE, message=FALSE------------------------------
library(tidyverse)
library(mosaic)
library(ggplot2movies)


## ----echo = FALSE, eval = TRUE, message=FALSE------------------------------
suppressMessages(library(tidyverse))
suppressMessages(library(mosaic))
suppressMessages(library(ggplot2movies))






## ----echo = TRUE, eval = TRUE----------------------------------------------
head(movies)


## ----echo = TRUE, eval = TRUE----------------------------------------------
dim(movies)


## ----echo = TRUE, eval = TRUE----------------------------------------------
names(movies)


## ----echo = TRUE, eval = FALSE---------------------------------------------
## movies %>%
##   select(Action, Animation, Comedy,
##          Drama, Documentary, Romance, Short) %>%
##   pivot_longer(
##     everything(),
##     names_to = "genre"
##   )


## ----echo = FALSE, eval = TRUE---------------------------------------------
movies %>%
  select(Action, Animation, Comedy, Drama, Documentary, Romance, Short) %>%
  pivot_longer(
    everything(),
    names_to = "genre"
  )


## ---- echo = FALSE, out.height="30%", fig.height=1, out.width="30%", fig.align='center'----
knitr::include_graphics("img/tidyr_spread_gather.png")


## ---- echo = FALSE, out.height="80%", fig.height=1, out.width="80%", fig.align='center'----
knitr::include_graphics("img/pl2.png")


## ----echo = TRUE, eval = FALSE---------------------------------------------
## ?pivot_longer


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple <- tribble(
  ~ "baker", ~"cinnamon_1", ~"cardamom_2", ~"nutmeg_3",
  "Emma", 1L,   0L, 1L,
  "Harry", 1L,   1L, 1L, 
  "Ruby", 1L,   0L, 1L, 
  "Zainab", 0L, NA, 0L
)


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple


## ----echo = FALSE, eval = TRUE---------------------------------------------
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl3.png")


## ----echo = FALSE, eval = TRUE---------------------------------------------
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl4.png")


## ----echo = FALSE, eval = TRUE---------------------------------------------
juniors_multiple %>% 
  knitr::kable() %>%
  kableExtra::row_spec(0, background = "#212121") %>%
  kableExtra::row_spec(2, background = "#212121") %>%
  kableExtra::row_spec(4, background = "#212121") 


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl5.png")


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl6.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl7.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl8.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl9.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl10.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl11.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl12.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl13.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl14.png")


## ---- echo = FALSE, out.height="35%", fig.height=1, out.width="35%", fig.align='center'----
knitr::include_graphics("img/pl15.png")


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl16.png")


## ---- echo = FALSE, out.height="75%", fig.height=1, out.width="75%", fig.align='center'----
knitr::include_graphics("img/pl17.png")


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple %>%
  pivot_longer(-baker,
                names_to = c('spice', 'order'),
                names_sep = '_',
                values_to = 'correct')


## ----echo = TRUE, eval = TRUE----------------------------------------------
glimpse(juniors_multiple)


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple_full <- tribble(
  ~ "baker", ~"score_1", ~"score_2", ~"score_3", 
  ~ "guess_1", ~"guess_2", ~"guess_3",
    "Emma", 1L,   0L, 1L, "cinnamon", "cloves", "nutmeg",
    "Harry", 1L,   1L, 1L, "cinnamon", "cardamom", "nutmeg",
    "Ruby", 1L,   0L, 1L, "cinnamon", "cumin", "nutmeg",
    "Zainab", 0L, NA, 0L, "cardamom", NA_character_, "cinnamon"
  )


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple_full


## ----echo = TRUE, eval = TRUE----------------------------------------------
glimpse(juniors_multiple_full)


## ----echo = TRUE, eval = FALSE---------------------------------------------
## juniors_multiple_full %>%
##   pivot_longer(score_1:guess_3,
##                names_to = c('score', 'guess'),
##                names_sep = "_",
##                values_to = 'correct')


## ----echo = TRUE, eval = TRUE----------------------------------------------
juniors_multiple_full %>% 
  # Don't do anything with the baker column
    pivot_longer(-baker, 
                 # Treat all columns the same and order them
                 names_to = c(".value", "order"), 
                 # Control how the column names are broken up
                 names_sep = "_")


## ----echo = TRUE, eval = TRUE----------------------------------------------
movies_by_genre <- movies %>%
            select(Action, Animation, Comedy,
                   Drama, Documentary, Romance, Short) %>%
            pivot_longer(everything(),
                         names_to = "genre") %>%
            group_by(genre) %>%
            dplyr::tally(value)

movies_by_genre


## ----echo = TRUE, eval = TRUE, fig.asp = 0.8, fig.width = 6----------------
ggplot(movies_by_genre,
       aes(x = genre, 
           y = n, 
           fill = -n)) +
  geom_bar(stat='identity', 
           show.legend = FALSE) +
  labs(title = "Count of Genre", x = "Genre", y = "Count") +
  theme_minimal()


## ----echo = TRUE, eval = TRUE, fig.asp = 0.8, fig.width = 5----------------
pop <- movies %>% 
  ggplot(aes(x = rating,
             fill = n)) +
  geom_histogram(color = "white", 
                 bins = 20,
                 show.legend = FALSE) +
  theme_minimal()

pop


## ----echo = TRUE, eval = TRUE----------------------------------------------
set.seed(999) # Random number generator
movies_sample <- movies %>% 
  sample_n(70)


## ----echo = TRUE, eval = TRUE, fig.asp = 0.8, fig.width = 3----------------
ggplot(data = movies_sample, aes(x = rating,
                                 fill = n)) +
  geom_histogram(color = "white", bins = 20, show.legend = FALSE) +
  theme_minimal()


## ----echo = TRUE, eval = TRUE----------------------------------------------
(movies_sample_mean <- movies_sample %>% 
   summarize(mean = mean(rating)))


## ----echo = TRUE, eval = TRUE----------------------------------------------
resample(movies_sample) %>%
  arrange(orig.id) %>% 
  summarize(mean = mean(rating))


## ----echo = TRUE, eval = TRUE----------------------------------------------
do(10) * 
  (resample(movies_sample) %>% 
     summarize(mean = mean(rating)))


## ----echo = TRUE, eval = TRUE----------------------------------------------
not_lame <- do(10000) * summarize(resample(movies_sample), 
                                  mean = mean(rating))


## ----echo = TRUE, eval = TRUE, fig.asp = 0.8, fig.width = 5----------------
samp <- ggplot(data = not_lame , 
       mapping = aes(x = mean,
                     fill = n)) +
  geom_histogram(bins = 30, 
                 color = "white",
                 show.legend = FALSE) +
  theme_minimal()

samp


## ----echo = FALSE, eval = TRUE, fig.asp = 0.4, fig.width = 8.8-------------

samp + pop



## ----echo = TRUE, eval = TRUE----------------------------------------------
(ci95_mean <- confint(not_lame, 
                      level = 0.95, 
                      method = "quantile"))


## ----echo = TRUE, eval = TRUE----------------------------------------------
(ci95_mean <- confint(not_lame, 
                      level = 0.95, 
                      method = "stderr"))


## ----tweet, echo = FALSE, eval = TRUE, out.height="40%", out.width="40%"----
tweet_embed("https://twitter.com/allison_horst/status/1190001300622036992",
            maxwidth = 100,
            theme = "dark")

