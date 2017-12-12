library(tidyverse)
library(shiny)
library(readr)
library(leaflet)
library(shinythemes)


USA_health <- read_csv("USA_health_4.csv", na = "***")
USA_health$State <- factor(USA_health$State)
USA_health$County <- factor(USA_health$County)

USA_health_columns <- sapply( colnames(USA_health[3:ncol(USA_health)]), 
                              cleanColumnNames, 
                              simplify = FALSE
                            )

countyHealth <- read_csv("Overall County Data.csv")

fluidPage(theme = shinytheme("cerulean"),
          
  
  
navbarPage("USA Health Trends",
                  #tabPanel() MAPS AND LEAFLET CODE

tabPanel("Title Page",
        
            mainPanel(
                  h1("Welcome to USA Health Trends!", align = "center"),
                  HTML('<center><img src="Happy Fam.jpg" width="400"></center>'),
                  h4("Health and wellbeing is a culmination of a variety of factors, ranging from access to hospitals to one's social networks. As we gather more research on the concept of health, it is essential to understand what these factors are and their quality across different 
                        communities in America.This website is a compilation of analyses that examine a variety of health factors and outcomes. Which states are the healthiest (or unhealthiest)? What are the health rankings of counties within states? 
                        How do statewide counties compare in terms of health factors, such as violent crime rates or average number of mentally unhealthy days? Our project will tell you!", align = "center")
         )),

          navbarMenu("Maps",
                  tabPanel("By State", 
                           mainPanel(leafletOutput("state_map"),
                                     h4("The colors of this map represent the rankings of all 50 U.S. States by their health outcomes. Hover over the state you are interested in to find its national health outcomes ranking. A ranking of 1 indicates the best health outcomes, and a ranking of 50 indicates the worst health outcomes."))
                                                   
                                                      
                                         ),
                   tabPanel("By County",
                                            
                          sidebarLayout(
                               mainPanel(leafletOutput("county_map"),
                                         h4("The colors of this map represent the health outcome rankings by quartiles of all U.S. counties. Select the state you are intersted in, then use the map to zoom in and view the health outcomes of its counties. The first quartile indicates the best health outcomes, and the fourth quartile indicates the worst health outcomes.")), 
                                      sidebarPanel(
                                        selectInput(inputId = 'StateCounty', 
                                              label = 'Select a state' , 
                                              choices = unique(countyHealth$State))
                                         )
                              ))),
          
                            
           
tabPanel("Statewide Comparisons of Health Variables",
  
         titlePanel('Health Outcomes and Factors by County') , 
             
             sidebarLayout(
               #panel with widgets
               sidebarPanel(
                 selectInput(inputId = 'outcomesState', 
                             label = 'Select a State' , 
                             choices = unique(USA_health$State)
                             ),
              
    
                 selectInput(inputId = 'outcomesCounty',
                             label   = 'Select Counties',
                             choices = "",
                             selected = "Autauga",
                             multiple = TRUE),
                 
                      
                             selectInput(inputId = 'outcomesYaxis' ,
                             label = 'Select First Factor or Outcome' ,
                            choices = USA_health_columns
                                         ),
          
                              selectInput(inputId = 'outcomesGrouping' ,
                             label = 'Select Second Factor or Outcome' ,
                             choices = USA_health_columns
                             
                              )),
      
               
               mainPanel(
                 plotOutput("health_plot"),
                 h4("To utilize this graph, please first select your state and counties of choice. 
                    Then, please select your first and second health factor or outcome. Counties will
                    be displayed on the x axis, the first health factor or outcome will be displayed on the
                    y axis, and the second health factor or outcome will be displayed as a gradient fill
                    within the bars. A description of the health factors/outcomes is below.", align = "center"),
                 h2("Health Factors/Outcomes and Description"),
                 p("Years of Potential Life Lost Rate: Age-adjusted YPLL rate per 100,000"),
                 p("Percent Fair/Poor Health: Percent of adults that report fair or poor health"),
                 p("Number Physically Unhealthy Days: Average number of reported physically unhealthy days per month"),
                 p("Number Mentally Unhealthy Days: Average number of reported mentally unhealthy days per month"),
                 p("Percent LBW: Percentage of births with low birth weight (LBW) (<2500g)"),
                 p("Percent Smokers: Percentage of adults that reported currently smoking"),
                 p("Percent Obese: Percentage of adults that report BMI >= 30"),
                 p("Food Environment Index: Indicator of access to healthy foods - 0 is worst, 10 is best"),
                 p("Percent Physically Inactive: Percentage of adults that report no leisure-time physical activity"),
                 p("Percent With Access To Exercise: Percentage of adults that report no leisure-time physical activity"),
                 p("Percent Excessive Drinking: Percentage of adults that report excessive drinking"),
                 p("% Alcohol Impaired: Percentage of driving deaths with alcohol involvement"),
                 p("Chlamydia Rate: Chlamydia cases / Population * 100,000"),
                 p("Teen Birth Rate: Teen births / females ages 15-19 * 1,000"),
                 p("% Uninsured: Percentage of people under age 65 without insurance"),
                 p("PCP Rate: (Number of Primary Care Physicians/population)*100,000"),
                 p("Dentist Rate: (Number of dentists/population)*100,000"),
                 p("MHP Rate: (Number of MHP/population)*100,000"),
                 p("Preventable Hosp. Rate: Discharges for Ambulatory Care Sensitive Conditions/Medicare Enrollees * 1,000"),
                 p("% Receiving HbA1c: Percentage of diabetic Medicare enrollees receiving HbA1c test"),
                 p("% Mammography: Percentage of female Medicare enrollees having at least 1 mammogram in 2 yrs (age 67-69)"),
                 p("Graduation Rate: Percentages of high school students who graduated with a high school diploma in four years"),
                 p("% Some College: Percentage of adults age 25-44 with some post-secondary"),
                 p("% Unemployed: Percentage of population ages 16+ unemployed and looking for work"),
                 p("% of Children in Poverty - Percentage of children (under age 18) living in poverty"),
                 p("% of Children in Poverty Black - Percentage of black children (under age 18) living in poverty - from the 2011-2015 ACS"),
                 p("% of Children in Poverty Hispanic - Percentage of Hispanic children (under age 18) living in poverty - from the 2011-2015 ACS"),
                 p("% of Children in Poverty White - Percentage of black children (under age 18) living in poverty - from the 2011-2015 ACS"),
                 p("Income Ratio - Ratio of household income at the 80th percentile to income at the 20th percentile"),
                 p("% Single-Parent Households - Percentage of children that live in single-parent households"),
                 p("Association Rate: Social Connections / Population * 10,000"),
                 p("Violent Crime Rate: Violent Crimes / Population * 10,000"),
                 p("Injury Death Rate: Injury mortality rate per 100,000"),
                 p("Average Daily PM2.5: Average daily amount of fine particulate matter in micrograms per cubic meter"),
                 p("% Severe Housing Problems: Percentage of households with at least 1 of 4 housing problems: overcrowding, high housing costs, or lack of kitchen or plumbing facilities"),
                 p("% Drive Alone: Percentage of workers who drive alone to work"),
                 p("% Drive Alone Black: Percentage of black workers who drive alone to work"),
                 p("% Drive Alone Hispanic: Percentage of Hispanic workers who drive alone to work"),
                 p("% Drive Alone White: Percentage of white workers who drive alone to work"),
                 p("% Long Commute Drive Alone: Among workers who commute in their car alone, the percentage that commute more than 30 minutes")
               )
               
               )),
  
  tabPanel("References",
           mainPanel(
             h4("County Data"),
             h5(a( href = "http://www.countyhealthrankings.org/our-approach", 
                  "http://www.countyhealthrankings.org/our-approach")),
             h4("State Data"),
             h5(a( href ="https://www.americashealthrankings.org/explore/2016-annual-report/state/ALL",
                   "https://www.americashealthrankings.org/explore/2016-annual-report/state/ALL")),
             h4("Title Page Image"),
             h5(a( href = "https://www.huffingtonpost.com/donna-m-butts/modern-family-relationships_b_5310933.html",
                   "https://www.huffingtonpost.com/donna-m-butts/modern-family-relationships_b_5310933.html" ))
             ))


))