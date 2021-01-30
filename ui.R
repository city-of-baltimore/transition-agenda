#produce basic shell for the site

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
      
      #style
      tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
      tags$style(paste0("* {font-family: 'Roboto', sans-serif; padding: 0px; margin: 0px;
                    }
                  h1 {font-size: 42px;}
                  p {
                    font-size: 18px; 
                    line-height:1.3em;
                    color:black;
                    max-width:680px;
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
                  }
                 ")),

  #-------------------------------
   
  # Baltimore City Header
   
  verticalLayout(
     
    HTML('
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&display=swap" rel="stylesheet">

    <style type="text/css">
    .top-nav-bar {
      background: #42484f;
      width: 100%;
      text-align: center;
      margin: 0px;
      padding: 0px;
    }

    ul.menu {
      height: 57px;
      line-height: 57px;
      padding: 0
    }
    
    ul.menu li {
      margin: 0;
      padding: 0;
      display: inline-block;
    }
    
    ul.menu li a {
      color: #fff;
      font-family: \'Open Sans\',sans-serif;
      font-size: 14px;
      font-weight: normal;
      padding: 0 19px;
      border-top: 3px solid transparent;
      background: transparent;
      height: 57px;
      line-height: 57px;
      text-transform: none;
      display: inline-block;
      text-decoration: none;
      z-index:100;
    }
    
    ul.menu li.active a {
      border-top-color: rgb(222, 182, 75);
    }
    
    ul.menu li.home a{ 
      background: url(http://www.baltimorecity.gov/sites/all/themes/custom/flight_city/images/smugmug/logo.png)  0 0 no-repeat;
      text-indent: -1000em;
      width: 47px
    }
    
    .footer {
      background-color: rgb(36, 40, 44);
    }
    
    .footer-bottom {
      background-color: #1A1C20;
      font-size: 10px;
    }
    
    .footer-inner {
      padding: 20px;
    }
    
    .footer .footer-inner p {
      font-family: \'Open Sans\',sans-serif !important;
      font-size: 1em;
    }
    
    .footer-inner h2 {
      font-family: \'Open Sans\',sans-serif !important;
      font-size: 1.6em;
      font-weight: 400;
    }
    
    .copyright p {
      color: #fff;
      font-family: \'Open Sans\',sans-serif;
      font-size: .8rem;
      font-weight: 400;
      line-height: 1.6;
      opacity: 0.5;  
    }
    
    .footer-inner .right {
      float: right;
    }
    
    .footer-inner .right p,
    .footer h2 {
      margin-bottom: 20px;
    }
    
    .footer h2,
    .footer a,
    .footer-bottom a{
      color: rgb(140, 235, 255) !important;
      font-family: \'Open Sans\',sans-serif;
    }
    
    .footer p {
      color: #fff;
      margin-bottom: 20px
      font-family: \'Open Sans\',sans-serif;
    }
    
    .footer strong {
      font-weight: bold;
      color: #fcac31;
    }
    </style>
    
    
    <div class="top-nav-bar">
      <ul class="menu">
        
    <li class="home"><a href="http://www.baltimorecity.gov">Home</a></li>
    
    <li class="first leaf menu-mlid-1228"><a href="https://cityservices.baltimorecity.gov/paysys/" title="Pay your water, license and other bills online or in person">Online Payments</a></li>
    <li class="leaf menu-mlid-1229"><a href="http://www.baltimorecity.gov/answers" title="">How Do I?</a></li>
    <li class="leaf menu-mlid-1230"><a href="http://www.baltimorecity.gov/311-services" title="">311 Services</a></li>
    <li class="leaf menu-mlid-1231"><a href="http://www.baltimorecity.gov/government" title="">Government</a></li>
    <li class="leaf menu-mlid-1232"><a href="http://www.baltimorecity.gov/events" title="">Events</a></li>
    <li class="leaf menu-mlid-845 active"><a href="http://mayor.baltimorecity.gov" title="">Office of the Mayor</a></li>
    <li class="last leaf menu-mlid-2357"><a href="http://www.baltimorecity.gov/connect" title="Connect with all city entities and programs on social media">Connect</a></li>
    </ul></div>
    '
     ),
     
     
     
  #-------------------------------
     
    # Header for page
  
    div(style="margin-top:0px;padding-top:0px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
         
      h1(strong(title), 
        style="font-size:42px;color:black;padding:0px;padding-right:16px;padding-bottom:14px;line-height:1.1;margin-bottom:-20px;"),
         
        img(src = "photos/CITY-LOGO.png",
          style="padding-bottom:-40px;margin-top:16px;margin-bottom:0px;",
          height = headerImgSize, width = headerImgSize),
    ),
     
    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 3px solid", bc_gold, ";")),
  
  #--------------------------------------
  
  # Second level content
    
    # Welcome comment from Mayor Scott
    div(column(6,style='padding:0px;',text1)
       # ,column(6,lang, align = 'right')
       ),
    # Overview progress and day trackers
    div(style='padding:0px;max-width:680px;',
      div(p(style="max-width:680px;font-weight:600;", timelineText)),
      div(style='margin-left:-4px;margin-right:-4px;margin-bottom:16px;', class="small-tracker", 
          plotOutput("plotTimeline", width="100%", height="72px")),
      div(p(style="max-width:680px;font-weight:600;", progressText)),
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
               downloadButton(style="margin-top:40px;","downloadActions", HTML("<p>Download this data (csv)</p>"))),
#      tabPanel(h4(style="color:black;","Weekly Updates"), 
#               text3, 
#               div(column(8,dataTableOutput('tbUpdates')),
#                   column(3,offset = 1,img(src = "photos/citistat.jpg",
#                                height = 4096*.1, width = 3072*.1),
#                          h5("Mayor Scott at his first PoliceStat meeting as Mayor. 12/22/2020",width = 3072*.09)))),
      tabPanel(h4(style="color:black;",i18n$t("About this Initiative")), aboutus),
      tabPanel(h4(style="color:black;",i18n$t("Resources & Feedback")), 
               text4,links,survey,hidden1,hidden2#,downloader
               )
      ),
  
  #--------------------------------------
  
  # Page Bottom
  h4(),
  hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", bc_gold, ";")),
    div(style="display: flex; flex-direction:row;justify-content: space-between;",
        tags$i(h4("Designed by the ",a(href = 'https://www.baltopi.com/',"Mayor's Office of Performance & Innovation"))),
        h2(
         a(href='https://twitter.com/MayorBMScott', icon("twitter-square")), "  ",
         a(href='https://www.facebook.com/MayorBMScott',icon("facebook-square")), "  ",
         a(href='https://www.instagram.com/MayorBMScott/',icon("instagram-square")), "  ",
         a(href='https://www.youtube.com/channel/UCasQyO1K4yMq3Hi_0RQ0jfA',icon("youtube-square")), "  ",
         a(href='https://mayor.baltimorecity.gov/connect',icon("envelope-square")), "  ",
         a(href='https://mayor.baltimorecity.gov/subscribe/MDBALT_25',icon("rss-square")))),
  h2()
  )
)
    }
