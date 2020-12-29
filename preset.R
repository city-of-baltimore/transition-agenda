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
    health <- gicon("ambulance")
    business <- gicon("store-alt")
    finance <- gicon("money-check-alt")
    education <- gicon("chalkboard-teacher")
    neighborhood <- gicon("building")
    transportation <- gicon("bus")
    human_services <- gicon("hospital-user")
    governance <- gicon("landmark")
    sustainability <- gicon("leaf")
    arts <- gicon("palette")
    

    #Create icons for the app layout
    see_more <- gicon("chevron-down")
    contact_us <- gicon("envelope")
    download <- gicon("file-download")
    cogs <- gicon("cogs")
    tools <- gicon("tools")
    
    ggpalette1 <- cbind(
      c(iteam_red_light5,"whiteSmoke",iteam_green),
      c("Not Yet Started","In Progress","Complete")
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
    
    # Function for determining status symbol
    symbol <- function(status) {
      return(ifelse(tolower(status) == "in progress", 
           "&#128260",
           ifelse(tolower(status) == "complete",
                  "&#9989",
                  "&#11036")))
    }
    
    # Function for creating progres bar for each priority area
    
    priorityAreaProgressBar <- function(data) {
      customBar <- function(x) {
          ifelse(x == "&#128260", 
                 color <- iteam_red_light5,
                 ifelse(x == "&#9989",
                   color <- iteam_green,
                   color <- "#DCDCDC"))
        return(paste0("<div style=\"float:left;margin-left:1px;width:12px;height:16px;background-color:", color,"\"></div>"))
      }
      customCounts <- function(x) {
        x <- unlist(x)
        if (length(x) < 1) { 
          return("There are no actions listed under this priority area.") 
        } else { 
          tempProgress <- 0;
          tempNotStarted <- 0;
          tempComplete <- 0;
          for (i in length(x)) {
            ifelse(x[i] == "&#128260",
                   tempProgress <- tempProgress + 1,
                   ifelse(x[i] == "&#9989",
                          tempComplete <- tempComplete + 1,
                          tempNotStarted <- tempNotStarted + 1))
          }
          
          return(paste0(tempComplete, " action", (ifelse(tempComplete==1, "", "s")), " complete, ", 
                        tempNotStarted, " action", (ifelse(tempNotStarted==1, "", "s")), " in progress (", 
                        length(x), " total)"))
        }
      }
      tempData <- sapply(sapply(lapply(data, "[[", 2), FUN=strsplit, " "), "[[", 1)
      tempBar <- lapply(tempData, FUN=customBar)
      tempCounts <- customCounts(tempData)
      return(HTML(sort(unlist(tempBar), decreasing=TRUE), paste0("<br />", tempCounts)))
    }
    
   #add text for Brandon Scotts welcome
   text1 <- div(HTML("<h5>Hello Baltimore! My administration is committed to transparency as we work to provide the services Baltimore residents deserve. I came into this office with both a long-term vision for Baltimore and a clear strategy to make change. I tasked my transition team with building a framework of early-term priorities that will put us on a path to success. </h5> 
                     <h5>My administration is your administration. I asked my team to create this 100 Days of Action Tracker so you could hold me accountable to achieve the vision I was elected to deliver. Every week, we will share progress updates across these ten priority areas, so you know what's happening in City Hall. With your help, this is going to be the most open and accountable administration in Baltimore's history.</h5>"))
   text2 <- div(HTML("<p class=\"tab-header\">This table displays Mayor Scott's early achievements organized by priority area. Click the plus sign next to each priority area to see more details on the key goals and progress toward actions associated with each one. For an overview of the transition committees oriented around each of the Mayor's priority areas, visit ",
        "<a href='https://www.brandonsplan.com/transition-team'>this webpage</a>.</p>"))
   text3 <- div(HTML("<p class=\"tab-header\">This table displays progress updates, which are submitted weekly, for the actions selected for the 100 Days of Action. You can sort and filter the list of updates by any column by clicking the filter icon on the top right of the column and then choosing options from the popup window.</p>"))
   text4 <- div(HTML("<p class=\"tab-header\">We're excited to have your input and involvement as we work to make Baltimore healthier, safer, and more equitable. Below are a few links of how to get involved and a sign-up sheet to stay in the loop about Mayor Scott's work. We can't wait to get to know you!</p>"))

   #Add texts and links for the resources page
   link1 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Mayor's Office Homepage</a></b>"," - You can visit this site to stay informed about Baltimore City services and connect with your city leaders.</p>")
   link2 <- HTML("<p><b><a href='https://balt311.baltimorecity.gov/citizen/servicetypes'>Submit a Service Request</a></b>"," - You can use Baltimore 311 to request any city service over the phone, on the 311 app, or online.</p>")
   link3 <- HTML("<p><b><a href='https://www.baltimorecitycouncil.com/'>City Council Homepage</a></b>"," - You can visit this site to learn more about the City Council, connect with your representatives, and follow their calendar.</p>")
   link4 <- HTML("<p><b><a href='https://mayor.baltimorecity.gov/help'>Connect with Constituent Services</a></b>"," - You can use this office to connect directly with the Mayor's Office and follow up on your service requests.</p>")
   link5 <- HTML("<p><b><a href='https://msa.maryland.gov/msa/mdmanual/07leg/html/gacobcit.html'>Baltimore City State Delegation Homepage</a></b>"," - You can visit this site to connect with Baltimore's state legislators and follow pending legislation.</p>")
   link6 <- HTML("<p><b><a href='https://planning.baltimorecity.gov/maps-data/online-community-association-directory'>Learn about your Community Association</a></b>"," - You can use this page to find out more about your Community Association and get involved!</p>")
   
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
   headerImgSize <- 90
    
  #-----------------------------

  #Load and format data

    #set up google sheets access
    pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 1)
    pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 2)
    pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 3)
    pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 4)
    
    tbDays <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Days") %>% 
      mutate(Status = factor(sapply(.$Date,past), 
                             levels=c("Past", "Current","Remaining")),
             Total = 1)
    
    tbPriorities <- read_excel("data/100 Day Tracker Data.xlsx", sheet="Actions") %>%
      mutate(.," " = with(.,case_when(
                           (Committee == "Public Health & Public Safety") ~ health,
                           (Committee == "Business, Workforce & Neighborhood Development") ~ business,
                           (Committee == "Fiscal Preparedness") ~ finance,
                           (Committee == "Education & Youth Recreation") ~ education,
                           (Committee == "Housing & Neighborhood Development") ~ neighborhood,
                           (Committee == "Transportation & Infrastructure") ~ transportation,
                           (Committee == "Human Services") ~ human_services,
                           (Committee == "Governance Structure & Operations") ~ governance,
                           (Committee == "Environment & Sustainability") ~ sustainability,
                           T ~ as.character(arts)
                                  )))

    
    tbActionsNested <- tbPriorities %>% 
      mutate(ActionProgressParties = mapply(c, Action, 
                                            paste(symbol(Progress), Progress), 
                                            `Parties Responsible`, 
                                            SIMPLIFY = F)) %>% 
      select(c("Committee", "ActionProgressParties")) %>% 
      group_by(Committee) %>%
      summarise(ActionProgressParties = list(unique(ActionProgressParties))) 
    
    tbCommittees <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees") %>% 
      rename("Priority Area" = Name) %>% 
      left_join(tbActionsNested, by = c("Priority Area" = "Committee")) %>%
      select(-c(4,5)) %>%
      mutate(.," " = with(.,case_when(
        (`Priority Area` == "Public Health & Public Safety") ~ health,
        (`Priority Area` == "Business, Workforce & Neighborhood Development") ~ business,
        (`Priority Area` == "Fiscal Preparedness") ~ finance,
        (`Priority Area` == "Education & Youth Recreation") ~ education,
        (`Priority Area` == "Housing & Neighborhood Development") ~ neighborhood,
        (`Priority Area` == "Transportation & Infrastructure") ~ transportation,
        (`Priority Area` == "Human Services") ~ human_services,
        (`Priority Area` == "Governance Structure & Operations") ~ governance,
        (`Priority Area` == "Environment & Sustainability") ~ sustainability,
        T ~ as.character(arts)
      ))) %>%
      select(1,5,2,3,4) %>% 
      mutate(Progress = lapply(ActionProgressParties, FUN=priorityAreaProgressBar))
    
    tbUpdates <- pg4 %>%
      mutate(.," " = with(.,case_when(
        (Action == "Public Health & Public Safety") ~ health,
        (Action == "Business, Workforce & Neighborhood Development") ~ business,
        (Action == "Fiscal Preparedness") ~ finance,
        (Action == "Education & Youth Recreation") ~ education,
        (Action == "Housing & Neighborhood Development") ~ neighborhood,
        (Action == "Transportation & Infrastructure") ~ transportation,
        (Action == "Human Services") ~ human_services,
        (Action == "Governance Structure & Operations") ~ governance,
        (Action == "Environment & Sustainability") ~ sustainability,
        T ~ as.character(arts)
      ))) %>%
      select(6,1:5)

  #--------------------------------
    
    # Create "about this initiative" page
    
    aboutus <- div(hr(),
                   fluidRow(
                  column(7,
                         h2("In Development, Check Back Soon"),
                         h4("Mayor Brandon Scott is building an administration grounded in transparency and high-performance in government. ")),
                  column(4,offset = 1, 
                         img(src = "photos/citistat.jpg",
                              height = 4096*.07, width = 3072*.07),
                         h6("Mayor Brandon Scott leading his first CitiStat meeting as Mayor. December 22, 2020"))
    ),
    hr())
    
