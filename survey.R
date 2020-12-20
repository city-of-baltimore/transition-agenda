#survey questions for form

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
)

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


#set mandatory fields
fieldsMandatory <- c("firstname","lastname","email","message","updated","type")

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
