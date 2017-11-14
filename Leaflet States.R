library(leaflet)

statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
stateCodes <- read_csv("states.csv")
stateHealth <- read_csv("overall state health.csv")

#leaflet() %>% addTiles() %>%


statesGEO@data <- 
  statesGEO@data %>%
  left_join(stateCodes, by = c("NAME" = "State")) %>%
  left_join(stateHealth, by = c("Abbreviation" = "State Name"))

#pal <- colorNumeric("YlOrRd", c(1, 288))
#leaflet(data = statesGEO) %>%
  #addTiles() %>%
  #addPolygons( fillColor = ~pal(n)
             #  , weight      = 1
              # , opacity     = 0.1
              # , fillOpacity = 0.7
#  ) %>%
#  addLegend( pal = pal 
 #            , values = ~n
            # , opacity = 0.7
            # , title = NULL
          # , position = "bottomright"
 # ) %>%
 #setView(lat = 38.0110306, lng = -110.4080342, zoom = 4)


