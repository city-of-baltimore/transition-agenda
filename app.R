library(pacman)
library(ggplot2)
library(gfonts)
library(googlesheets4)
library(formattable)
library(shiny)
library(tidyverse)
library(lubridate)
library(DT)
library(shinyjs)
library(readxl)
library(rsconnect)
library(htmltools)
library(shiny.i18n)

#setwd("C:/Users/brend/OneDrive/Documents/GitHub/transition-agenda")

source('preset.R',local = T)
source('server.R',local = T)
source('city-content.R', local=T)
source('ui.R',local = T)

shinyApp(
  ui = ui,
  server = server
)
