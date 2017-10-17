library(shiny)

#load file into r table 

Sample_R_Data <- read_xlsx("Sample R Data.xlsx")

# Sidebar with a slider input
fluidPage(
  
  titlePanel('Recent Grads Info!' , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = "Major Categor", 
                             label = 'Select a major category' , 
                             choices = unique(recent_grads$Major_category) , 
                             selectInput(inputId = 'value' ,
                                         label = 'What to plot' ,
                                         choices = colnames(recent_grads) [5:ncol(recent_grads)])
                             #gives choices to plot y axis - columns 5-nth value on data set
                 )
               )
             )
  )
)

#Panel plot
mainPanel(
  plotOutput('employed_plot')
)