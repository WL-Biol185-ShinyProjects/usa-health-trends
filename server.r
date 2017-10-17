mainPanel(
  plotOutput('employed_plot')
)

#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)

#define server logic to draw historgram 
funciton(input, output) {
  
  output$employed_plot <- renderPlot ({
    
    recent_grads %>%
      filter(Major_category == input$major_category) %>%
      ggplot(aes(Major, Employed)) + geom_bar(stat = "identity")
    #this line specifies to plot what the user selects as the category in the dropdown
    
  })}

  
}

