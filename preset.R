# Produce content and functions for ui and server

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(shinyjs)
  library(DT)
    
  #----------------------------------------

  # Fonts, Colors, and Icons 

    #Set up font
    use_font("roboto", "www/css/roboto.css")
    
    #Set up colors
    iteam_red <- "#f15a29"
    iteam_red_light5 <- "#f8ad94"
    iteam_red_light9 <- "#feefea"
    iteam_yellow <- "#ffc429"
    iteam_yellow_light9 <- "#fff8e9"
    iteam_green <- "#2bb673"
    iteam_purple <- "#893395"
    bc_gold <- "#fdb927"
    bchd_blue <- "#199eb4"
    
    #Create icons for priority areas
    gicon <- function(x) as.character(icon(x))
    safety <- gicon("ambulance")
    finance <- gicon("money-check-alt")
    education <- gicon("chalkboard-teacher")
    health <- gicon("hospital-user")
    governance <- gicon("landmark")
    equity1 <- gicon("hands-helping")
    
    #Create icons for the app layout
    see_more <- gicon("chevron-down")
    contact_us <- gicon("envelope")
    download <- gicon("file-download")
    
    ggpalette1 <- cbind(
      c(bchd_blue,bc_gold,"whiteSmoke"),
      c("Complete","Not Yet Started","In Progress")
    )
    
    ggpalette2 <- cbind(
      c("DimGrey",bc_gold,"whiteSmoke"),
      c("Past","Current","Remaining")
    )

    #------------------------------------
    
    # Create Functions & Definitions
    
    # Creating a function for the days remaining graphic
    past <- function(date) {
     ifelse(date > today(), "Remaining", ifelse(date == today(), "Current","Past"))
    }
    
    # Progress bar unit style
    progressUnitStyle <- "float:left;margin-left:1px;width:14px;height:14px;padding-bottom:0px;margin-top:2px;"
    
    # Function for determining status symbol
    symbolColor <- function(status) {
      return(ifelse(tolower(status) == "in progress", 
        bc_gold,
        ifelse(tolower(status) == "complete",
          bchd_blue,
          "#DCDCDC")))
    }
    
    # Function for returning an HTML div with a color-coded square for status plus status text
    symbol <- function(status) {
      tempDiv <- paste0("<div style=\"", progressUnitStyle,"background-color:", symbolColor(status),"\"></div>")
      return(paste(tempDiv, status))
    }
    
    # Function for creating progress bar for each priority area
    priorityAreaProgressBar <- function(data) {
      tempData <- paste(unlist(paste0(sapply(sapply(sapply(data, "[[", 2), FUN=strsplit, "</div>"), "[[", 1), "</div>")), collapse='')
      return(tempData)
    }
    
    # Add text for Brandon Scott's welcome
    title <- "Mayor Brandon M. Scott: 100 Days of Action Tracker"
    text1 <- div(HTML("<p>In November, Mayor Brandon M. Scott convened more than 250 Baltimoreans to serve on his 
    Mayoral transition team. The youth, community leaders, educators, advocates, artists, entrepreneurs and residents 
    involved in this process developed short-term and long-term recommendations to guide the administration over the 
    next four years and beyond. 
      </p><p>The Mayor and his executive team reviewed these plans and built a coordinated strategy for his first 
                      term, starting with the 100 Days of Action. Follow updates across each of these actions and 
                      track their completion with the tracker below.</p>"))
    text2 <- div(HTML("<p class=\"tab-header\">Follow Mayor Scott's early achievements here! To learn about the 
                      Mayor's transition process and priority areas, visit ",
        "<a href='https://www.brandonsplan.com/transition-team'>this page</a>.</p>"))
    text3 <- div(HTML("
      <p class=\"tab-header\">Every week, our team will share updates from across our government to keep you 
      involved in our work making Baltimore a safer, healthier, and more equitable city. Be sure to check back 
      in to stay updated on our achievements during these hundred days and beyond!</p>
      <p>Since Mayor Scott took office on December 8th, 2020, we've been hard at work improving Baltimore 
      government. Below are a few highlights of Mayor Scott's achievements:</p>
      <ul style=\"margin-left:24px;\">
        <li>Created and staffed the Mayor's Office of Neighborhood Safety and Engagement</li>
        <li>Launched the first PoliceStat meeting to coordinate services and increase accountability</li>
        <li>Hired Baltimore's first Chief Equity Officer</li>
        <li>Hired Baltimore's first Chief Administrative Officer</li>
      </ul>
      <p>We have bold plans to reshape Baltimore's government over the coming months. This work will involve 
      unprecedented transparency, accountability, and urgency as we seek to build a Baltimore where every 
      resident can thrive.</p>
    "))
    text4 <- div(HTML("<p class=\"tab-header\">Thank you for your interest and involvement as we work 
                      together to make Baltimore a safer, equitable and accountable city. Share your 
                      feedback and get involved below.</p>"))
   
    # Add texts and links for the resources page
    link1 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>BaltimoreCity.gov Homepage</a></b>"
                  ," - Stay informed about Baltimore City services and learn how to connect with your 
                  city leaders.</p>")
    link2 <- HTML("<p><b><a href='https://www.balt311.baltimorecity.gov/citizen/servicetypes'>Submit a 
                  Service Request</a></b>"
                  ," - Request any city service over the phone, on the 311 app, or online.</p>")
    link3 <- HTML("<p><b><a href='https://www.mayor.baltimorecity.gov/help'>Get Assistance with a 
                  Constituent-Related Concern</a></b>"
                  ," - Connect directly with the Mayor's Office and follow up on your service requests.</p>")
    link4 <- HTML("<p><b><a href='https://www.baltimorecitycouncil.com'>Baltimore City Council</a></b>"
                 ," - Learn more about the City Council, connect with your local representatives, and 
                 find upcoming meetings.</p>")
    link5 <- HTML("<p><b><a href='https://www.msa.maryland.gov/msa/mdmanual/07leg/html/gacobcit.html'>Baltimore 
                  City State Delegation</a></b>"
                  ," - Connect with Baltimore City's State delegation and follow along with the legislative 
                  process.</p>")
    link6 <- HTML("<p><b><a href='https://www.planning.baltimorecity.gov/maps-data/online-community-association-directory'>Learn 
                  about your Community Association</a></b>"
                 ," - Find out more about your community associations in your area and get involved.</p>")
   
    #create structure for translation buttons
   
    i18n <- Translator$new(translation_csvs_path='data/translations/',
                          translation_csv_config = NULL,
                          separator_csv = ",",
                          automatic = FALSE)
    i18n$set_translation_language('en')
   
#   en <- actionButton("english",HTML("<b>En</b>"),class = "btn-primary")
#   es <- actionButton("english",HTML("<b>Sp</b>"),class = "btn-primary")
#   fr <- actionButton("english",HTML("<b>Fr</b>"),class = "btn-primary")
#   ko <- actionButton("english",HTML("<b>Ko</b>"),class = "btn-primary")
#   ch <- actionButton("english",HTML("<b>Ch</b>"),class = "btn-primary")
#   lang <- div(en,es,fr,ko,ch)
   
    #create structure for links
    links <- div(
      id = "links",
        fluidRow(column(6,link1),
                  column(6,link2),
                 # column(2)
                 ),
        fluidRow(column(6,link3),
                  column(6,link4),
                 # column(2)
                 ),
        fluidRow(column(6,link5),
                  column(6,link6),
                 # column(2)
                 ),
      hr()
    )
        
    #size for header images
    headerImgSize <- 50
    
  #-----------------------------

  #Load and format data

    #set up sheets
    pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Actions")
    pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Days")
    pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees")
    pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Progress Updates")
    
    tbDays <- pg2 %>% 
      mutate(Status = factor(sapply(.$Date,past), 
                             levels=c("Past", "Current","Remaining")),
             Total = 1)
    
    tbPriorities <- pg1 %>%
      mutate(Progress = factor(Progress, levels=c("Complete", "In Progress", "Not Yet Started"))) %>% 
      arrange(Committee, Progress) %>%
      mutate(.,"Icon" = with(.,case_when(
                           (Committee == "Building Public Safety") ~ safety,
                           (Committee == "Making Baltimore Equitable") ~ equity1,
                           (Committee == "Prioritizing Our Youth") ~ education,
                           (Committee == "Building Public Trust") ~ governance,
                           (Committee == "COVID-19 Recovery") ~ health,
                           T ~ as.character(finance)
                                  )))
    
    tbActionsNested <- tbPriorities %>% 
      mutate(ActionProgressParties = mapply(c, Action, 
                                            symbol(Progress),
                                            `Parties Responsible`, 
                                            SIMPLIFY = F)) %>% 
      select(c("Committee", "ActionProgressParties")) %>% 
      group_by(Committee) %>%
      summarise(ActionProgressParties = list(unique(ActionProgressParties))) 
    
    
    actionsTotal <- nrow(tbPriorities)
    actionsComplete <- nrow(tbPriorities[ which(tbPriorities$Progress == "Complete"),])
    actionsInProgress <- nrow(tbPriorities[ which(tbPriorities$Progress == "In Progress"),])
    actionsRemaining <- actionsTotal - actionsComplete - actionsInProgress
    
    tbCommittees <- pg3 %>% 
      rename("Priority Area" = Name) %>% 
      left_join(tbActionsNested, by = c("Priority Area" = "Committee")) %>%
      mutate(.,"Icon" = with(.,case_when(
        (`Priority Area` == "Building Public Safety") ~ safety,
        (`Priority Area` == "Making Baltimore Equitable") ~ equity1,
        (`Priority Area` == "Prioritizing Our Youth") ~ education,
        (`Priority Area` == "Building Public Trust") ~ governance,
        (`Priority Area` == "COVID-19 Recovery") ~ health,
        T ~ as.character(finance)
      ))) %>% 
      mutate(Progress = lapply(ActionProgressParties, FUN=priorityAreaProgressBar))
    
    tbCommittees <- tbCommittees %>% 
      select(-c(grep(pattern="_", x=colnames(tbCommittees)))) %>% 
      select(Icon, everything())
    
    tbUpdates <- pg4 %>%
      mutate(`Date of Update` = ymd(`Date of Update`))

    #------------------------------------
    
    # Dynamic titles for timeline and progress bars
    
    # Text for timeline vis title. Note this text will treat the first day in 
    # the tbDays dataframe as the first day of the 100 Days of Action. If the 
    # first day is changed, the source data should be filtered to exclude days 
    # preceeding the first day.
    timelineText <- paste0("The 100 Days of Action began on 12/8/20. Today is Day ",
                           ifelse(which(tbDays$Date == Sys.Date())<=100, 
                                  which(tbDays$Date == Sys.Date()),
                                  paste0("It ended on ", 
                                         gsub("/0", "/", strftime(tbDays$Date[100], "%m/%d/%y")))), ".")
    
    progressText <- paste0("There are ", actionsTotal, " actions planned in total. ",
                           actionsComplete, " are complete, and ", actionsInProgress, " are in progress.")
    
  #--------------------------------
    
    # Create "about this initiative" page
    
    aboutus <- {div(
      div(style="float:right;margin-top:8px;margin-left:48px;margin-bottom:24px;",
        img(src = "photos/citistat.jpg",
            height = 4096*.1,
            width = 3072*.1),
        h5("Mayor Scott leading 12/18/20 PoliceStat meeting.", height = 150)
      ),
      h3("Baltimore,"),
      p("Over the past few months, my team and I have been working hard to build a new foundation for our local 
        government in Baltimore City.  This work will not be easy, particularly as we continue to navigate the 
        devastating public health and economic consequences of the COVID-19 pandemic, something that layers on 
        Baltimore's existing inequities and unrelenting violence epidemic."),
      p("In November, I convened more than 250 Baltimoreans to serve on my transition team. The youth, community 
        leaders, educators, advocates, artists, entrepreneurs and residents who were involved in this process 
        developed short-term and long-term recommendations to guide my administration over the next four years 
        and beyond."),
      p("Together, we built a vision for a new way forward for Baltimore, taking ideas from every corner of this 
        city and combining them with best practices other places have used to transform and grow equitably."),
      p("In my conversations with my transition team, I knew we needed to show progress over time, not just tell 
        people what we accomplished when it was done. My team and I assembled a list of actions we could 
        accomplish over the next 100 days so residents could see transformation in their City government 
        immediately. "),
      p("This 100 Days of Action Tracker emerged from this sense of urgency and from my belief that we're 
        at our best when we set high goals and are accountable to the people we serve. To put our city on 
        a new path, this administration will need to operate with greater urgency, transparency, accountability, 
        and commitment to equity than ever before."),
      p("Please use this tool to learn more, ask tough questions, and hold us to our promises. Each week, my team 
        will share updates, so be sure to check in on our progress. Thank you for your engagement in this work."),
      br(),
      p("In service,"),
      img(src = "photos/signature.PNG",
         style="margin-left:-8px;",
         height = 176/4, width = 717/4),
      tags$b(p("Brandon Scott")),
      p("Mayor of Baltimore City"),
      hr(style="border-color: white;")
    )}
