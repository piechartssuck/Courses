# install.packages("psych", dependencies = TRUE)

library("tidyverse")
library("psych")
library("reactable")
library("polycor")


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


conspiracy_data <- read_csv("ConspiracyData.csv")

conspiracy_codebook <- read_csv("ConspiracyCodebook.csv")

conspiracy_measures<- read_csv("ConspiracyMeasures.csv")


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
)

togglething <- reactable(conspiracy_data,
                          searchable = TRUE, 
                          defaultPageSize = 5,
                          showPageSizeOptions = TRUE,
                          highlight = TRUE,
                          theme = theme) # I only added this part...

tags$button(onclick = "document.querySelector('.themeable-tbl').classList.toggle('dark')",
            "Toggle light/dark")

div(class = "themeable-tbl dark", togglething) # ...and changed this last bit.



EFA <- fa(conspiracy_data)

EFA

EFA$loadings


fa.diagram(EFA)

class(EFA)


head(conspiracy_data)

reactable(head(conspiracy_data))


conspiracy_data %>%
  head() %>%
  rowSums()


head(EFA$scores)


summary(EFA$scores)


plot(density(EFA_model$scores, 
             na.rm = TRUE), 
     main = "Factor Scores")

