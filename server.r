#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readxl)
library(leaflet)

USA_health <- read_csv("USA health trends ranked measure data.xlsx", 
                                                   col_names = TRUE,
                                                   na = c("***")
                                                  )


#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({

    #Sample_R_Data[Sample_R_Data$State == input$State,] %>%
     # ggplot(aes_string("County", input$value)) + geom_bar(stat = "identity") + 
      #                  theme(axis.text.x = element_text(angle = 60, hjust = 1))
  

   USA_health %>%
      filter(State == input$State) %>%
      ggplot(aes_string("County", input$value1)) + geom_bar(stat = "identity", color = input$value2) + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  })}





