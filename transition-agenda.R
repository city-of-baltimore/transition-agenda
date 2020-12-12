install.packages("shiny")
install.packages("tidyverse")

library(shiny)
library(tidyverse)

ui <- pageWithSidebar(
  
  
  #app title
  headerPanel("Brandon Scott's 100 Days of Action"),
  
  
  #sidebar panel for inputs
  sidebarPanel("Program Areas"),
  
  
  #main panel for outputs
  mainPanel()
)

server <- function(input, output){
  
  
}

shinyApp(ui,server)

runApp("~/shinyapp")
