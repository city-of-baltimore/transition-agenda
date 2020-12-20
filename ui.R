#produce basic shell for the site

  #-------------------------------
  
  # Basic Layout
      
    ui <- fluidPage(
      shinyjs::useShinyjs(),
      
      #style
      tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
      tags$style("* {font-family: 'Roboto', sans-serif;}"),

  #-------------------------------
  
  # Header for page
      
  verticalLayout(
    
    div(style="padding-top:8px;display:flex;flex-direction:row;justify-content:space-between;align-items:flex-end;",
      img(src = "photos/mayor_brandon_scott.png",
                 height = headerImgSize, width = headerImgSize),
      
      h1(strong("Mayor Brandon Scott's 100 Days of Action"), 
         style="color:black;max-width:820px;text-align:center;padding:10px;line-height:1;margin-bottom:-16px;"),
      
      img(src = "photos/CITY-LOGO.png",
          height = headerImgSize, width = headerImgSize),
    ),

    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid  black;")),
    
  #--------------------------------------
  
  # Second level content
    
    # Welcome comment from Mayor Scott
    div(
      column(6,style='padding:0px;',p(text1)),
      # Overview progress and day trackers
      column(6,style='padding:0px;',div(class="small-tracker", plotOutput("plotTimeline", height="60px")),
      div(class="small-tracker", plotOutput("plotProgress", height="60px")))
    ),
    
    hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid  black;")),
    
  #--------------------------------------
  
  # Third Level Content
    # Tab setup for tracker "pages"
    tabsetPanel(type="tabs",
      tabPanel(h4(style="color:black;","Priorities & Progress"), dataTableOutput('tbPriorities')),
      tabPanel(h4(style="color:black;","Weekly Updates"), dataTableOutput('tbUpdates')),
      tabPanel(h4(style="color:black;","About this Initiative"), "In Development"),
      tabPanel(h4(style="color:black;","Resources & Feedback"), survey,hidden1,hidden2)
      tabPanel(h4(style="color:black;","Priorities & Progress"), text2, dataTableOutput('tbPriorities')),
      tabPanel(h4(style="color:black;","Weekly Updates"), text3, dataTableOutput('tbUpdates')),
      tabPanel(h4(style="color:black;","About this Initiative"), hr(),"In Development",hr()),
      tabPanel(h4(style="color:black;","Resources & Feedback"), text4,links,survey,hidden1,hidden2)
      ),
  
  #--------------------------------------
  
  # Page Bottom
  
    HTML("<h4>Send us your feedback on this page through ",
         "<a href='https://forms.gle/U3JmaEoS27CrtYWF9'>this form</a>.</h4>")
  )
)

