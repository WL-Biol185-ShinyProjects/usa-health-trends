library(tidyverse)
library(shiny)
library(readr)
library(leaflet)
library(shinythemes)


USA_health <- read_csv("~/usa-health-trends/USA_health_4.csv", na = "***")
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
                  HTML('<center><img src="Happy Fam.jpg" width="400"></center>'),
                  h4("Health and wellbeing is a culmination of a variety of factors, ranging from access to hospitals to one's social networks. As we gather more research on the concept of health, it is essential to understand what these factors are and their quality across different 
                        communities in America.This website is a compilation of analyses that examine a variety of health factors and outcomes. Which states are the healthiest (or unhealthiest)? What are the health rankings of counties within states? 
                        How do statewide counties compare in terms of health factors, such as violent crime rates or average number of mentally unhealthy days? Our project will tell you!", align = "center")
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
  
         titlePanel('Health Outcomes and Factors by County') , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = 'outcomesState', 
                             label = 'Select a State' , 
                             choices = unique(USA_health$State)
                             ),
              
    
                            uiOutput(outputId = "select_county"),
                 
                      
                             selectInput(inputId = 'outcomesYaxis' ,
                             label = 'Select First Factor or Outcome' ,
                            choices = USA_health_columns
                                         ),
          
                              selectInput(inputId = 'outcomesGrouping' ,
                             label = 'Select Second Factor or Outcome' ,
                             choices = USA_health_columns
                             
                              )),
      
               
               mainPanel(
                 plotOutput("health_plot")
               )
               
               )),
  
  tabPanel("References")


))