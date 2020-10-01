# Load libraries ----
library(tidyverse)
library(scales)

# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Unipolar likert scale color palette ----

# ~ You can add or remove choices and the program will output the appropriate color counts ----
unichoices <- c("Not Good", 
                "Somewhat Good", 
                "Good", 
                "Mostly Good", 
                "Very Good")

# ~ The base color in hex code (find ideas af https://www.color-hex.com/)
unicolor <- "#189ad3"
  
# ~ Output the html ----
unihtmlcolors()


# Bipolar likert scale color palette ----

# ~ Choices ----

# ~ You can add or remove choices and the program will output the appropriate color counts ----
bichoices <- c("Strongly Disagree", 
                "Disagree", 
                "Neither Agree nor Disagree", 
                "Agree", 
                "Strongly Agree")

# ~ Two colors in hex code (find ideas af https://www.color-hex.com/)
bicolor_low <- "#d9534f"
bicolor_high <- "#428bca"

# ~ Output the html ----
bihtmlcolors()

