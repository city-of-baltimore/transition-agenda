#install and load relevant packages
pacman::p_load(ggplot2, gfonts, googlesheets4, 
               formattable, shiny, tidyverse,
               lubridate, readxl, DT)

# setwd("C:/Users/brend/OneDrive/Documents/GitHub/transition-agenda")

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

#Create icons for priority areas
health <- icon("ambulance")
business <- icon("store-alt")
finance <- icon("money-check-alt")
education <- icon("chalkboard-teacher")
neighborhood <- icon("building")
transportation <- icon("bus")
human_services <- icon("hospital-user")
governance <- icon("landmark")
sustainability <- icon("leaf")
arts <- icon("palette")

#Create icons for the app layout
see_more <- icon("chevron-down")
contact_us <- icon("envelope")
download <- icon("file-download")
cogs <- icon("cogs")
tools <- icon("tools")

#set up google sheets access
pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 1)
pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 2)
pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 3)
pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 4)

tbCommittees <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees") %>% 
  rename("Priority Area" = Name)

#Create table for manipulation later
tbPriorities <- pg1 %>%
  select(c(2,4,5,6,10,11,13,14))

tbUpdates <- pg4

ggpalatte <- cbind(
  c(iteam_red_light5,iteam_red_light9,iteam_green),
    c("Not Yet Started","In Progress","Complete")
)

#Creating a function for the days remaining graphic
past <- function(date){
  
  ifelse(date > today(),
         "Days Remaining","Past")
  
}

#add text for Brandon Scotts welcome
text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")

#size for header images
headerImgSize <- 90

#produce basic shell for the site
ui <- fluidPage(
  
  #style
  tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
  tags$style("* {font-family: 'Roboto', sans-serif;}"),

  verticalLayout(
    
    div(style="padding-top:8px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
      img(src = "photos/mayor_brandon_scott.png",
                 height = headerImgSize, width = headerImgSize),
      
      h1(strong("Mayor Brandon Scott's 100 Days of Action"), 
         style="color:black;max-width:420px;text-align:center;padding:10px;line-height:1;margin-bottom:-16px;"),
      
      img(src = "photos/CITY-LOGO.png",
          height = headerImgSize, width = headerImgSize),
    ),
    
<<<<<<< HEAD
    div(HTML('<hr style="color: bc_gold;">')),
=======
    hr(style="margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid black;"),
>>>>>>> 67224cdb6be93a4298e2e9e1f521ef0e2f2c72ab
    
    # Welcome comment from Mayor Scott
    div(
      column(5,style='padding:0px;',p(text1)),
      # Overview progress and day trackers
      column(5, offset = 2,style='padding:0px;',div(class="small-tracker", plotOutput("plot1", height="100px")),
      div(class="small-tracker", plotOutput("plot2", height="100px")))
    ),
    
    div(HTML('<hr style="color: bc_gold;">')),
    
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h3("Priorities & Progress"), dataTableOutput('tbPriorities')),
      tabPanel(h3("Weekly Updates"), dataTableOutput('tbUpdates')),
      tabPanel(h3("Resources & Feedback"), DT::dataTableOutput("mytable"))
    ),
    
    HTML("<h3>Send us your feedback on this page through ",
         "<a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</h3>")
  )
)



server <- function(input, output){
  
  output$mytable = DT::renderDataTable({
    DT::datatable(
      cbind(tbCommittees, "Progress" = "N/A", 'Expand' = '+'),
      options = list(
        columnDefs = list(
          list(visible = FALSE, targets = c(0, 1, 3, 4, 5)),
          list(orderable = FALSE, className = 'details-control', targets = 7)
        )
      ),
      callback = JS("
        table.column(3).nodes().to$().css({cursor: 'pointer'});
        var format = function(d) {
          return '<div style=\"padding: .5em;\"> Model: ' +
                  d[0] + ', mpg: ' + d[2] + ', cyl: ' + d[3] + '</div>';
        };
        table.on('click', 'td.details-control', function() {
          var td = $(this), row = table.row(td.closest('tr'));
          if (row.child.isShown()) {
            row.child.hide();
            td.html('+');
          } else {
            row.child(format(row.data())).show();
            td.html('−');
          }
        });"
      ))
  })
  
  #Load the table output 
  output$tbPriorities <- renderDataTable(
    tbPriorities %>% select(Committee, Action), 
    options=list(pageLength=10))
  
  output$tbUpdates <- renderDataTable(tbUpdates, 
    options=list(pageLength=10))
  
  #Load the progress tracker output
  output$plot1 <- renderPlot({
    tbPriorities %>%
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
      scale_fill_manual(values=ggpalatte)
    
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


# Run the app
shinyApp(ui = ui, server = server)

