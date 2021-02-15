setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("02-example.Rmd")
purl("03-example.Rmd")
purl("04-example.Rmd")
