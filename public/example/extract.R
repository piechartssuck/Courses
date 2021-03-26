setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(knitr)

purl("02-example.Rmd")
purl("03-example.Rmd")
purl("04-example.Rmd")
purl("05-example.Rmd")
purl("06-example.Rmd")
purl("07-example.Rmd")
purl("08-example.Rmd")
purl("09-example.Rmd")
