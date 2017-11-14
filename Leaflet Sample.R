library(leaflet)

leaflet_sample <- mainPanel(leafletOutput("state_map"))
leaflet() %>% addTiles()
