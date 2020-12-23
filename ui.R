#produce basic shell for the site

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(DT)
  library(shinyjs)

  #-------------------------------
  
  # Basic Layout
      
    ui <- fluidPage(
      shinyjs::useShinyjs(),
      
      #style
      tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
      tags$style(paste0("* {font-family: 'Roboto', sans-serif; padding: 0px; margin: 0px;
                    }
                  h1 {font-size: 46px;}
                  h5 {font-size: 16px; font-weight: 500; line-height: 1.35em; margin: 0px; margin-bottom: 0.5em;}
                  p {font-size: 14px; line-height:1.3em;}
                  .tab-header {margin-top:1em; margin-bottom: 1em;}
                  table.dataTable tr.selected td, table.dataTable td.selected, table.dataTable tr.selected {background-color: white !important;}
                  table thead.selected td {background-color: white !important;}
                  table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {background-color: white !important;}
                  ul.nav-tabs {border-bottom: 1px solid ",bc_gold,";}
                  .nav-tabs li.active a, .nav-tabs li.active a:focus, .nav-tabs li.active a:hover {
                    border: 1px solid ",bc_gold,";
                    border-bottom: 1px solid white;
                  }
                 ")),

  #-------------------------------
  
  # Header for page
      
  verticalLayout(
    
    div(style="padding-top:8px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
      img(src = "photos/mayor_brandon_scott.png",
                 height = headerImgSize, width = headerImgSize),
      
      h1(strong("Mayor Brandon Scott's 100 Days of Action"), 
         style="font-size:42px;color:black;max-width:460px;text-align:center;padding:10px;line-height:1.05;margin-bottom:-18px;"),
      
      img(src = "photos/CITY-LOGO.png",
          height = headerImgSize, width = headerImgSize),
    ),

    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
    
  #--------------------------------------
  
  # Second level content
    
    # Welcome comment from Mayor Scott
    div(
      column(6,style='padding:0px;',text1),
      # Overview progress and day trackers
      column(5,offset = 1,style='padding:0px;',div(class="small-tracker", plotOutput("plotTimeline", height="60px")),
      div(class="small-tracker", plotOutput("plotProgress", height="60px")))
    ),
    
  # hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
  
  #--------------------------------------
  
  # Third Level Content
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;","Priorities & Progress"), text2, dataTableOutput('tbPriorities')),
      tabPanel(h4(style="color:black;","Weekly Updates"), text3, dataTableOutput('tbUpdates')),
      tabPanel(h4(style="color:black;","About this Initiative"), hr(),aboutus,hr()),
      tabPanel(h4(style="color:black;","Resources & Feedback"), text4,links,survey,hidden1,hidden2)
      ),
  
  #--------------------------------------
  
  # Page Bottom
  hr(),
    HTML("<h5>Send us your feedback on this page through ",
         "<a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</h5>"),
    h2(a(href='https://twitter.com/MayorBMScott',icon("twitter-square")), "  ",
         a(href='https://www.facebook.com/MayorBMScott',icon("facebook-square")), "  ",
         a(href='https://www.instagram.com/MayorBMScott/',icon("instagram-square")), "  ",
         a(href='https://www.youtube.com/channel/UCasQyO1K4yMq3Hi_0RQ0jfA',icon("youtube-square")), "  ",
         a(href='https://mayor.baltimorecity.gov/connect',icon("envelope")), "  ",
         a(href='https://mayor.baltimorecity.gov/subscribe/MDBALT_25',icon("rss-square"))),
    hr()
  )
)

