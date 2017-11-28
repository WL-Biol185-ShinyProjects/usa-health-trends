#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readr)
library(leaflet)
library(RColorBrewer)
library(dplyr)




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
    left_join(stateHealth, by = c("NAME" = "State Name")) #%>%
    #left_join(stateHealth, by = c("State" = "State Name"))
  
  output$state_map <- renderLeaflet({
    
    #bins <- c(1, 10, 20, 30, 40, 50)
    pal <- colorBin("YlOrRd", domain = c(1,50), bins = 5, pretty = TRUE, na.color = "#809000",
                    alpha = FALSE, reverse = FALSE)
    
    
    m <- leaflet(statesGEO) %>%
      setView(-96, 37.8, 4) %>%
      addTiles()
    
    m %>% addPolygons(
      fillColor = ~pal(Rank),
      weight = 2,
      opacity = 1,
      color = "white",
      dashArray = "3",
      fillOpacity = 0.7,
      highlight = highlightOptions(
        weight = 5,
        color = "#667",
        dashArray = "",
        fillOpacity = 0.7,
        bringToFront = TRUE))
    
  })
  
output$county_map <- renderLeaflet({
  countyGEO  <- rgdal::readOGR("counties.json", "OGRGeoJSON")
  countyHealth <- read_csv("Overall County Data.csv")
  
  countyGEO@data <- 
    countyGEO@data %>%
    left_join(countyHealth, by = c("NAME" = "County"))
  
  #bins <- c(1, 2, 3, 4, 5)
  pal <- colorBin("YlOrRd", domain = c(1,5), bins = 5, pretty = TRUE, na.color = "#809000",
                  alpha = FALSE, reverse = FALSE)
  
  
  m <-  filter(State == input$State) %>% 
    leaflet(countyGEO) %>%
    setView(-96, 37.8, 4) %>%
    addTiles()
  
  m %>% addPolygons(
    fillColor = ~pal(HO_Quartile),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#667",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE))
  
})
  
  
  
}






