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
                  h1 {font-size: 42px;}
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
                  table.dataTable thead th {
                    padding: 8px 10px !important;
                  }
                  #DataTables_Table_0_filter {
                    float: right;
                  }
                  #DataTables_Table_0_filter input {
                    border: 1px solid #ccc;
                    border-radius: 4px;
                  }
                  .fab, .fa {
                   color: black;
                  }
                 ")),

  #-------------------------------
  
  # Header for page
      
  verticalLayout(
    
    div(style="padding-top:8px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
      # img(src = "photos/mayor_brandon_scott.png",
      #            height = headerImgSize, width = headerImgSize),
      # 
      h1(strong("Mayor Brandon Scott's"), br(),
         strong("100 Days of Action"), 
         style="font-size:40px;color:black;padding:0px;padding-right:10px;padding-bottom:14px;line-height:1.1;margin-bottom:-18px;"),
      
      img(src = "photos/mayor_scott_logo.png",
          style="padding-bottom:-40px;margin-bottom:0px;",
          height = headerImgSize, width = headerImgSize),
    ),

    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
    
  #--------------------------------------
  
  # Second level content
    
    # Welcome comment from Mayor Scott
    div(style="display:flex;flex-direction:row;flex-wrap:wrap;",
      div(style='padding:0px;max-width:680px;',text1),
      # Overview progress and day trackers
      div(style='padding:0px;width:400px;',
          div(class="small-tracker", plotOutput("plotTimeline", height="90px")),
          div(class="small-tracker", plotOutput("plotProgress", height="90px")))
    ),
    
  # hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
  
  #--------------------------------------
  
  # Third Level Content
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;","Priorities & Progress"), 
               text2, 
               dataTableOutput('tbPriorities'), 
               downloadButton(style="margin-top:20px;","downloadActions", "Download this data (csv)")),
      tabPanel(h4(style="color:black;","Weekly Updates"), text3, dataTableOutput('tbUpdates')),
      tabPanel(h4(style="color:black;","About this Initiative"), aboutus),
      tabPanel(h4(style="color:black;","Resources & Feedback"), text4,links,survey,hidden1,hidden2#,downloader
               )
      ),
  
  #--------------------------------------
  
  # Page Bottom
  hr(),
    div(style="display: flex; flex-direction:row;justify-content: space-between;",
    HTML("<h4 style=\"align-self:flex-end;\">Send us your feedback on this page through ",
         "<a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</h4>"),
    h4(
         a(href='https://twitter.com/MayorBMScott', icon("twitter-square")), "  ",
         a(href='https://www.facebook.com/MayorBMScott',icon("facebook-square")), "  ",
         a(href='https://www.instagram.com/MayorBMScott/',icon("instagram-square")), "  ",
         a(href='https://www.youtube.com/channel/UCasQyO1K4yMq3Hi_0RQ0jfA',icon("youtube-square")), "  ",
         a(href='https://mayor.baltimorecity.gov/connect',icon("envelope-square")), "  ",
         a(href='https://mayor.baltimorecity.gov/subscribe/MDBALT_25',icon("rss-square")))),
  hr()
  )
)

