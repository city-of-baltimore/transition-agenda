library(shiny)

source('preset.R')
source('ui.R', local = TRUE)
source('server.R')

shinyApp(
  ui = ui,
  server = server
)
