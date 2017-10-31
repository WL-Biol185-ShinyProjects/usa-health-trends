library(shiny)
library(readxl)
library(leaflet)


USA_health <- read_csv("USA health trends ranked measure data.xlsx", 
                                                   col_names     = TRUE,
                                                   na = c("***"))

# Sidebar with a slider input
fluidPage(
  
  titlePanel('Health Outcomes by County') , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = 'State', 
                             label = 'Select a state' , 
                             choices = unique(Sample_R_Data$State)
                             ),
                            
                      
                             selectInput(inputId = 'value1' ,
                             label = 'Select First Value' ,
                            choices = colnames(USA_health)[4:ncol(USA_health)])
               #change input ID to something more specific
               ),
          
                              selectInput(inputId = 'value2' ,
                             label = 'Select Second Value' ,
                             choices = colnames(USA_health)[4:ncol(USA_health)]
                             
                              ),

#Panel plot
mainPanel(
  plotOutput("health_plot")
)

))