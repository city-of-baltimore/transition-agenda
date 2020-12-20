#install and load relevant packages
pacman::p_load(ggplot2, gfonts, googlesheets4, 
               formattable, shiny, tidyverse,
               lubridate, readxl, DT, shinyjs)


# setwd("C:/Users/brend/OneDrive/Documents/GitHub/transition-agenda")

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

#set up google sheets access
pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 1)
pg2 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 2)
pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 3)
pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = 4)

tbCommittees <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees") %>% 
  rename("Priority Area" = Name)

#Create table for manipulation later
tbPriorities <- pg1 %>%
  select(c(2,4,5,6,10,11,13,14))

tbUpdates <- pg4

ggpalette1 <- cbind(
  c(iteam_red_light5,"whiteSmoke",iteam_green),
  c("Not Yet Started","In Progress","Complete")
)

ggpalette2 <- cbind(
  c("whiteSmoke",iteam_green),
  c("Days Remaining","Past")
)

#Creating a function for the days remaining graphic
past <- function(date){
  
  ifelse(date > today(),
         "Days Remaining","Past")
  
}

#add text for Brandon Scotts welcome
text1 <- print("Welcome from Mayor Scott explaining the purpose of this tool and how to use it. Why it matters. His vision for the city and for his administration. Explain the short term actions and long term vision.")

#size for header images
headerImgSize <- 90

#survey questions for form

survey <-     div(
  id = "form",
  textInput("firstname", "First Name", ""),
  textInput("lastname", "Last Name", ""),
  textInput("email", "Email Address"),
  textInput("home", "Home Address (optional)"),
  textInput("city", "City (optional)"),
  textInput("zipcode", "Zip Code (optional)"),
  textInput("message", "Type your message here!"),
  checkboxInput("updated", "Keep me updated about this administration's achievements serving Baltimore City", FALSE),
  selectInput("type", "Is your comment for the administration or for this page's web developers?",
              c("",  "Administration", "Developers")),
  actionButton("submit", "Submit", class = "btn-primary")
)

hidden <- shinyjs::hidden(
  div(
    id = "thankyou_msg",
    h3("Thanks, your response was submitted successfully!")
  ))

#set mandatory fields
fieldsMandatory <- c("firstname","lastname","email","message","updated","type")

#save responses on submission
fieldsAll <- c("firstname","lastname","email","home","city","zipcode","message","updated","type")
responsesDir <- file.path("responses")
epochTime <- function() {
  as.integer(Sys.time())
}

#create a user friendly date for the file names
humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

