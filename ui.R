library(tidyverse)
library(shiny)
library(readr)
library(leaflet)
source("Leaflet Sample.R")


USA_health <- read_csv("~/usa-health-trends/USA health 2.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)
countyHealth <- read_csv("Overall County Data.csv")

fluidPage(

navbarPage("USA Health Trends",
                  #tabPanel() MAPS AND LEAFLET CODE
                              tabPanel("Title Page"),
                              navbarMenu("Maps",
                                         tabPanel("By State", 
                                            mainPanel(leafletOutput("state_map"))
                                                   
                                                      
                                         ),
                                         tabPanel("By County",
                                            
                                              sidebarLayout(
                                                mainPanel(leafletOutput("county_map")), 
                                                sidebarPanel(
                                                  selectInput(inputId = 'State', 
                                                              label = 'Select a state' , 
                                                              choices = unique(countyHealth$State)
                                                )
                                         )
                              ))),
          
                            
           
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
               
               )),
  
  tabPanel("Where should you live?"),
  tabPanel("References")


))