library(tidyverse)
library(shiny)
library(readr)
library(leaflet)


USA_health <- read_csv("~/usa-health-trends/USA health.csv", na = "***")
USA_health[20:21] <- NULL
USA_health[24] <- NULL
USA_health[27] <- NULL
USA_health[59] <- NULL

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