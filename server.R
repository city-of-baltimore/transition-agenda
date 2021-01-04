#produce content displayed through ui

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(DT)
  library(shinyjs)

  #-----------------------------------
  
  # Basic Structure

    server <- function(input, output,session){
  
  #------------------------------------
  
  # Table with progress on all priority areas and actions
  
  output$tbPriorities = DT::renderDataTable({
      DT::datatable(
      cbind(tbCommittees, 'Expand' = '+'),
      options = list(
        dom = 'ft',
        pageLength = 10,
        order = list(list(3, 'asc')),
        columnDefs = list(
          list(width = '380px', targets = c(3)),
          list(width = '18px', targets = c(2, 7)),
          list(visible = FALSE, targets = c(0, 1, 4, 5)),
          list(orderable = FALSE, targets = c(0, 1, 2, 4, 5, 6, 7)),
          list(className = 'details-control', targets = c(7)), 
          list(className = 'dt-center', targets = c(2,7))
        ),
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'font-size': '18px'});",
          "}")
      ),
      colnames = c("", "", "", "Priority Area", "", "", "Progress", ""),
      callback = JS("
        table.column(6).nodes().to$().css({cursor: 'pointer'});
        var format = function(d) {
          if (d[5] == null) {
            return '<p>There is no additional data to display here.</p>';
          } else {
            var result = '<table style=\"padding: .5em;width:100%;\">';
            result += '<tr><th>Action</th><th>Status</th><th>Parties Responsible</th></tr>';
            for (var i in d[5]){
              result += '<tr>';
              for (var j in d[5][i]) {
                result += '<td style=\"max-width:260px;\">' + d[5][i][j] + '</td>';
              }
              result += '</tr>';
            }
            result += '</table>';
            return result;
          }
        };
        table.on('click', 'td.details-control', function() {
          var td = $(this), row = table.row(td.closest('tr'));
          if (row.child.isShown()) {
            row.child.hide();
            td.html('+');
          } else {
            row.child(format(row.data())).show();
            td.html('-');
          }
        });"
      )
     ,escape = F
      ) %>% formatStyle(
        names(tbCommittees),
        target = 'row',
        backgroundColor = 'white', fontSize = '16px')  %>%
      formatStyle('Priority Area', fontWeight = 'bold') %>% 
      formatStyle('Progress', fontSize = '14px', fontWeight = 300)
  })
  
  #------------------------------------
  
  # Download button for data on all actions
  
  output$downloadActions <- downloadHandler(
    filename = function() {
      paste(Sys.Date(), "-mayor-scott-transition-tracker-actions.csv", sep="")
    },
    content = function(file) {
      write.csv(tbPriorities %>% 
                  rename(Status = Progress,
                         `Priority Area` = Committee) %>% 
                  select(`Action #`, Action, Status, `Priority Area`,`Parties Responsible`), 
                file,
                row.names=FALSE)
    }
  )
  
  #-------------------------------------
  
  # Updates table outputs
  
  output$tbUpdates <- DT::renderDataTable({DT::datatable(tbUpdates, 
                                      options=list(
                                        pageLength=10,
                                        columnDefs = list(
                                          list(visible = FALSE, targets = c(0)),
                                          list(orderable = FALSE, targets = c(0, 1, 2)),
                                          list(className = 'dt-center', targets = c(2))
                                        )),
                                      escape = F) %>% 
    formatStyle(names(tbUpdates), target = 'row',
      backgroundColor = 'white', fontSize = '16px')})
  
  #-----------------------------------
  
  #Tracker Outputs
  
  #Load the progress tracker output
  output$plotProgress <- renderPlot({
    tbPriorities %>%
      ggplot(aes(fill = Progress, x = Count, y = "")) +
      ggtitle("Progress") +
      geom_bar(position = position_fill(reverse = TRUE),
               stat = "identity",
               width = 1) +
      coord_flip() +
      theme(legend.position = "bottom",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,8,0))),
            legend.margin=margin(c(0,0,-4,0)),
            legend.title=element_text(size=12), 
            legend.text=element_text(size=12),
            panel.spacing = margin(c(0,0,0,0)),
            panel.border = element_rect(colour = "black", fill=NA, size=0.5),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_fill_manual(values=ggpalette1, drop = FALSE, name="Progress")
    }, height = "auto")
  
  #load the timeline tracker output
  output$plotTimeline <- renderPlot({
    tbDays %>%
      ggplot(aes(fill = Status, x = Total, y = "")) +
      ggtitle("Timeline") +
      geom_bar(position = position_fill(reverse = TRUE),
               stat = "identity",
               width = 1) +
      coord_flip() +
      theme(legend.position = "bottom",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,8,0))),
            legend.margin=margin(c(0,0,-4,0)),
            legend.title=element_text(size=12), 
            legend.text=element_text(size=12),
            panel.border = element_rect(colour = "black", fill=NA, size=0.5),
            panel.spacing = margin(c(0,0,0,0)),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_fill_manual(values=ggpalette2, drop=FALSE, name = "Status")
  }, height = "auto")
  
  
  #----------------------------
  
  #Survey outputs
  
  # Enable the Submit button when all mandatory fields are filled out
  observe({
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  
  # Gather all the form inputs (and add timestamp)
  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = epochTime())
    data <- t(data)
    data
  })    
  
  # When the Submit button is clicked, submit the response
  observeEvent(input$submit, {
    
    # User-experience stuff
    shinyjs::disable("submit")
    shinyjs::show("submit_msg")
    shinyjs::hide("error")
    
    # Save the data (show an error message in case of error)
    tryCatch({
      saveData(formData())
      shinyjs::reset("form")
      shinyjs::hide("form")
      shinyjs::show("thankyou_msg")
    },
    error = function(err) {
      shinyjs::html("error_msg", err$message)
      shinyjs::show(id = "error", anim = TRUE, animType = "fade")
    },
    finally = {
      shinyjs::enable("submit")
      shinyjs::hide("submit_msg")
    })
  })
  
  # submit another response
  observeEvent(input$submit_another, {
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
  })
 

  # download survey responses (for admins only)

  # render the admin panel
#  output$adminPanelContainer <- renderUI({
#    if (!isAdmin()) return()
#    
#    div(
#      id = "adminPanel",
#      h2("Previous responses (only visible to admins)"),
#      downloadButton("downloadBtn", "Download responses"), br(), br(),
#      DT::dataTableOutput("responsesTable")
#    )
#  })
#  
#  # determine if current user is admin
#  isAdmin <- reactive({
#    is.null(session$user) || session$user %in% adminUsers
#  })    
#  
#  # Show the responses in the admin table
#  output$responsesTable <- DT::renderDataTable({
#    data <- loadData()
#    data$timestamp <- as.POSIXct(data$timestamp, origin="1970-01-01")
#    DT::datatable(
#      data,
#      rownames = FALSE,
#      options = list(searching = FALSE, lengthChange = FALSE)
#    )
#  })
#    
#  output$downloadBtn <- downloadHandler(
#    filename = function() { 
#      sprintf("transition_responses_%s.csv", humanTime())
#    },
#    content = function(file) {
#      write.csv(loadData(), file, row.names = FALSE)
#    }
#  ) 
}


