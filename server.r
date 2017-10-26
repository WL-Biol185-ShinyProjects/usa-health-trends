#IN SERVER.R
library(shiny)
library(tidyverse)
library(ggplot2)
library(readxl)

Sample_R_Data <- read_xlsx("Sample R Data.xlsx")
colnames(Sample_R_Data) <-c("FIPS", "State", "County", "HO_Rank", "HO_Quartile", "HF_Rank", "HF_Quartile")


#define server logic to draw historgram 
function(input, output) {
  
  output$health_plot <- renderPlot ({

    Sample_R_Data[Sample_R_Data$State == input$State,] %>%
      ggplot(aes_string("County", input$value)) + geom_bar(stat = "identity") + 
                        theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  })}

USA_health_trends_ranked_measure_data <- read.table("USA health trends ranked measure data.xlsx", 
                        header     = TRUE,
                        na.strings = "***"
)


