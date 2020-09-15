# Library
library(streamgraph)
library(webshot)

# Create data ----
data <- data.frame(
  year=rep(seq(1985,2022) , each=10),
  name=rep(letters[1:10], 38),
  value=sample(seq(0,1,0.0001), 380),
  stringsAsFactors = FALSE
)

# Basic steamgraph ----
streamgraph(data, 
            key="name", 
            value="value", 
            date="year", 
            height="200px", 
            width="1000px",
            interactive = TRUE) %>%
            sg_axis_y(0) 


# %>% webshot(file = "steamgraph.pdf", delay = 2)


# Notes----
# install phantom:
# webshot::install_phantomjs()
