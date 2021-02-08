## -----------------------------------------------------------------------------------------
nothing_vector <- c()
    
nothing_vector


## -----------------------------------------------------------------------------------------
number_vector <- c(1,2,3,4,5)
    
number_vector


## -----------------------------------------------------------------------------------------
character_vector <- 
  c(
    "Oban", 
    "Macallan", 
    "Pittyvaich", 
    "Balblair", 
    "Glenmorangie"
    )
    
character_vector


## -----------------------------------------------------------------------------------------
some_matrix <- matrix(c(1,1,2,3,5,8), nrow = 2, ncol = 3)
    
some_matrix 


## -----------------------------------------------------------------------------------------
some_array <- array(1, dim = c(2, 3, 3))
        
some_array


## -----------------------------------------------------------------------------------------
some_df <- data.frame(col1 = 1:3, 
                 col2 = c("take", "a", "nap"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(1.5, 3.2, pi))
        
some_df


## -----------------------------------------------------------------------------------------
some_list <-list(1,2,3,4,5)
            
some_list


## -----------------------------------------------------------------------------------------
height <- c(145,167,176,123,150) 
weight <- c(51,63,64,40,55)


## ----dev='png'----------------------------------------------------------------------------
height <- c(145, 167, 176, 123, 150)
weight <- c(51, 63, 64, 40, 55)

plot(height,weight)


## -----------------------------------------------------------------------------------------
class(weight) # Yup there are numbers so numeric makes sense.


## -----------------------------------------------------------------------------------------
typeof(weight) # You see the term 'double' here but you may also see 'single' or 'integer'. All this refers to is the precision of the number and you can assume they are all integers.


## -----------------------------------------------------------------------------------------
length(weight) # There are 5 objects in weight so length(weight) = 5 makes sense.


## -----------------------------------------------------------------------------------------
attributes(weight) # Null since there isn't any other information except for what you see.


## ----echo=TRUE, eval=FALSE----------------------------------------------------------------
## population <- read.csv("USpop2010to2017.csv",
##                        header = TRUE,
##                        stringsAsFactors = TRUE)




## -----------------------------------------------------------------------------------------
population


## -----------------------------------------------------------------------------------------
head(population)


## -----------------------------------------------------------------------------------------
head(population, 4)


## ---- eval=FALSE--------------------------------------------------------------------------
## View(population)


## -----------------------------------------------------------------------------------------
str(population)


## -----------------------------------------------------------------------------------------
glimpse(population)


## -----------------------------------------------------------------------------------------
population$Census_ID


## -----------------------------------------------------------------------------------------
population$Collection_year


## -----------------------------------------------------------------------------------------
population$Total_Pop


## -----------------------------------------------------------------------------------------
population$Male_Pop


## -----------------------------------------------------------------------------------------
population$Female_Pop


## -----------------------------------------------------------------------------------------
census <- population$Census_ID

census


## -----------------------------------------------------------------------------------------
census <- population$Census_ID; census


## -----------------------------------------------------------------------------------------
year <- population$Collection_year; year


## -----------------------------------------------------------------------------------------
total <- population$Total_Pop; total


## -----------------------------------------------------------------------------------------
male <- population$Male_Pop; male


## -----------------------------------------------------------------------------------------
female <- population$Female_Pop; female


## ----eval=FALSE---------------------------------------------------------------------------
## plot(year, total)
## # Notice that the x-axis variable goes first!


## -----------------------------------------------------------------------------------------
# We don't divide anything in census because it just contains the original variables
census <- population$Census_ID 

# We don't want to divide anything here because this column has data on years
year <- population$Collection_year 

# These are the actual data so that's where we'll reduce. 
tinytotal <- population$Total_Pop/100000000 
tinymale <- population$Male_Pop/100000000
tinyfemale <- population$Female_Pop/100000000


## -----------------------------------------------------------------------------------------
plot(year, tinytotal) 


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)") 


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5) 


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People(in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035", 
     col="#7bc043")


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People(in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19)


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 1.5)


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 2)


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 2,
     bty = "n")


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 2,
     bty = "n",
     main = "United States Population Estimates (2010-2017)", 
     cex.main = 1.5,
     col.main = "#0392cf")


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 2,
     bty = "n",
     main = "United States Population Estimates (2010-2017)", 
     cex.main = 1.5,
     col.main = "#0392cf",
     type = "o")


## -----------------------------------------------------------------------------------------
plot(year, tinytotal, 
     xlab = "Years", 
     ylab = "Number of People (in hundreds of millions)", 
     cex.lab = 1.5, 
     col.lab="#ee4035",
     col="#7bc043", 
     pch = 19, 
     cex = 2,
     bty = "n",
     main = "United States Population Estimates (2010-2017)", 
     cex.main = 1.5,
     col.main = "#0392cf",
     type = "o",
     lwd = 3.5)


## ----echo=TRUE, eval=FALSE----------------------------------------------------------------
## facebook <- read.csv("ActiveFacebookUsers.csv",
##                        header = TRUE,
##                        stringsAsFactors = TRUE)




## -----------------------------------------------------------------------------------------
head(facebook)


## -----------------------------------------------------------------------------------------
str(facebook) 
# Alternatively, you can use glimpse()


## -----------------------------------------------------------------------------------------
facebook$Quarter


## -----------------------------------------------------------------------------------------
facebook$Number.of.users.in.millions


## -----------------------------------------------------------------------------------------
users <- facebook$Number.of.users.in.millions
quarter <- facebook$Quarter


