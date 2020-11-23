# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pagedown::chrome_print("Slides-Week-11.Rmd", format = "pdf", timeout = 90)
pagedown::chrome_print("Slides-Week-11R.Rmd", format = "pdf", timeout = 90)

