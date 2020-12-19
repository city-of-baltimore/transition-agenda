#install and load relevant packages
pacman::p_load(ggplot2, gfonts, googlesheets4, 
               formattable, shiny, tidyverse,
               lubridate, readxl)

#Set up font
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
pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 1)
pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 2)
pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 3)
pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 4)

#Create table for manipulation later
table1 <- pg1 %>%
  select(c(2,4,5,6,10,11,13,14))

#Creating a function for the days remaining graphic
past <- function(date){
  
  ifelse(date > today(),
         "Days Remaining","Past")
  
}

#add text for Brandon Scotts welcome
text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")

#produce basic shell for the site
ui <- fluidPage(
  
  #style
  tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
  tags$style("body {font-family: 'Roboto', sans-serif;}, .small-tracker { height: 100px}"),

  verticalLayout(
    
    # App title
    h1(strong("Mayor Brandon Scott's 100 Days of Action")),
    
    # Welcome comment from Mayor Scott
    div(
      column(4,style='padding:0px;',p(text1)),
      # Overview progress and day trackers
      column(8,style='padding:0px;',div(class="small-tracker", plotOutput("plot1", height="100px")),
      div(class="small-tracker", plotOutput("plot2", height="100px")))
    ),
    
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel("Priorities & Progress", dataTableOutput('table')),
      tabPanel("Weekly Updates", "This tab is still under development."),
      tabPanel("Resources & Feedback", "This tab is still under development.")
    ),
    
    HTML("<p>Send us your feedback on this page through <a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</p>")
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
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=c(iteam_green, iteam_red_light9))
    
  }, height = "auto")
    
  output$plot2 <- renderPlot({
    pg2 %>%
      select(c(1:3)) %>%
      mutate(Days = sapply(pg2$Date,past),
             Total = 1) %>%
      ggplot(aes(fill = Days, x = "", y = Total)) +
      geom_bar(position = "fill", 
               stat = "identity",
               width = .5) +
      coord_flip() +
      theme(legend.position = "bottom",
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=c(iteam_red_light9, iteam_green))
    
  }, height = "auto")
  
  output$dis <- renderDataTable({})
  
}

#action tracker to test layout outside of Shiny app
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
        axis.text.x = element_blank(),
        panel.background = element_blank()
  ) +
  scale_fill_manual(values=c(iteam_green, iteam_red))


pg2 %>%
  select(c(1:3)) %>%
  mutate(Days = sapply(pg2$Date,past),
         Total = 1) %>%
  ggplot(aes(fill = Days, x = "", y = Total)) +
  geom_bar(position = "fill", 
           stat = "identity",
           width = .5) +
  coord_flip() +
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.x = element_blank(),
        panel.background = element_blank()
  ) +
  scale_fill_manual(values=c(iteam_red_light9, iteam_green))


# Run the app
shinyApp(ui = ui, server = server)