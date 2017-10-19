
#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)

Sample_R_Data <- read_xlsx("Sample R Data.xlsx")
colnames(Sample_R_Data) <-c("FIPS", "State", "County", "HO_Rank", "HO_Quartile", "HF_Rank", "HF_Quartile")


#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({
    
    Sample_R_Data %>%
      filter(State == input$State) %>%
      ggplot(aes_string("County", input$value)) + geom_bar(stat = "identity")
    #this line specifies to plot what the user selects as the category in the dropdown
    
  })}

  


