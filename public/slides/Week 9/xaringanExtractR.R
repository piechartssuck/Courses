# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("Slides-Week-9.Rmd")
purl("Slides-Week-9R.Rmd")
