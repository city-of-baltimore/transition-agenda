#install relevant packages
install.packages("shiny")
install.packages("tidyverse")
install.packages("googlesheets4")
install.packages("formattable")
install.packages("ggplot2")

#load packages
library(shiny)
library(tidyverse)
library(googlesheets4)
library(formattable)
library(ggplot2)


#set up google sheets access
pg1 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 1)
pg2 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 2)
pg3 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 3)
pg4 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 4)

#Create table for manipulation later
table1 <- pg1 %>%
  select(c(2,4,5,6,10,11,13))

#add text for Brandon Scott's welcome
text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")

#produce basic shell for the site
ui <- fluidPage(
  
  
  #app title
  headerPanel("Brandon Scott's 100 Days of Action"),
  
  
  #Welcome comment from Mayor Scott
  sidebarPanel(text1)
  ,
  
  
  sidebarPanel(
    
    #input: selector for Mayor Scott's agenda areas
    selectInput("variable","Program Area",
                pg1[2]
    )
  ),
  
  #sidebar panel for inputs
  sidebarPanel(
    
    plotOutput("plot1",
               hover = "plot_hover"),
    width = 5,
    height = 2
  ),
  
  #Table of actions
  fluidRow(
    column(12,
           dataTableOutput('table'))
  )

  )

server <- function(input, output){
  
  #Load the table output 
  output$table <- renderDataTable(table1)
  
  #Load the progress tracker output
  output$plot1 <- renderPlot({
    table1 %>%
      ggplot(aes(fill = Progress, x = "", y = "")) +
      geom_bar(position = "fill", 
               stat = "identity",
               width = .5) +
      coord_flip() +
      theme(legend.position = "bottom",
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=c("forest green", "red"))
    
  }, height = 300)
  
}

# run to see the page
shinyApp(ui,server)


