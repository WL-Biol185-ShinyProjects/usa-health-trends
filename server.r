library(shiny)
library(tidyverse)
library(ggplot2)
library(readr)
library(leaflet)
library(RColorBrewer)
library(dplyr)

filterEqual <- function(x, columnName, value) {
  x[x[[columnName]] == value, ]
}


USA_health <- read_csv("USA_health_4.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)

colnames(USA_health)[3:ncol(USA_health)] <- cleanColumnNames(colnames(USA_health[3:ncol(USA_health)]))

function(input, output, session) {

  observe({ 
    stateFilter <- USA_health %>% filter(State == input$outcomesState)
    updateSelectizeInput(session, "outcomesCounty", choices = stateFilter$County) 
         })
  
  
  output$health_plot <- renderPlot({
    
  stateFilter <- USA_health %>% filter(State == input$outcomesState)
  print(stateFilter)
  
   stateFilter %>%
      filter(County %in% input$outcomesCounty) %>%
      ggplot(aes_string("County", input$outcomesYaxis, fill = input$outcomesGrouping)) + 
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
                                  })
  

  USA_health$State <- factor(USA_health$State)
  USA_health$County <- factor(USA_health$County)
  
  statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
  stateHealth <- read_csv("overall state health.csv")
  
  statesGEO@data <- 
    statesGEO@data %>%
    left_join(stateHealth, by = c("NAME" = "State Name"))
  
  output$state_map <- renderLeaflet({
    
    pal <- colorBin("YlOrRd", domain = c(1,50), bins = 5, pretty = TRUE, na.color = "#809000",
                    alpha = FALSE, reverse = FALSE)
    
    labels <- sprintf(
      "<strong>%s</strong><br/>%g",
      statesGEO@data$NAME, statesGEO@data$Rank
                      ) %>% lapply(htmltools::HTML)
    
    
    PlotMap <- leaflet(statesGEO) %>%
      setView(-96, 37.8, 4) %>%
      addTiles()
    
    PlotMap %>% addPolygons(
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
        bringToFront = TRUE),
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
      addLegend(pal = pal, values = ~Rank, opacity = 0.7, title = NULL,
                position = "bottomright")
    
      })
  

  countyGEO  <- rgdal::readOGR("counties.json", "OGRGeoJSON")
  countyHealth <- read_csv("Overall County Data.csv", na = "NR")
  
  stateName              <- as.character(statesGEO@data$NAME)
  names(stateName)       <- as.character(statesGEO@data$STATE)
  countyGEO@data$stateName <- stateName[as.character(countyGEO@data$STATE)]
  
  
  output$county_map <- renderLeaflet({
  
    filteredCountyHealth <- countyHealth %>% 
      filterEqual("State", input$StateCounty)
  
  countyGEO@data <- 
    countyGEO@data %>%
    left_join(filteredCountyHealth, by = c("stateName" = "State", "NAME" = "County")) 
    
  palcounty <- colorBin("YlOrRd", domain = c(1, 5), bins = 5, pretty = TRUE, na.color = "white",
                  alpha = FALSE, reverse = FALSE)
  labels <- sprintf(
    "<strong>%s</strong><br/>%g",
    countyGEO@data$NAME , countyGEO@data$HO_Quartile
                    ) %>% lapply(htmltools::HTML)
  
  PlotCounty <- 
    leaflet(countyGEO) %>%
    setView(-96, 37.8, 4) %>%
    addTiles()
  
  PlotCounty %>% 
    
    addPolygons( data        = statesGEO
                 , color       = "black"
                 , weight      = 15
                 , fillOpacity = 0
                ) %>%
    
    
    addPolygons(
    fillColor = ~palcounty(HO_Quartile),
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
      bringToFront = TRUE),
    
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>% 
    addLegend(pal = palcounty, values = ~HO_Quartile, opacity = 0.7, title = NULL,
    position = "bottomright")
})
  
  
  
}






