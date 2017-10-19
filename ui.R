library(shiny)

#load file into r table 

Sample_R_Data <- read_xlsx("Sample R Data.xlsx")

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
                            
                             
                             selectInput(inputId = 'value' ,
                             label = 'select value' ,
                            choices = colnames(Sample_R_Data) [5:ncol(Sample_R_Data)])
               
               ),
          


#Panel plot
mainPanel(
  plotOutput("health_plot")
)

))