library(shiny)

source('preset.R',local = T)
source('ui.R',local = T)
source('server.R',local = T)

shinyApp(
  ui = ui,
  server = server
)
