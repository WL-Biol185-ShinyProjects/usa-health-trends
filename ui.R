library(tidyverse)
library(shiny)
library(readr)
library(leaflet)
library(shinythemes)


USA_health <- read_csv("~/usa-health-trends/USA health 2.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)

USA_health_columns <- sapply( colnames(USA_health[3:ncol(USA_health)]), 
                              cleanColumnNames, 
                              simplify = FALSE
                            )

countyHealth <- read_csv("Overall County Data.csv")

fluidPage(theme = shinytheme("cerulean"),
  
  
navbarPage("USA Health Trends",
                  #tabPanel() MAPS AND LEAFLET CODE

tabPanel("Title Page",
        
            mainPanel(
                  h1("Welcome to USA Health Trends!", align = "center"),
                  h4("This website is a compilation of analyses that examine a variety of health factors and outcomes. Which states are the healthiest (or unhealthiest)? What are the health rankings of counties within states? 
                        How do statewide counties compare in terms of health factors, such as violent crime rates? Our project will tell you!", align = "center")
         )),

          navbarMenu("Maps",
                  tabPanel("By State", 
                           mainPanel(leafletOutput("state_map"))
                                                   
                                                      
                                         ),
                   tabPanel("By County",
                                            
                          sidebarLayout(
                               mainPanel(leafletOutput("county_map")), 
                                      sidebarPanel(
                                        selectInput(inputId = 'StateCounty', 
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
                 selectInput(inputId = 'outcomesState', 
                             label = 'Select a State' , 
                             choices = unique(USA_health$State)
                             ),
    
                 selectInput(inputId = 'outcomesCounty',
                                label = 'Select Counties' ,
                                choices = unique(USA_health$County),
                                                 multiple = TRUE,
                                                 selectize = TRUE,
                                ),
                 
                      
                             selectInput(inputId = 'outcomesYaxis' ,
                             label = 'Select First Value' ,
                            choices = USA_health_columns
               #change input ID to something more specific
               ),
          
                              selectInput(inputId = 'outcomesGrouping' ,
                             label = 'Select Second Value' ,
                             choices = USA_health_columns
                             
                              )),
      
               
               mainPanel(
                 plotOutput("health_plot")
               )
               
               )),
  
  tabPanel("Where should you live?"),
  tabPanel("References")


))