## -----------------------------------------------------------------------------------------
hist(users) 
# Hey its a normal distribution!


## -----------------------------------------------------------------------------------------
hist(users,
     breaks = 40) 


## -----------------------------------------------------------------------------------------
min(users) 


## -----------------------------------------------------------------------------------------
max(users) 


## -----------------------------------------------------------------------------------------
(max(users) - min(users))/300


## -----------------------------------------------------------------------------------------
ceiling((max(users) - min(users))/300)


## -----------------------------------------------------------------------------------------
hist(users, 
     breaks = c(100,400,700,1000,1300,1600,1900,2100,2400))


## -----------------------------------------------------------------------------------------
hist(users, 
     breaks = seq(min(users), 
                  max(users),  
                  length.out=8))


## -----------------------------------------------------------------------------------------
hist(users, breaks = seq(min(users), 
                         max(users),   
                         length.out=8), 
     xlab = "Active Users (in millions)", 
     main = "Facebook utility worldwide as of 2nd quarter 2018",
     col = c("#3b5998","#6d84b4", "#afbdd4", "#d8dfea", "#ffffff"), 
     border = "#d8dfea", 
     cex.lab = 1.1) 


## ----echo=TRUE, eval=FALSE----------------------------------------------------------------
## twitter <- read.csv("ActiveTwitterUsers.csv",
##                        header = TRUE,
##                        stringsAsFactors = TRUE)




## -----------------------------------------------------------------------------------------
head(twitter)


## -----------------------------------------------------------------------------------------
str(twitter)


## -----------------------------------------------------------------------------------------
twitter$Quarter


## -----------------------------------------------------------------------------------------
twitter$Number.of.monthly.active.users.in.millions


## -----------------------------------------------------------------------------------------
tweeters <- twitter$Number.of.monthly.active.users.in.millions
season <- twitter$Quarter


## -----------------------------------------------------------------------------------------
plot(season, tweeters)


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "l")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "o")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "p")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "b")


## -----------------------------------------------------------------------------------------
plot(season, tweeters, 
     type = "l", 
     lty = "dashed")


## -----------------------------------------------------------------------------------------
plot(season, tweeters, 
     type = "l", 
     lty = "dotted")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "l")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "l",
     col = "#5cb85c")


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     type = "l",
     col = 3)


## -----------------------------------------------------------------------------------------
plot(season, tweeters,
     col = "#5cb85c", 
     lwd = 3)


## -----------------------------------------------------------------------------------------
plot(season, tweeters, 
     type = "l", 
     col = "#5cb85c", 
     lwd = 3,
     xlab = "Quarter",
     ylab = "Tweeters (in millions)",
     main = "Active Users on Twitter")


## -----------------------------------------------------------------------------------------
fit1 <- lm (tweeters ~ season, 
            data = twitter) 

summary(fit1)

plot(fit1)


## -----------------------------------------------------------------------------------------
data(iris)
head(iris)


## -----------------------------------------------------------------------------------------
pairs(iris)


## -----------------------------------------------------------------------------------------
pairs(iris, 
      col = iris$Species)


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species)


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species, 
     pch = 15)


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species, 
     pch = "A")


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species, 
     pch = 21, 
     bg = "blue")


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species, 
     pch = 16)


## -----------------------------------------------------------------------------------------
plot(iris$Sepal.Length, 
     iris$Petal.Length, 
     col = iris$Species, 
     pch = 16,
     cex = 2)


## -----------------------------------------------------------------------------------------
head(iris)


## -----------------------------------------------------------------------------------------
boxplot(iris$Sepal.Length ~ iris$Species)


## -----------------------------------------------------------------------------------------
boxplot(iris$Sepal.Length ~ iris$Species, 
        notch = T)


## -----------------------------------------------------------------------------------------
boxplot(iris$Sepal.Length ~ iris$Species, 
        notch = T,
        las = 1) 


## -----------------------------------------------------------------------------------------
boxplot(iris$Sepal.Length ~ iris$Species, 
        notch = T,
        las = 1,
        xlab = "Species", 
        ylab = "Sepal Length", 
        main = "Sepal Length by Species in Iris") 


## -----------------------------------------------------------------------------------------
boxplot(iris$Sepal.Length ~ iris$Species, 
        notch = T,
        las = 1,
        xlab = "Species", 
        ylab = "Sepal Length", 
        main = "Sepal Length by Species in Iris",
        cex.lab = 1.5,
        cex.axis = 1.5,
        cex.main = 2) 


## -----------------------------------------------------------------------------------------
# number of rows, number of columns
par(mfrow=c(1,2))

plot(
     # x variable, y variable
     iris$Sepal.Length, iris$Petal.Length, 
     
      # color by species
     col = iris$Species,     
     
     # plot title
     main = "Sepal vs Petal Length in Iris"
     )      

plot(
    # x variable, y variable
     iris$Sepal.Length, iris$Petal.Length, 
     
      # color by species
     col = iris$Species,     
     
     # plot title
     main = "Sepal vs Petal Length in Iris"
     )        


## -----------------------------------------------------------------------------------------
par(mfrow=c(1,1))    

plot(
     # x variable, y variable
     iris$Sepal.Length, iris$Petal.Length, 
     
      # color by species
     col = iris$Species,     
     
     # plot title
     main = "Sepal vs Petal Length in Iris"
     )   


## -----------------------------------------------------------------------------------------
dev.off()       

