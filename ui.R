library(tidyverse)
library(shiny)
library(readr)
library(leaflet)


USA_health <- read_csv("~/usa-health-trends/USA health 2.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)

fluidPage(

navbarPage("USA Health Trends",
                  #tabPanel() MAPS AND LEAFLET CODE
           
                   tabPanel("Statewide Comparisons of Health Variables",
  
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
                            choices = colnames(USA_health)[3:ncol(USA_health)]
               #change input ID to something more specific
               ),
          
                              selectInput(inputId = 'value2' ,
                             label = 'Select Second Value' ,
                             choices = colnames(USA_health)[3:ncol(USA_health)]
                             
                              )),

mainPanel(
  plotOutput("health_plot")
)


))))