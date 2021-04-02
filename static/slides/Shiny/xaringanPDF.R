# Set the working directory as source ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

pagedown::chrome_print("Shiny.Rmd", timeout=90)
# xaringan::decktape('Shiny.Rmd', 'Shiny.pdf')

