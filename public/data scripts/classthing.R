library(tidyverse)
library(ggplot2movies)
library(shiny)

movies_wrangled <- movies %>%
  na.omit() %>%
  mutate(budget = budget/1000000) %>%
  gather(key = genre, value, -c(title:mpaa)) %>%
  filter(!mpaa == "") %>%
  select(-value) 

movies_by_decade <- movies_wrangled  %>%
  mutate(year = case_when(
    year %in% 1930:1939 ~ "1930s",
    year %in% 1940:1949 ~ "1940s",
    year %in% 1950:1959 ~ "1950s",
    year %in% 1960:1969 ~ "1960s",
    year %in% 1970:1979 ~ "1970s",
    year %in% 1980:1989 ~ "1980s",
    year %in% 1990:1999 ~ "1990s",
    year %in% 2000:2009~ "2000s"
    )
  )

categoricalVars <- c("year", 
                     "mpaa", 
                     "genre")

movies %>%
  filter(year > 1979) %>%
  head(n=3)

ui <- fluidPage(
  
  plotOutput("movies_plot"),
  sliderInput("year_filter",
              "Select Lowest Year",
              min = 1893,
              max = 2005,
              value = 1970)
)

server <- function(input, output) {
  
  movies_filtered <- reactive({
    movies_wrangled %>%
      filter(year >
               input$year_filter)
  })
  
  output$movies_plot <-  renderPlot({
    
    ggplot(movies_filtered()) + 
      aes_string(y="length", 
                 x="year",
                 fill="genre") + 
      geom_bar(stat="identity") +
      theme_minimal() +
      scale_fill_brewer(palette = "Spectral")
      
  })
  
}

shinyApp(ui, server)