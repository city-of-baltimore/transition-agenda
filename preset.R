#produce content and functions for ui and server

  #---------------------------------------
  
  # Load packages
    
    #install and load relevant packages
    pacman::p_load(ggplot2, gfonts, googlesheets4, 
                   formattable, shiny, tidyverse,
                   lubridate, readxl, DT, shinyjs)
    
    
    # setwd("C:/Users/brend/OneDrive/Documents/GitHub/transition-agenda")

  #----------------------------------------

  # Fonts, Colors, and Icons 

    #Set up font
    use_font("roboto", "www/css/roboto.css")
    
    #Set up colors
    iteam_red <- "#f15a29"
    iteam_red_light5 <- "#f8ad94"
    iteam_red_light9 <- "#feefea"
    iteam_yellow <- "#ffc429"
    iteam_green <- "#2bb673"
    iteam_purple <- "#893395"
    bc_gold <- "#fdb927"
    bchd_blue <- "#199eb4"
    
    #Create icons for priority areas
    health <- icon("ambulance")
    business <- icon("store-alt")
    finance <- icon("money-check-alt")
    education <- icon("chalkboard-teacher")
    neighborhood <- icon("building")
    transportation <- icon("bus")
    human_services <- icon("hospital-user")
    governance <- icon("landmark")
    sustainability <- icon("leaf")
    arts <- icon("palette")
    
    #Create icons for the app layout
    see_more <- icon("chevron-down")
    contact_us <- icon("envelope")
    download <- icon("file-download")
    cogs <- icon("cogs")
    tools <- icon("tools")
    
    ggpalette1 <- cbind(
      c(iteam_red_light5,"whiteSmoke",iteam_green),
      c("Not Yet Started","In Progress","Complete")
    )
    
    ggpalette2 <- cbind(
      c(iteam_green,bc_gold,"whiteSmoke"),
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
    
   #add text for Brandon Scotts welcome
   text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")
    
   text1 <- div(HTML("<p>Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters.</p> <p>His vision for the city and for his administration. Explain the short term actions and long term vision.</p>"))
   text2 <- div(hr(),HTML("<p>This table displays Mayor Scott's early achievements organized by priority area. Click the plus sign next to each priority area to see more details on the key goals and progress toward actions associated with each one. For an overview of the transition committees oriented around each of the Mayor's priority areas, visit ",
        "<a href='https://www.brandonsplan.com/transition-team'>this webpage</a>.</p>"),hr())
   text3 <- div(hr(),HTML("<p>This table displays progress updates, which are submitted weekly, for the actions selected for the 100 Days of Action. You can sort and filter the list of updates by any column by clicking the filter icon on the top right of the column and then choosing options from the popup window.</p>"),hr())
   text4 <- div(hr(),HTML("<p>We're excited to have your input and involvement as we work to make Baltimore healthier, safer, and more equitable. Below are a few links of how to get involved and a sign-up sheet to stay in the loop about Mayor Scott's work. We can't wait to get to know you!</p>"),hr())

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
    
    tbCommittees <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees") %>% 
      rename("Priority Area" = Name)
    
    #Create table for manipulation later
    tbPriorities <- pg1 %>%
      select(c(2,4,5,6,10,11,13,14))
    
    tbUpdates <- pg4


