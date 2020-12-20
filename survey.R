#produce survey for page four of site

  #------------------------------
  
  # Create Basic Survey Form & Hidden Pages
  
    survey <- div(
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
      actionButton("submit", "Submit", class = "btn-primary"),
      fluidRow(column(4,textInput("firstname", "First Name", "",width = '100%')),
          column(4,textInput("lastname", "Last Name", "",width = '100%'))),
      fluidRow(column(4,textInput("email", "Email Address",width = '100%')),
          column(4,textInput("home", "Home Address (optional)",width = '100%'))),
      fluidRow(column(4,textInput("city", "City (optional)",width = '100%')),
          column(4,textInput("zipcode", "Zip Code (optional)",width = '100%'))),
      fluidRow(column(12,textInput("message", "Type your message here!",width = '100%'))),
      fluidRow(column(4,selectInput("type", "Is your comment for the administration or for this page's developers?",
                  c("",  "Administration", "Developers"),width = '100%')),
               column(4,checkboxInput("updated", "Keep me updated about this administration's achievements serving Baltimore City", T)),),
      fluidRow(actionButton("submit", "Submit", class = "btn-primary"))
    )
    
    #set mandatory fields
    fieldsMandatory <- c("firstname","lastname","email","message","updated","type")
    
    hidden1 <- shinyjs::hidden(
      span(id = "submit_msg", "Submitting..."),
      div(id = "error",
          div(br(), tags$b("Error: "), span(id = "error_msg"))
      )
    )
    
    hidden2 <- shinyjs::hidden(
      div(
        id = "thankyou_msg",
        h3("Thanks, your response was submitted successfully!")
      )
    )
        
  #----------------------------------

  # Create Saving Protocol

    #save responses on submission
    fieldsAll <- c("firstname","lastname","email","home","city","zipcode","message","updated","type")
    responsesDir <- file.path("responses")
    
    #create a user friendly date for the file names
    epochTime <- function() {
      as.integer(Sys.time())}
    humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")
    
    # save the results to a file
    saveData <- function(data) {
      fileName <- sprintf("%s_%s.csv",
                          humanTime(),
                          digest::digest(data))
      
      write.csv(x = data, file = file.path(responsesDir, fileName),
                row.names = FALSE, quote = TRUE)
    }
