# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pagedown::chrome_print("Slides-Week-7.Rmd")

