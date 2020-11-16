
satisdf3 <- tibble(
    Core.x = c("PD", "PILOT", "CEO"),
    mean = c(1, 2, 3),
    item = as.factor(c("Q1", "Q2", "Q2"))
)

ui<- fluidPage(
    selectInput(inputId = "core",
                label= "Choose a Role",
                choices= unique(satisdf3$Core.x)),
    plotOutput("Graph")
)

server <- function(input, output) {
    dfInput <- reactive({
        satisdf3 %>%
            filter(Core.x == input$core)
    })
    
    output$Graph <- renderPlot({
        df1 <- dfInput()
        ggplot(df1, aes(x = mean, y = item)) +
            geom_point()
        
    })
}

shinyApp(ui, server)