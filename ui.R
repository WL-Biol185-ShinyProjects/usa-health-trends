library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Dropdown box with state's names
  shinyApp(
    ui = fluidPage(
      selectInput("State", "Choose a state:",
              list(Sample_R_Data$State, 
              choices, selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
)
