#install relevant packages
install.packages("shiny")
install.packages("tidyverse")
install.packages("googlesheets4")

#load packages
library(shiny)
library(tidyverse)
library(googlesheets4)


#set up google sheets access
pg1 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 1)
pg2 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 2)
pg3 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 3)
pg4 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 4)


#produce basic shell for the site
ui <- pageWithSidebar(
  
  
  #app title
  headerPanel("Brandon Scott's 100 Days of Action"),
  
  
  #sidebar panel for inputs
  sidebarPanel(
    
    #input: selector for Mayor Scott's agenda areas
    selectInput("variable","Program Area",
                pg3[2]
    )
  ),
  
  sidebarPanel(
    
    #input: selector for Mayor Scott's agenda areas
    selectInput("variable","Program Area",
                pg3[3]
    )
  )
  

  )

server <- function(input, output){
  
  
}

# run to see the page
shinyApp(ui,server)


