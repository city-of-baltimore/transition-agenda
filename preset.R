# Produce content and functions for ui and server

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(DT)
  library(shinyjs)
    
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
    title <- "Mayor Scott's First 100 Days"
    text1 <- div(HTML("<p>As part of his transition process, Mayor Scott assembled a team of advocates, community leaders, and specialists, which developed immediate and long-term strategies for Baltimore's equitable growth. Mayor Scott built this into a coordinated first-term strategy, starting with the first hundred days.
    Follow updates across each of these actions and track their completion using this tracker.</p>"))
    text2 <- div(HTML("<p class=\"tab-header\">You can follow Mayor Scott's early achievements here! To learn about Mayor Scott's transition committees and priority areas, visit ",
        "<a href='https://www.brandonsplan.com/transition-team'>this webpage</a>.</p>"))
    text3 <- div(HTML("<p class=\"tab-header\">This table displays progress updates, which are submitted weekly.</p>"))
    text4 <- div(HTML("<p class=\"tab-header\">We're excited to have your input and involvement as we work to make Baltimore healthier, safer, and more equitable. Below are a few links of how to get involved and a sign-up sheet to stay in the loop about Mayor Scott's work. We can't wait to get to know you!</p>"))
   
    # Add texts and links for the resources page
    link1 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Mayor's Office Homepage</a></b>"," - Stay informed about Baltimore City services and connect with your city leaders.</p>")
    link2 <- HTML("<p><b><a href='https://balt311.baltimorecity.gov/citizen/servicetypes'>Submit a Service Request</a></b>"," - Request any city service over the phone, on the 311 app, or online.</p>")
    link3 <- HTML("<p><b><a href='https://www.baltimorecitycouncil.com/'>City Council Homepage</a></b>"," - Learn more about the City Council, connect with your representatives, and follow their calendar.</p>")
    link4 <- HTML("<p><b><a href='https://mayor.baltimorecity.gov/help'>Connect with Constituent Services</a></b>"," - Connect directly with the Mayor's Office and follow up on your service requests.</p>")
    link5 <- HTML("<p><b><a href='https://msa.maryland.gov/msa/mdmanual/07leg/html/gacobcit.html'>Baltimore City State Delegation Homepage</a></b>"," - Connect with Baltimore's state legislators and follow  legislation.</p>")
    link6 <- HTML("<p><b><a href='https://planning.baltimorecity.gov/maps-data/online-community-association-directory'>Learn about your Community Association</a></b>"," - Find out more about your Community Association and get involved!</p>")
   
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
        fluidRow(column(4,link1),
                  column(4,link2),
                  column(2)),
        fluidRow(column(4,link3),
                  column(4,link4),
                  column(2)),
        fluidRow(column(4,link5),
                  column(4,link6),
                  column(2)),
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
    
    aboutus <- div(fluidRow(
                  column(6,
                         h3("Baltimore,"),
                         p("I ran for Mayor because Baltimore needs a new way forward. This election made it clear that 
                           Baltimore residents do not want the status quo or a continuation of the failed policies of 
                           the past. The work ahead will not be easy, particularly as we continue to navigate the 
                           devastating public health and economic consequences of the COVID-19 pandemic, something that 
                           layers on Baltimore's existing inequities and unrelenting violence epidemic."),
                         p("To put our city on a new path, I know this administration will need to operate with greater 
                           transparency, accountability and urgency than ever before."),
                         p("I ran for Mayor promising to reform the structure and capabilities of Baltimore's government.
                           So when I was elected, I instructed my transition committees to think big and to think 
                           technical, to get into the weeds of how our government could improve while staying 
                           laser-focused on what matters to Baltimore residents. Together, we built a long-term vision 
                           for this administration, taking ideas from every part of this city and combining them with 
                           the best practices other cities have used to grow equitably."),
                         p("In my conversations with the transition team, I knew we needed to show progress, not just 
                           tell people when we were done. We assembled a list of actions we could accomplish in 100 
                           (very busy) days so residents could see Baltimore City government's transformation 
                           immediately. This 100 Days of Action Tracker emerged from this sense of urgency and from 
                           my belief that we're at our best when we're accountable to the people we serve."),
                         p("Please use this tool to learn more, ask tough questions, and hold us to our promises. 
                           Every week, my team will share updates making Baltimore a stronger, more equitable city, 
                           so be sure to keep checking back in on our progress. Thank you for your engagement in our 
                           work!"),
                         p("In Service,"),
                         img(src = "photos/signature.PNG",
                             height = 176/6,width = 717/6),
                         p("Brandon Scott"),
                         p("Mayor of Baltimore City")),
                  column(6, hr(style="border-color: white;"),
                         img(src = "photos/mayor_brandon_scott.png",
                              height = 413, width = 275),
                         h5("Inaugural Photo of Mayor Brandon M. Scott",width = 275))
                  ))
