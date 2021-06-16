## install.packages("psych", dependencies = TRUE)

## library("tidyverse")
## library("psych")
## library("reactable")
## library("polycor")

## setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


## conspiracy_data <- read_csv("ConspiracyData.csv")

## conspiracy_codebook <- read_csv("ConspiracyCodebook.csv")

## conspiracy_measures<- read_csv("ConspiracyMeasures.csv")


conspiracy_codebook %>%
  head()

conspiracy_measures


reactable(conspiracy_measures)

reactable(conspiracy_codebook)

reactable(conspiracy_codebook,
          searchable = TRUE, 
          defaultPageSize = 3)


dim(conspiracy_data)


thing <- reactable(conspiracy_data,
                   searchable = TRUE, 
                   defaultPageSize = 5,
                   showPageSizeOptions = TRUE,
                   highlight = TRUE)

thing


theme <- reactableTheme(
  style = list(".dark &" = list(color = "#fff", background = "#282a36")),
  cellStyle = list(".dark &" = list(borderColor = "rgba(255, 255, 255, 0.15)")),
  headerStyle = list(".dark &" = list(borderColor = "rgba(255, 255, 255, 0.15)")),
  paginationStyle = list(".dark &" = list(borderColor = "rgba(255, 255, 255, 0.15)")),
  rowHighlightStyle = list(".dark &" = list(background = "rgba(255, 255, 255, 0.04)")),
  pageButtonHoverStyle = list(".dark &" = list(background = "rgba(255, 255, 255, 0.08)")),
  pageButtonActiveStyle = list(".dark &" = list(background = "rgba(255, 255, 255, 0.1)"))
) # This was copied

togglething <- reactable(conspiracy_data,
                          searchable = TRUE, 
                          defaultPageSize = 5,
                          showPageSizeOptions = TRUE,
                          highlight = TRUE,
                          theme = theme) # I only added this last line

tags$button(onclick = "document.querySelector('.themeable-tbl').classList.toggle('dark')",
            "Toggle light/dark") # This was copied.

div(class = "themeable-tbl dark", togglething) # This was copied and only the variable name changed.


lst <- tibble(
  
  approach = c("Performed accounting for multiple scales",
               "Performed on scales that have been reduced",
               "Performed on grouped items with like scales"
               ),
  
  complexity = c("Most",
                 "Less",
                 "Minimal"
                 ),
  
  information = c("Information is lossless",
                  "Information gathered from higher order scales is lost due to reduction",
                  "Only information between items with the same scaling is retained"
                  ),
  
  get = c("Between items of the same AND different scales",
         "Between items of the same AND different scales at the lowest scaling",
          "Between items of the same scale"
         )
  
)

conspiracy_data_10 <- conspiracy_data %>%
                      head(n=10)



scree(conspiracy_data_10)


EFA <- fa(conspiracy_data_10,
          nfactors = 3)

EFA

EFA$loadings


fa.diagram(EFA)

class(EFA)


MR1_factor <- conspiracy_codebook %>%
  filter(str_detect(Item, paste(c("Q12", "Q7", "Q11", "Q14", "Q1", "Q9", "Q2", "Q5"), collapse = '|')))

MR2_factor <- conspiracy_codebook %>%
  filter(str_detect(Item, paste(c("Q3", "Q13", "Q8", "Q4"), collapse = '|')))

MR3_factor <- conspiracy_codebook %>%
  filter(str_detect(Item, paste(c("Q6", "Q15", "Q10"), collapse = '|')))


reactable(MR1_factor,
          defaultPageSize = 11)

reactable(MR2_factor)

reactable(MR3_factor)


head(conspiracy_data_10)


reactable(conspiracy_data_10)


conspiracy_data_10 %>%
  head() %>%
  rowSums()


head(EFA$scores)


summary(EFA$scores)


plot(density(EFA$scores, 
             na.rm = TRUE), 
     main = "Factor Scores")
