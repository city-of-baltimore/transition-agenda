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
    
    hr(style="margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid black;"),
    
    # Welcome comment from Mayor Scott
    div(
      column(6,style='padding:0px;',p(text1)),
      # Overview progress and day trackers
      column(6,style='padding:0px;',div(class="small-tracker", plotOutput("plot1", height="60px")),
      div(class="small-tracker", plotOutput("plot2", height="60px")))
    ),
    
    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid  ",bc_gold,";")),
    
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;","Priorities & Progress"), dataTableOutput('tbPriorities')),
      tabPanel(h4(style="color:black;","Weekly Updates"), dataTableOutput('tbUpdates')),
      tabPanel(h4(style="color:black;","Resources & Feedback"), "This tab is still under development.")
    ),
    
    HTML("<h4>Send us your feedback on this page through ",
         "<a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</h4>")
  )
)

