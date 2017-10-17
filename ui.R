library(shiny)

#load file into r table 

Sample_R_Data <- read_xlsx("Sample R Data.xlsx")

# Sidebar with a slider input
fluidPage(
  
  titlePanel('Health Outcomes by County' , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = "State", 
                             label = 'Select a state' , 
                             choices = unique(Sample_R_Data$State)
                            
                             
                             # selectInput(inputId = 'value' ,
                             #label = 'What to plot' ,
                            # choices = colnames(recent_grads) [5:ncol(recent_grads)])
               
               )
             )
  )
))

#Panel plot
mainPanel(
  plotOutput('health_plot')
)