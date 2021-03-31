# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("NFLpipes.Rmd")
purl("Hypotheses.Rmd")
purl("chiSquare.Rmd")

