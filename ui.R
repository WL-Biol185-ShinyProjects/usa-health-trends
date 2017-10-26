library(shiny)
library(readxl)

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
                            choices = colnames(USA_health_trends_ranked_measure_data)[4:ncol(USA_health_trends_ranked_measure_data)])
               #change input ID to something more specific
               ),
          
                              selectInput(inputId = 'value2' ,
                             label = 'Select Second Value' ,
                             choices = colnames(USA_health_trends_ranked_measure_data)[4:ncol(USA_health_trends_ranked_measure_data)]
                             
                              ),

#Panel plot
mainPanel(
  plotOutput("health_plot")
)

))