#produce content and functions for ui and server

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
    business <- gicon("store-alt")
    finance <- gicon("money-check-alt")
    education <- gicon("chalkboard-teacher")
    neighborhood <- gicon("building")
    transportation <- gicon("bus")
    health <- gicon("hospital-user")
    governance <- gicon("landmark")
    equity1 <- gicon("hands-helping")
    equity2 <- gicon("hand-holding-heart")
    equity3 <- gicon("balance-scale")
    

    #Create icons for the app layout
    see_more <- gicon("chevron-down")
    contact_us <- gicon("envelope")
    download <- gicon("file-download")
    cogs <- gicon("cogs")
    tools <- gicon("tools")
    
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
    
    #Creating a function for the days remaining graphic
    past <- function(date){
     ifelse(date > today(),
            "Remaining",
            ifelse(date == today(),
                   "Current","Past"))
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
    
    symbol <- function(status) {
      tempDiv <- paste0("<div style=\"margin-right:6px;", progressUnitStyle,"background-color:", symbolColor(status),"\"></div>")
      return(paste(tempDiv, status))
    }
    
    # Function for creating progress bar for each priority area
    priorityAreaProgressBar <- function(data) {
      # return(sapply(sapply(lapply(data, "[[", 2), FUN=strsplit, " "), "[[", 1))
      return(paste(unlist(paste0(sapply(sapply(sapply(data, "[[", 2), FUN=strsplit, "</div>"), "[[", 1), "</div>")), collapse=''))
      # customCounts <- function(x) {
      #   x <- unlist(x)
      #   if (length(x) < 1) { 
      #     return("There are no actions listed under this priority area.") 
      #   } else { 
      #     returnString <- ""
      #     for (i in length(x)) {
      #       returnString <- paste0(returnString,gsub("(@).*","\\1",x[i]))
      #     }
      #     return(returnString)
      #   }
      # }
      # data <- lapply(data, "[[", 2)
      # tempCounts <- customCounts(data)
      # return(HTML(sort(unlist(data), decreasing=TRUE), paste0("<br />", tempCounts)))
      # return(returnString)
    }
    
   #add text for Brandon Scotts welcome
    title <- "Mayor Scott's 100 Days of Action"
   # text1 <- div(HTML("<h5>Hello Baltimore! My administration is committed to transparency as we work to provide the services Baltimore residents deserve. I came into this office with both a long-term vision for Baltimore and a clear strategy to make change. I tasked my transition team with building a framework of early-term priorities that will put us on a path to success. </h5> 
   #                   <h5>My administration is your administration. I asked my team to create this 100 Days of Action Tracker so you could hold me accountable to achieve the vision I was elected to deliver. Every week, we will share progress updates across these ten priority areas, so you know what's happening in City Hall. With your help, this is going to be the most open and accountable administration in Baltimore's history.</h5>"))
   text1 <- div(HTML("<p>Draft: As part of his transition process, Mayor Scott assembled a team of advocates, community leaders, and specialists, which developed immediate and long-term strategies for Baltimore's equitable growth. Mayor Scott reviewed these plans and built a coordinated strategy for his first term, starting with this 100 Days of Action.
    Follow updates across each of these actions and track their completion using this tracker.</p>"))
   text2 <- div(HTML("<p class=\"tab-header\">You can follow Mayor Scott's early achievements here! To learn about Mayor Scott's transition committees and priority areas, visit ",
        "<a href='https://www.brandonsplan.com/transition-team'>this webpage</a>.</p>"))
   text3 <- div(HTML("<p class=\"tab-header\">This table displays progress updates, which are submitted weekly, for the actions selected for the 100 Days of Action. You can sort and filter the list of updates by any column by clicking the filter icon on the top right of the column and then choosing options from the popup window.</p>"))
   text4 <- div(HTML("<p class=\"tab-header\">We're excited to have your input and involvement as we work to make Baltimore healthier, safer, and more equitable. Below are a few links of how to get involved and a sign-up sheet to stay in the loop about Mayor Scott's work. We can't wait to get to know you!</p>"))
   
   #Add texts and links for the resources page
   link1 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Mayor's Office Homepage</a></b>"," - Stay informed about Baltimore City services and connect with your city leaders.</p>")
   link2 <- HTML("<p><b><a href='https://balt311.baltimorecity.gov/citizen/servicetypes'>Submit a Service Request</a></b>"," - Request any city service over the phone, on the 311 app, or online.</p>")
   link3 <- HTML("<p><b><a href='https://www.baltimorecitycouncil.com/'>City Council Homepage</a></b>"," - Learn more about the City Council, connect with your representatives, and follow their calendar.</p>")
   link4 <- HTML("<p><b><a href='https://mayor.baltimorecity.gov/help'>Connect with Constituent Services</a></b>"," - Connect directly with the Mayor's Office and follow up on your service requests.</p>")
   link5 <- HTML("<p><b><a href='https://msa.maryland.gov/msa/mdmanual/07leg/html/gacobcit.html'>Baltimore City State Delegation Homepage</a></b>"," - Connect with Baltimore's state legislators and follow  legislation.</p>")
   link6 <- HTML("<p><b><a href='https://planning.baltimorecity.gov/maps-data/online-community-association-directory'>Learn about your Community Association</a></b>"," - Find out more about your Community Association and get involved!</p>")
   
   #set link format
   linkrowlength <- 6
   offsetlength <- 12-2*linkrowlength
   
   #create structure for links
   links <- div(
     id = "links",
         fluidRow(column(linkrowlength,link1),
                  column(linkrowlength,offset = offsetlength,link2)),
         fluidRow(column(linkrowlength,link3),
                  column(linkrowlength,offset = offsetlength,link4)),
         fluidRow(column(linkrowlength,link5),
                  column(linkrowlength,offset = offsetlength,link6)),
     hr()
   )
        
   #size for header images
   headerImgSize <- 40
    
  #-----------------------------

  #Load and format data

    #set up sheets
    pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 1)
    pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 2)
    pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 3)
    pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 4)
    
    tbDays <- pg2 %>% 
      mutate(Status = factor(sapply(.$Date,past), 
                             levels=c("Past", "Current","Remaining")),
             Total = 1)
    
    tbPriorities <- read_excel("data/100 Day Tracker Data.xlsx", sheet="Actions") %>%
      mutate(.," " = with(.,case_when(
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
    actionsComplete <- sum(tolower(tbPriorities$Progress) == "complete")
    actionsInProgress <- sum(tolower(tbPriorities$Progress) == "in progress")
    actionsRemaining <- actionsTotal - actionsComplete - actionsInProgress
    
    tbCommittees <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees") %>% 
      rename("Priority Area" = Name) %>% 
      left_join(tbActionsNested, by = c("Priority Area" = "Committee")) %>%
      select(-c(4,5)) %>%
      mutate(.," " = with(.,case_when(
        (`Priority Area` == "Building Public Safety") ~ safety,
        (`Priority Area` == "Making Baltimore Equitable") ~ equity1,
        (`Priority Area` == "Prioritizing Our Youth") ~ education,
        (`Priority Area` == "Building Public Trust") ~ governance,
        (`Priority Area` == "COVID-19 Recovery") ~ health,
        T ~ as.character(finance)
      ))) %>%
      select(1,5,2,3,4) %>% 
      mutate(Progress = lapply(ActionProgressParties, FUN=priorityAreaProgressBar))
    
    tbUpdates <- pg4 %>%
      mutate(.," " = with(.,case_when(
        (Action == "Building Public Safety") ~ safety,
        (Action == "Making Baltimore Equitable") ~ equity1,
        (Action == "Prioritizing Our Youth") ~ education,
        (Action == "Building Public Trust") ~ governance,
        (Action == "COVID-19 Recovery") ~ health,
        T ~ as.character(finance)
      ))) %>%
      select(6,1:5)

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
    
    aboutus <- div(hr(),
                   fluidRow(
                  column(7,
                         h3("What we're sharing, and why."),
                         p("Mayor Brandon Scott is building an administration committed to equity and excellence in government.", 
                            "That starts with transparency, so every resident can see what's happening in their city and make their ",
                            "voice heard."),
                         p("A bold vision requires a coalition of experts. As part of his administrative transition process in late 2020, ",
                         "Mayor Brandon Scott assembled a team of advocates, community leaders, and specialists, all with a passion for ",
                         "Baltimore and desire to improve how City government functions. This team met across ten priority areas to develop ",
                         "immediate and long-term strategies for Baltimore's equitable growth. Mayor Scott reviewed these plans and built ",
                         "a coordinated strategy for his first term, starting with this Hundred Days of Action."),
                         p("Over the next hundred days, you can follow weekly updates across each of these actions, track their completion ",
                           "across each priority area, and get involved in Mayor Scott's work to make Baltimore an even better city.")
                         ),
                  column(4,offset = 1, 
                         img(src = "photos/citistat.jpg",
                              height = 4096*.07, width = 3072*.07),
                         h6("Mayor Brandon Scott leading his first CitiStat meeting as Mayor. December 22, 2020"))
                  
    ),
    
    hr(),
    fluidRow(
      column(7,
             h3("About Mayor Brandon Scott"),
             p("Brandon M. Scott is the 52nd Mayor of Baltimore, working to end gun violence, restore the public's trust in government ",
               "and change Baltimore for the better."),
             p("Scott was unanimously elected President of the Baltimore City Council by his colleagues in May 2019. As Council ",
               "President, Scott developed and released the first-ever City Council President legislative agenda, focused on ",
               "building safer, stronger communities, cleaning up city government, investing in Baltimore's young people, and ",
               "centering equity. Previously, Scott served on the City Council representing Baltimore's 2nd District. He was ",
               "first elected in 2011 at the age of 27 and is one of the youngest people ever elected to the Baltimore City Council."),
             p("During his first term, Scott emerged as a leading voice in reducing violence in Baltimore and reinstated Council ",
               "Oversight of the Baltimore Police Department by holding quarterly hearings. He believes that reducing violence will ",
               "require a holistic, all-hands-on-deck approach, one that recognizes violence is fundamentally a public health issue. ",
               "Scott led legislative initiatives that created extensive crime data sharing and online reporting of crimes by the ",
               "Baltimore Police Department. In 2016, Scott introduced and passed legislation creating an open data policy in Baltimore."),
             p("In early 2018, then-Councilman Scott introduced and passed monumental legislation on equity in Baltimore. His ",
               "equity assessment program law will require all city agencies to operate through a lens of equity and require all ",
               "operating budgets, capital budgets and proposed legislation to be weighed through an equity lens. That legislation ",
               "is in the early stages of implementation."),
             p("Mayor Scott is a rising star in politics. He was a member of the Young Elected Officials Network and served as ",
               "the Secretary of Housing and Urban Development for YEO's America's Cabinet. He also served as the Chair of the ",
               "National League of Cities' Large Cities Council."),
             p("Mayor Scott is a community leader, public servant and lifelong resident of Baltimore City. A proud Baltimorean, ",
               "Scott is a graduate of MERVO High School and St. Mary's College of Maryland. He lives in Baltimore's Frankford ",
               "neighborhood in Northeast Baltimore.")
      ),
      column(4,offset = 1, 
             img(src = "photos/mayor_scott_2.png",
                 height = 675*3072*.07/575, width = 3072*.07),
             h6("Mayor Brandon Scott with the Baltimore Harbor in the background."))
))

    

    
