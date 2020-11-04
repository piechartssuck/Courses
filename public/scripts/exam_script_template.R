# Dr. Fancy Pants
# Exam 1

# Load the needed libraries
library(tidyverse) 

# ---

# 1
combination <- c(1,2,3,4,5) 

# This is taking the sample mean of the combination
mean(combination)

# This is taking the sample standard deviation of the combination
sd(combination)

# Solution: The mean of the combination lock is 3 with a standard deviation
# of 1.58.

# ---

#2       
# Use the mtcars data set
mydata <- mtcars %>%
  # remove all rows where the number of carburetors are 
  # less than 2
  filter(carb > 1) %>% 
  group_by(cyl) %>% # group by the number of cylinders
  summarise(Avg_mpg = mean(mpg)) %>% # find the average (mean) of the 
  # remaining cars by miles per gallon 
  arrange(desc(Avg_mpg)) # arrange the results in descending order dependent on the mean 
# mpg

mydata # Observe the outcome

# Solution: A four cycle engine has the highest average miles per gallon.

# ---

# 3. ....