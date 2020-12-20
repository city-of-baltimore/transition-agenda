#produce content displayed through ui

  #-----------------------------------
  
  # Basic Structure

    server <- function(input, output,session){
  
  #------------------------------------
  
  # Progress table outputs
  
  output$tbPriorities = DT::renderDataTable({
    DT::datatable(
      cbind(tbCommittees, "Progress" = "N/A", 'Expand' = '+'),
      options = list(
        columnDefs = list(
          list(visible = FALSE, targets = c(0, 1, 3, 4, 5, 6)),
          list(orderable = FALSE, className = 'details-control', targets = 8)
        )
      ),
      callback = JS("
        table.column(3).nodes().to$().css({cursor: 'pointer'});
        var format = function(d) {
          var result = '<table style=\"padding: .5em;width:100%;\">';
          result += '<tr><th>Action</th><th>Status</th><th>Parties Responsible</th><tr>';
          for (var i in d[6]){
            result += '<td>' + d[6][i] + '</td>'
          }
          result += '</table>';
          return result;
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
      ))
  }, options=list(pageLength=10))
  
  #-------------------------------------
  
  # Updates table outputs
  
  output$tbUpdates <- renderDataTable(tbUpdates, 
                                      options=list(pageLength=10))
  
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
      theme(legend.position = "top",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,-18,0))),
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
      theme(legend.position = "top",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,-18,0))),
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
  
}


