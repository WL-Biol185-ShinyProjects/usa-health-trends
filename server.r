#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readr)
library(leaflet)



USA_health <- read_csv("~/usa-health-trends/USA health 2.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)




#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({
  
  
       USA_health %>%
          filter(State == input$State) %>%
          ggplot(aes_string("County", input$value1)) + geom_bar(stat = "identity", fill(input$value2)) + 
          theme(axis.text.x = element_text(angle = 60, hjust = 1))


  }) 
    

  

  statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
  stateCodes <- read_csv("states.csv")
  stateHealth <- read_csv("overall state health.csv")

  

  statesGEO@data <- 
    statesGEO@data %>%
    left_join(stateCodes, by = c("NAME" = "State")) %>%
    left_join(stateHealth, by = c("Abbreviation" = "State Name"))
  
  
  output$state_map <- renderLeaflet({
  
    m <- leaflet(statesGEO) %>%
      setView(-96, 37.8, 4) %>%
      addTiles()
    
    
    m %>% 
      addPolygons()
    
    
    
    
  })
  
  
  }
   







