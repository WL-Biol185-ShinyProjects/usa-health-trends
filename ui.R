library(shiny)
library(readxl)
library(leaflet)

#load file into r table 
  #Sample_R_Data <- read_xlsx("Sample R Data.xlsx")
  #colnames(Sample_R_Data) <-c("FIPS", "State", "County", "HO_Rank", "HO_Quartile", "HF_Rank", "HF_Quartile")

USA_health <- read_xlsx("USA health trends ranked measure data.xlsx", 
                                                   col_names     = TRUE,
                                                   na = "***")

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