# Detach all session packages -----
# lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load libraries ---
library(qualtRics)
library(tidyverse)
library(textclean)

## Functions ##
# Gather all label attributes ----
labelAttr <- function(dta) { 
  labels <- sapply(dta, function(x) attr(x, "label"))
  tibble(item = names(labels),
         question = labels)
}

## Put your Qualtrics API here ----
qualtrics_api_credentials(api_key = "YOUR API KEY HERE", 
                          base_url = "wvu.ca1.qualtrics.com", 
                          install = TRUE)

## Use this command your first time OR if you update the key ----
readRenviron("~/.Renviron")

## Get all of your surveys ----
surveys <- all_surveys()
t
## subset a particular survey ----
id = "SV_eyqbBif5DiL0ROl"

## pull survey ----
raw_survey <- fetch_survey(id)

raw_survey_qids <- survey_questions(id) %>%
  mutate(question = replace_html(question)) %>%
  mutate(question = str_trim(question)) %>%
  mutate(question = str_replace_all(question, "\n" , "")) %>%
  mutate(question = str_replace_all(question, "&amp;" , "&")) %>%
  mutate(question = str_replace_all(question, "&rsquo;s" , "'s")) %>%
  mutate(question = str_replace_all(question, "&#39;s" , "'s")) %>%
  mutate(question = str_replace_all(question, "‚Äì" , "-")) %>%
  mutate(question = str_replace_all(question, " - e" , ")")) %>%
  mutate(question = str_replace_all(question, ",Äú" , "&quot;"))  %>%
  mutate(question = noquote(question)) %>%
  mutate(question = gsub(".Skin .SS .horizontalbar .handle, .Skin .SS .verticalbar .SSTrack .handle, .Skin .horizontalbar .BarContainer:hover .bar, .Skin .horizontalbar .Slider .handle, .Skin .horizontalbar .activated .bar", "", question)) %>%
  mutate(question = gsub(".Skin .SS .horizontalbar .handle:hover, .Skin .horizontalbar .Slider .handle:hover", "", question)) %>%
  mutate(question = gsub(".hoverTable .hoverTable td .hoverTable tr .hoverTable tr:hover .hoverTable tr#tr01:hover .hoverTable td#td01:hover table#t01", "", question)) %>%
  mutate(question = replacesmartquotes(question)) %>%
  mutate(question = str_squish(question))
         
# Question 1 -----
Question3 <- raw_survey  %>%
  select(starts_with("Q3")) 

