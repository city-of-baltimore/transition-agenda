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
library(shiny.i18n)

source('preset.R',local = T)
source('city-content.R', local=T)
source('ui.R',local = T)
source('server.R',local = T)


shinyApp(
  ui = ui,
  server = server
)
