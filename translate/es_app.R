library(pacman)
library(ggplot2)
library(gfonts)
library(formattable)
library(shiny)
library(tidyverse)
library(lubridate)
library(shinyjs)
library(readxl)
library(rsconnect)
library(DT)
library(htmltools)

setwd("~/GitHub/transition-agenda")

source('translate/es_preset.R',local = T)
source('translate/es_city-content.R', local=T)
source('translate/es_ui.R',local = T)
source('translate/es_server.R',local = T)


shinyApp(
  ui = ui,
  server = server
)
