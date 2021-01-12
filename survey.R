#produce survey for page four of site

  #------------------------------

  # Create Basic Survey Form & Hidden Pages
  optional <- "Optional"
  textplacehold <- "Thank you for sharing this message with us! We look forward to reading and responding."
  
    survey <- div(
      id = "form",
      fluidRow(column(4,textInput("firstname", HTML("<p>First Name</p>"), "",width = '100%')),
               column(4,textInput("lastname", HTML("<p>Last Name</p>"), "",width = '100%'))),
      fluidRow(column(4,textInput("email", HTML("<p>Email Address</p>"),width = '100%')),
               column(4,textInput("home", HTML("<p>Home Address</p>"),width = '100%',placeholder = optional))),
      fluidRow(column(4,textInput("city", HTML("<p>City</p>"),width = '100%',placeholder = optional)),
               column(4,textInput("zipcode", HTML("<p>Zip Code</p>"),width = '100%',placeholder = optional))),
      fluidRow(column(8,textAreaInput("message", HTML("<p>Type your message here!</p>"),width = '200%',rows = 4,placeholder = textplacehold))),
      fluidRow(column(4,selectInput("type", HTML("<p>Is your comment for Mayor Scott or for this page's developers?</p>"),
                  c("",  "Mayor Scott", "Web Developers"),width = '100%'))#,
               #column(4,checkboxInput("updated", "Keep me updated about this administration's achievements serving Baltimore City", T))
               ),
      fluidRow(column(12,actionButton("submit", HTML("<b>Submit</b>"), class = "btn-primary")))
    )
    
    #set mandatory fields
    fieldsMandatory <- c("firstname",
                         "lastname",
                         "email",
                         "message",
                         #"updated",
                         "type")
    
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

    
    #---------------------------------
    
    # load all responses into a data.frame
    
    loadData <- function() {
      files <- list.files(file.path(responsesDir), full.names = TRUE)
      data <- lapply(files, read.csv, stringsAsFactors = FALSE)
      data <- do.call(rbind, data)
      data
    }
    
    
    # Create download system for responses
#    
#    downloader <- div(uiOutput("adminPanelContainer"))
#    
#    adminUsers <- c("baltopi")
    
    