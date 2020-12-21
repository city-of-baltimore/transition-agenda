#shiny.io seemed to have a problem with the pacman load, so i switched to library()

library(pacman)
library(ggplot2)
library(gfonts)
library(googlesheets4)
library(formattable)
library(shiny)
library(tidyverse)
library(lubridate)
library(readxl)
library(DT)
library(shinyjs)
library(rsconnect)

#pacman::p_load(ggplot2, gfonts, googlesheets4, 
 #              formattable, shiny, tidyverse,
  #             lubridate, readxl, DT, shinyjs,
   #            rsconnect)


#setwd("C:/Users/brend/OneDrive/Documents/GitHub/transition-agenda")

source('preset.R',local = T)
source('survey.R',local = T)
source('server.R',local = T)
source('ui.R',local = T)

shinyApp(
  ui = ui,
  server = server
)
