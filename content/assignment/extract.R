setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("06-assignment.Rmd")
purl("06-assignment-sols.Rmd")
