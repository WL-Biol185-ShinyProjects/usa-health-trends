library(tidyverse)
library(shiny)
library(readr)
library(leaflet)


USA_health <- read.csv("USA health.csv", 
                                  col.names     = TRUE, 
                                  stringsAsFactors = FALSE, 
                                  header = TRUE, sep = ";",
                                  na.strings = "***", as.numeric(4:ncol(USA_health)))
 
  
# Sidebar with a slider input
fluidPage(
  
  titlePanel('Health Outcomes by County') , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = 'State', 
                             label = 'Select a state' , 
                             choices = unique(USA_health$State)
                             ),
                            
                      
                             selectInput(inputId = 'value1' ,
                             label = 'Select First Value' ,
                            choices = colnames(USA_health)[4:ncol(USA_health)])
               #change input ID to something more specific
               ),
          
                              selectInput(inputId = 'value2' ,
                             label = 'Select Second Value' ,
                             choices = colnames(USA_health)[4:ncol(USA_health)]
                             
                              ),

#Panel plot
mainPanel(
  plotOutput("health_plot")
)

))