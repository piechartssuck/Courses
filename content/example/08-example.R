library(tidyverse)
library(tidytext)
library(glue)

files <- list.files("state-of-the-union-corpus-1989-2017")

files

files[1]


fileName <- glue("state-of-the-union-corpus-1989-2017/", files[1], sep = "") %>%
              trimws()

fileName

fileText <- glue(read_file(fileName))

fileText <- gsub("\\$", "", fileText)

fileText


tokens <- data_frame(text = fileText) %>% 
              unnest_tokens(word, text)
tokens


data(stop_words)

tidy_tokens <- tokens %>%
               anti_join(stop_words)



tidy_tokens %>%
  count(word, sort = TRUE) 



tidy_tokens %>%
  count(word, sort = TRUE) %>%
  filter(n > 5) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill=n)) +
  geom_col() +
  theme_minimal() +
  labs(y = NULL)



# Get the sentiment from the first text: 
speech_bing_descriptives <- tokens %>%
  inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
  count(sentiment) %>% # count the # of positive & negative words
  spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow
  mutate(sentiment = positive - negative) # of positive words - # of negative words

speech_bing_descriptives


library(wordcloud)
library(devtools)
library(tidyverse)      
library(stringr)        
library(tidytext)
library(dplyr)
library(reshape2)
library(igraph)
library(ggraph)
library(harrypotter)

titles <- c("Philosopher's Stone", 
            "Chamber of Secrets", 
            "Prisoner of Azkaban",
            "Goblet of Fire", 
            "Order of the Phoenix", 
            "Half-Blood Prince",
            "Deathly Hallows")

books <- list(philosophers_stone, 
              chamber_of_secrets, 
              prisoner_of_azkaban,
              goblet_of_fire, 
              order_of_the_phoenix, 
              half_blood_prince,
              deathly_hallows)

series <- tibble()

for(i in seq_along(titles)) {
  
  clean <- tibble(chapter = seq_along(books[[i]]),
                  text = books[[i]]) %>%
    unnest_tokens(word, text) %>%
    mutate(book = titles[i]) %>%
    select(book, everything())
  
  series <- rbind(series, clean)
}

# set factor to keep books in order of publication
series$book <- factor(series$book, levels = rev(titles))

series





series %>% count(word, sort = TRUE)



series$book <- factor(series$book, levels = rev(titles))

series %>% 
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))



get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")



series %>%
  right_join(get_sentiments("nrc")) %>%
  filter(!is.na(sentiment)) %>%
  count(sentiment, sort = TRUE)



series %>%
  right_join(get_sentiments("bing")) %>%
  filter(!is.na(sentiment)) %>%
  count(sentiment, sort = TRUE)



series %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 50)



series %>%
  anti_join(stop_words) %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 50)



series %>%
  group_by(book) %>% 
  mutate(word_count = 1:n(),
         index = word_count %/% 500 + 1) %>% 
  inner_join(get_sentiments("bing")) %>%
  count(book, index = index , sentiment) %>%
  ungroup() %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative,
         book = factor(book, levels = titles)) %>%
  ggplot(aes(index, sentiment, fill = book)) +
  geom_bar(alpha = 0.5, stat = "identity", show.legend = FALSE) +
  facet_wrap(~ book, ncol = 2, scales = "free_x")

series <- tibble()

for(i in seq_along(titles)) {
  
  temp <- tibble(chapter = seq_along(books[[i]]),
                  text = books[[i]]) %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    ##Here we tokenize each chapter into bigrams
    mutate(book = titles[i]) %>%
    select(book, everything())
  
  series <- rbind(series, temp)
}

# set factor to keep books in order of publication
series$book <- factor(series$book, levels = rev(titles))
series



series %>%
  count(bigram, sort = TRUE)



bigrams_separated <- series %>%
  separate(bigram, c("word1", "word2"), sep = " ")

bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# new bigram counts:
bigrams_united <- bigrams_filtered %>%
  unite(bigram, word1, word2, sep = " ")

bigram_counts <- bigrams_united %>% 
    count(bigram, sort = TRUE)



bigram_tf_idf <- bigrams_united %>%
  count(book, bigram) %>%
  bind_tf_idf(bigram, book, n) %>%
  arrange(desc(tf_idf))

bigram_tf_idf




plot_potter<- bigram_tf_idf %>%
  arrange(desc(tf_idf)) %>%
  mutate(bigram = factor(bigram, levels = rev(unique(bigram))))

plot_potter %>% 
  top_n(20) %>%
  ggplot(aes(bigram, tf_idf, fill = book)) +
  geom_col() +
  labs(x = NULL, y = "tf-idf") +
  coord_flip()



bigrams_separated %>%
  filter(word1 == "not") %>%
  count(word1, word2, sort = TRUE)



bigrams_separated <- bigrams_separated %>%
  filter(word1 == "not") %>%
  filter(!word2 %in% stop_words$word)%>%
  count(word1, word2, sort = TRUE)

bigrams_separated



BING <- get_sentiments("bing")

not_words <- bigrams_separated %>%
  filter(word1 == "not") %>%
  filter(!word2 %in% stop_words$word)%>%
  inner_join(BING, by = c(word2 = "word")) %>%
  ungroup()

not_words



bigram_graph <- bigram_counts %>%
  filter(n > 70) %>%
  graph_from_data_frame()

bigram_graph


set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

