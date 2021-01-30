# Produce basic shell for the site

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(DT)
  library(shinyjs)
  library(shiny.i18n)

  #-------------------------------
  
  # Basic Layout
      
  ui <- function(req){
    fluidPage(
    shinyjs::useShinyjs(),
 #   shiny.i18n::usei18n(i18n),
  #  tags$div(
  #    style='float: right;',
  #    selectInput(
  #      inputId='selected_language',
  #      label=i18n$t('Change language'),
  #      choices = i18n$get_languages(),
  #      selected = i18n$get_key_translation()
  #    )),
    
  # Style
  tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
  tags$style(paste0("
    * {
      font-family: 'Roboto', sans-serif; padding: 0px; margin: 0px;
    }
    .col-sm-12 {
      padding: 0px;
    }
    .tracker-container {
      max-width: 800px;
      margin: auto;
      padding-left: 24px;
      padding-right:24px;
    }
    h1 {
      font-size: 42px;
    }
    p {
      font-size: 18px; 
      line-height:1.3em;
      color:black;
    }
    .tab-header {margin-top:1em; margin-bottom: 1em;}
    table.dataTable tr.selected td, table.dataTable td.selected, table.dataTable tr.selected {background-color: white !important;}
    table thead.selected td {background-color: white !important;}
    table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {background-color: white !important;}
    .tabbable {
      margin-top: 24px;
    }
    .tabbable h4 {
      font-size: 22px;
    }
    ul.nav-tabs {
      border-bottom: 1px solid ",bc_gold,";
    }
    .nav-tabs li a {
      padding: 0px 12px 0px 12px;
    }
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
     .priorities-hierarchy-2 div {
     margin-right: 6px;
    }"
  )),

  #-------------------------------
   
  # Begin vertical R Shiny layout, add Baltimore City Header
   
  verticalLayout(
    headerBaltimoreCity,
     
  #-------------------------------
  
    # Div for 'tracker' content
    div(class="tracker-container",
     
  #-------------------------------
     
    # Header for page
  
    div(style="margin-top:0px;padding-top:0px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
      h1(strong(title), 
        style="font-size:42px;color:black;padding:0px;padding-right:16px;padding-bottom:14px;line-height:1.1;margin-bottom:-20px;"
      )
    ),
     
    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 3px solid", bc_gold, ";")),
  
  #-------------------------------
  
  # Second level content
    # Welcome comment from Mayor Scott
    div(style='display:flex;flex-direction:row;margin-bottom:12px;margin-top:18px;',
      img(src = "photos/mayor_brandon_scott.png",
        style="margin-left: 2px; margin-top: 4px; margin-right:36px;",
        height = 220),
      text1),
    # Overview progress and day trackers
    div(style='padding:0px;max-width:900px;',
      div(p(style="max-width:900px;font-weight:600;", timelineText)),
      div(style='margin-left:-4px;margin-right:-4px;margin-bottom:16px;', class="small-tracker", 
          plotOutput("plotTimeline", width="100%", height="72px")),
      div(p(style="max-width:900px;font-weight:600;", progressText)),
      div(style='margin-left:-4px;margin-right:-4px;', class="small-tracker", 
          plotOutput("plotProgress", width="100%", height="72px"))
    ),
    
  #--------------------------------------
  
  # Third Level Content
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;",i18n$t("Priorities & Progress")), 
               text2, 
               dataTableOutput("tbPriorities"), 
               downloadButton(style="border:none;padding-left:0px;margin:auto;width:100%;margin-top:24px;","downloadActions", HTML("<p>Download this data (csv)</p>"))),
#      tabPanel(h4(style="color:black;","Weekly Updates"), 
#               text3, 
#               div(column(8,dataTableOutput('tbUpdates')),
#                   column(3,offset = 1,img(src = "photos/citistat.jpg",
#                                height = 4096*.1, width = 3072*.1),
#                          h5("Mayor Scott at his first PoliceStat meeting as Mayor. 12/22/2020",width = 3072*.09)))),
      tabPanel(h4(style="color:black;",i18n$t("About this Initiative")), aboutus),
      tabPanel(h4(style="color:black;",i18n$t("Resources & Feedback")), 
               text4,links,
               HTML('<iframe src="https://docs.google.com/forms/d/e/1FAIpQLScjKePIaoUjUeI1-2Q9vvINtFdFl9ZGivr19BP6M9Hd6kdyhg/viewform?embedded=true" width="100%" height="360px" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>')
               )
      ),
  
  #--------------------------------------
  
  # Page Bottom
  h4(),
  hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
  div(style="display: flex; flex-direction:row;justify-content: space-between;",
    tags$i(h4("Designed by the ",a(href = 'https://www.baltopi.com/',"Mayor's Office of Performance & Innovation"))),
    h4(style="font-size:20px;",
     a(style="padding-left:1px;", href='https://twitter.com/MayorBMScott', icon("twitter")), "  ",
     a(style="padding-left:1px;", href='https://www.facebook.com/MayorBMScott',icon("facebook-square")), "  ",
     a(style="padding-left:1px;", href='https://www.instagram.com/MayorBMScott/',icon("instagram-square")), "  ",
     a(style="padding-left:1px;", href='https://www.youtube.com/channel/UCasQyO1K4yMq3Hi_0RQ0jfA',icon("youtube-square")), "  ",
     a(style="padding-left:1px;", href='https://mayor.baltimorecity.gov/connect',icon("envelope-square")), "  ",
     a(style="padding-left:1px;", href='https://mayor.baltimorecity.gov/subscribe/MDBALT_25',icon("rss-square")))),
  h2()

  #-------------------------------

  # Close div for 'tracker' content
  ),

  #-------------------------------

  # Add Baltimore City footer
  footerBaltimoreCity
    
  #-------------------------------
  ) ) }
