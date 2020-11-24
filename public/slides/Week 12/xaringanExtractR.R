# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("Slides-Week-13.Rmd")
purl("Slides-Week-13R.Rmd")
