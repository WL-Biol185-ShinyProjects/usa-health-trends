#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readr)
library(leaflet)

USA_health <- read_csv("~/usa-health-trends/USA health.csv", na = "***")   
USA_health[20:21] <- NULL
USA_health[24] <- NULL
USA_health[27] <- NULL
USA_health[59] <- NULL

#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({
  

   USA_health %>%
      filter(State == input$State) %>%
      ggplot(aes_string("County", input$value1)) + geom_bar(stat = "identity", color = input$value2) + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  })}





