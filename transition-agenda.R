#install and load relevant packages
pacman::p_load(ggplot2, gfonts, googlesheets4, 
               formattable, shiny, tidyverse)

#Set up font
get_all_fonts()
setup_font(id = "roboto", output_dir = "www")
use_font("roboto", "www/css/roboto.css")

#Set up colors
iteam_red <- "#f15a29"
iteam_red_light5 <- "#f8ad94"
iteam_red_light9 <- "#feefea"
iteam_yellow <- "#ffc429"
iteam_green <- "#2bb673"
iteam_purple <- "#893395"
bc_gold <- "#fdb927"
bchd_blue <- "#199eb4"

#set up google sheets access
pg1 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 1)
pg2 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 2)
pg3 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 3)
pg4 <- read_sheet("https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing", sheet = 4)

#Create table for manipulation later
table1 <- pg1 %>%
  select(c(2,4,5,6,10,11,13,14))

#add text for Brandon Scotts welcome
text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")

#produce basic shell for the site
ui <- fluidPage(
  
  #style
  tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
  tags$style("body {font-family: 'Roboto', sans-serif;}"),
  
  #app title
  headerPanel(strong("Mayor Brandon Scott's 100 Days of Action")),
  
  #Welcome comment from Mayor Scott
  sidebarPanel(text1),
  
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
      ggplot(aes(fill = Progress, x = Count, y = "")) +
      geom_bar(position = position_fill(reverse = TRUE), 
               stat = "identity",
               width = .5) +
      theme(legend.position = "bottom",
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=c(iteam_green, iteam_red_light9))
    
  }, height = 300)
  
}

# run to see the page
shinyApp(ui,server)



table1 %>%
  ggplot(aes(fill = Progress, x = "", y = Count)) +
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
  scale_fill_manual(values=c(iteam_green, iteam_red))
