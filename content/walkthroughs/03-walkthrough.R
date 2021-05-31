# This is a walkthrough script. Instead of copying and pasting from the webpage
# which doesn't always work out well, you can just follow along using the commands
# below.

install.packages("remotes")

remotes::install_github("peterhurford/surveytools2")

library("tidyverse")
library("psych")
library("corrr")
library("surveytools2")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

toobig_five_data <- read_delim("data-final.csv", delim="\t")

toobig_five_data


big_five_data <- read_csv("Big5data.csv")

big_five_codebook <- read_csv("Big5codebook.csv")

big_five_measures <- read_csv("Big5measures.csv")


big_five_data %>%
  head()

big_five_codebook

big_five_measures


big_five_data_EXT <- big_five_data %>%
                     select(starts_with("EXT"))


big_five_codebook_EXT <- big_five_codebook %>%
                         filter(str_detect(ID, "EXT"))

big_five_data_EXT

big_five_codebook_EXT

big_five_codebook_EXT


big_five_data_EXT_rev <- big_five_data_EXT %>%
                         mutate(EXT2 = reverse_code(EXT2),
                                EXT4 = reverse_code(EXT4),
                                EXT6 = reverse_code(EXT6),
                                EXT8 = reverse_code(EXT8),
                                EXT10 = reverse_code(EXT10))

big_five_data_EXT_rev


psych::alpha(big_five_data_EXT_rev)

psych::alpha(big_five_data_EXT_rev)$total$raw_alpha


big_five_data_EXT_rev %>%
  correlate()


inter_measure  <- big_five_data_EXT_rev %>% 
                  correlate() %>% 
                  select(-term) %>% 
                  colMeans(na.rm = TRUE)

inter_measure 


big_five_correlations_cat <- data.frame(inter_measure) %>%
                             rownames_to_column() %>%
                             as_tibble() %>%
                             arrange(desc(inter_measure)) 

big_five_correlations_num <- big_five_correlations_cat %>%
                             left_join(big_five_codebook, c("rowname" = "ID"))

big_five_correlations_cat

big_five_correlations_num 


mean(inter_measure)


agg_scores <- big_five_data_EXT_rev %>% 
              mutate(score = rowMeans(select(.,1:10))) %>% 
              correlate() %>% 
              focus(score) %>%
              arrange(desc(score))

agg_scores

