# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

# purl("02-walkthrough.Rmd")
# purl("03-walkthrough.Rmd")
# purl("04-walkthrough.Rmd")
# purl("05-walkthrough.Rmd")
purl("06-walkthrough.Rmd")

