#### Example R Script Writeup ####

# Abhik Roy
# Task 1

# Load the needed libraries
library(tidyverse)
library(fivethirtyeight)

# Bring in the fight-songs data set ----
fight_songs <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/fight-songs/fight-songs.csv")

# Take a look at the first six rows ----
head(fight_songs)

# View the entire data set ----
View(fight_songs)

# Calculate the average beats per minute ----
mean_bpm <- fight_songs %>%
            select(bpm) %>%
            summarise(Mean = mean(bpm, na.rm = TRUE))

# Check the results ----
mean_bpm 

# We get 129 average beats per minute 


