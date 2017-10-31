#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readr)
library(leaflet)

USA_health <- read.csv("USA health.csv", 
                                                   col.names = TRUE,
                                                   na.strings = "***"
                                                  )


#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({
  

   USA_health %>%
      filter(State == input$State) %>%
      ggplot(aes_string("County", input$value1)) + geom_bar(stat = "identity", color = input$value2) + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  })}





