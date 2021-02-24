# Produce basic shell for the site

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(shinyjs)
  library(DT)

  #-------------------------------
  
  # Basic Layout
      
  ui <- function(req){
    fluidPage(
    shinyjs::useShinyjs(),

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
      font-size: 18px;
      font-weight: 600;
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
     
    .goog-te-gadget {
      font-family: Roboto!important;
    }
    .goog-te-gadget-simple  {
      border: 0px solid white !important;
      padding: 0px!important;
      border-radius: 0px!important;
      cursor: pointer;
    }
    .goog-te-menu-value span:nth-child(5) {
      // display:none;
      color: ",bc_gold,"!important;
      font-size: 12px!important;
    }
    .goog-te-menu {
      border: 1px solid ",bc_gold,";
    }
    .goog-te-menu-value span:nth-child(3) {
      display:none;
    }
    .goog-te-menu-value span {
      // float: right;
      text-align:right;
      font-size: 15px!important;
      font-weight: 500!important;
    }
    .goog-te-menu-value {
      margin: 0px;
    }
    .goog-te-gadget-icon {
    display:none;
    }
    .legend {
      margin-left: 1px;
      display:flex;
      flex-direction:row;
      flex-wrap:nowrap;
      justify-content:flex-start;
      align-items:baseline;
      align-content:flex-start;
    }
    .legend p {
      font-size: 14px!important;
      font-weight: 400;
      color: dimGrey!important;
      margin-right: 0.75em;
    }
    .legend div { 
      margin-right: 0.35em;
      width: 11px;
      height: 11px;
    }
    "
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
      ),
      # Google Translate
      HTML('
        <div id="google_translate_element"></div>
        <script>
          function googleTranslateElementInit() {
            new google.translate.TranslateElement({
              pageLanguage: \'en\', 
              includedLanguages: \'en,es,fr,jv,ko,pa,pt,ru,zh-CN,ar\', 
              layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 
              \'google_translate_element\');
          }
        </script>
        <script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
      '
      )
    ),
     
    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 3px solid", bc_gold, ";")),

  #-------------------------------
  
  # Second level content
    # Welcome comment from Mayor Scott
    div(style='margin-bottom:12px;margin-top:18px;',
      img(src = "photos/mayor_brandon_scott.png",
        style="margin-left: 2px; margin-top: 4px; margin-right:24px;margin-bottom:8px;float:left;" ,
        height = 235),
      text1),
    # Overview progress and day trackers 
    div(style='padding:1px;max-width:900px;margin-top:24px;' ,
      div(p(style="max-width:900px;font-weight:600;", textOutput("timelineText", container=span), " ")),
      div(style='margin-left:-4px;margin-right:-4px;margin-bottom:0px;', class="small-tracker", 
        plotOutput("plotTimeline", width="100%", height="48px")),
      htmlOutput("timelineLegend"),
      div(p(style="max-width:900px;font-weight:600;", progressText, " ")),
      div(style='margin-left:-4px;margin-right:-4px;margin-bottom:0px', class="small-tracker", 
        plotOutput("plotProgress", width="100%", height="48px")),
      htmlOutput("progressLegend")
    ),
    
  #--------------------------------------
  
  # Third Level Content
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;","Priorities & Progress"), 
               text2, 
               dataTableOutput("tbPriorities"), 
               downloadButton(style="border:none;padding-left:0px;margin-top:24px;","downloadActions", HTML("<p>Download this data (csv)</p>"))),
      tabPanel(h4(style="color:black;","Updates"),
        HTML(updateText)
      ),
      tabPanel(h4(style="color:black;","Message from the Mayor"), aboutus ),
      tabPanel(h4(style="color:black;","Resources & Feedback"), 
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
