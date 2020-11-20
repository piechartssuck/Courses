# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pagedown::chrome_print("Slides-Week-13.Rmd")
pagedown::chrome_print("Slides-Week-13R.Rmd")

