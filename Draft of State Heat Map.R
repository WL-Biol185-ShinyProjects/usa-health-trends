statesGEO  <- rgdal::readOGR("states.geo.json", "OGRGeoJSON")
stateCodes <- read_csv("states.csv")
stateHealth <- read_csv("overall state health.csv")

statesGEO@data <- 
  statesGEO@data %>%
  left_join(stateCodes, by = c("NAME" = "State")) %>%
  left_join(stateHealth, by = c("Abbreviation" = "State Name"))

m <- leaflet(statesGEO) %>%
  setView(-96, 37.8, 4) %>%
  addTiles()
addPolygons()