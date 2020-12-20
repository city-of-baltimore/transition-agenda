server <- function(input, output){
  
  output$tbPriorities = DT::renderDataTable({
    DT::datatable(
      cbind(tbCommittees, "Progress" = "N/A", 'Expand' = '+'),
      options = list(
        columnDefs = list(
          list(visible = FALSE, targets = c(0, 1, 3, 4, 5)),
          list(orderable = FALSE, className = 'details-control', targets = 7)
        )
      ),
      callback = JS("
        table.column(3).nodes().to$().css({cursor: 'pointer'});
        var format = function(d) {
          return '<div style=\"padding: .5em;\"> Model: ' +
                  d[0] + ', mpg: ' + d[2] + ', cyl: ' + d[3] + '</div>';
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
  
  output$tbUpdates <- renderDataTable(tbUpdates, 
                                      options=list(pageLength=10))
  
  #Load the progress tracker output
  output$plotProgress <- renderPlot({
    tbPriorities %>%
      ggplot(aes(fill = Progress, x = Count, y = "")) +
      ggtitle("Progress") +
      geom_bar(position = position_fill(reverse = TRUE),
               stat = "identity",
               width = .5) +
      theme(legend.position = "bottom",
               width = 1) +
      theme(legend.position = "top",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,-18,0))),
            legend.margin=margin(c(0,0,-4,0)),
            legend.title=element_text(size=12), 
            legend.text=element_text(size=12),
            panel.margin=margin(c(0,0,0,0)),
            panel.border = element_rect(colour = "black", fill=NA, size=0.5),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=ggpalatte1)
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_fill_manual(values=ggpalette1, drop = FALSE, name="Status")
    
  }, height = "auto")
  
  output$plotTimeline <- renderPlot({
    pg2 %>%
      select(c(1:3)) %>%
      mutate(Days = sapply(pg2$Date,past),
             Total = 1) %>%
      ggplot(aes(fill = Days, x = "", y = Total)) +
      geom_bar(position = "fill", 
      ggplot(aes(fill = Days, x = Total, y = "")) +
      ggtitle("Timeline") +
      geom_bar(position = "fill",
               stat = "identity",
               width = .5) +
               width = 1) +
      coord_flip() +
      theme(legend.position = "top",
            legend.justification = "right",
            plot.title = element_text(size=14, face="bold", margin=margin(c(0,0,-18,0))),
            legend.margin=margin(c(0,0,-4,0)),
            legend.title=element_text(size=12), 
            legend.text=element_text(size=12),
            panel.border = element_rect(colour = "black", fill=NA, size=0.5),
            panel.margin=margin(c(0,0,0,0)),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_fill_manual(values=ggpalatte2)
    
  }, height = "auto")
  
  output$dis <- renderDataTable({})
  
  #observe if mandatory fields in the survey have a value
  observe({
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    
    # enable/disable the submit button
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  
  #capture form data in a responses field
  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = epochTime())
    data <- t(data)
    data
  })
  
  #and save the responses to csv files
  saveData <- function(data) {
    fileName <- sprintf("%s_%s.csv",
                        humanTime(),
                        digest::digest(data))
    
    write.csv(x = data, file = file.path(responsesDir, fileName),
              row.names = FALSE, quote = TRUE)
  }

  # action to take when submit button is pressed
  observeEvent(input$submit, {
    saveData(formData())
    shinyjs::reset("form")
    shinyjs::hide("form")
    shinyjs::show("thankyou_msg")
  })
  
}