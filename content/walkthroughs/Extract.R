# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("02-walkthrough.Rmd")

