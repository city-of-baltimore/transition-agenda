#produce content displayed through ui

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(tidyverse)
  library(DT)
  library(shinyjs)
  
  #-----------------------------------
  
  # Basic Structure

  server <- function(input, output, session){
  #------------------------------------
      load(".RData")
    
#    observeEvent(input$selected_language, {
#      # This print is just for demonstration
#      print(paste("Language change!", input$selected_language))
#      # Here is where we update language in session
#      shiny.i18n::update_lang(session, input$selected_language)
#    })
    
  #------------------------------------
  # Get current time

  output$currentTime <- renderText({
    # Refresh every second
    invalidateLater(1000, session)
    
    # Output server time
    format(Sys.time())
  })

  #-----------------------------------
    
    #Tracker Outputs
    
    #Load the progress tracker output
    output$plotProgress <- renderPlot({
      tbPriorities %>%
        ggplot(aes(fill = Progress, x = Count, y = "")) +
        geom_bar(position = position_fill(reverse = TRUE),
                 stat = "identity",
                 width = 1) +
        coord_flip() +
        theme(legend.position = "bottom",
              legend.justification = "right",
              plot.title = element_text(size=18, face="bold", margin=margin(c(0,0,8,0))),
              legend.margin=margin(c(0,0,-4,0)),
              legend.title=element_text(size=16), 
              legend.text=element_text(size=16),
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
  
    # Text for timeline vis description
    output$timelineText <- renderText({

      # Refresh every minute
      invalidateLater(60000, session)
      
      # Return text explaining when the 100 Days of Action began, and if
      # they are still happening, the current date and number. If they are
      # no longer happening, return the date they ended.
      ifelse(which(tbDays$Date == Sys.Date())<=100,
        paste0("Mayor Scott took office on 12/8/20. Today is day ", 
            which(tbDays$Date == Sys.Date()),
            "."
          ),
        paste0("The 100 Days of Action began when Mayor Scott took office ",
          "on 12/8/20. The last day was 3/17/21."
        )
      )
    })
    
    #load the timeline tracker output
    output$plotTimeline <- renderPlot({
      # Refresh every minute
      invalidateLater(60000, session)
      
      tbDays %>%
        mutate(Status = factor(sapply(.$Date,function(x) {ifelse(x > Sys.Date(), "Remaining", ifelse(x == Sys.Date(), "Current","Past"))}),
                               levels=c("Past", "Current","Remaining")),
               Total = 1) %>%
        ggplot(aes(fill = Status, x = Total, y = "")) +
        geom_bar(position = position_fill(reverse = TRUE),
                 stat = "identity",
                 width = 1) +
        coord_flip() +
        theme(legend.position = "bottom",
              legend.justification = "right",
              plot.title = element_text(size=18, face="bold", margin=margin(c(0,0,8,0))),
              legend.margin=margin(c(0,0,-4,0)),
              legend.title=element_text(size=16), 
              legend.text=element_text(size=16),
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
    
  # Table with progress on all priority areas and actions
  
  output$tbPriorities = DT::renderDataTable({
      DT::datatable(
      cbind(tbCommittees, 'Expand' = '▼'),
      options = list(
        dom = 'ft',
        searching = F,
        pageLength = 10,
        columnDefs = list(
          list(width = '300px', targets = c(3)),
          list(width = '18px', targets = c(1)),
          list(width = '172px', targets = c(4)),
          list(visible = FALSE, targets = c(0, 2, 4, 5)),
          list(orderable = FALSE, targets = "_all"),
          list(className = 'details-control', targets = c(7)), 
          list(className = 'dt-center', targets = c(0,4))
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
            var result = '<table class=\"priorities-hierarchy-2\" style=\"font-size:16px;padding:0.5em;margin-left:32px;width:calc(100% - 24px);\">';
            result += '<tr><th>Action</th><th>Status</th><th>Parties Responsible</th></tr>';
            for (var i in d[5]){
              result += '<tr >';
              for (var j in d[5][i]) {
                if (j == 0) {
                  result += '<td style=\"width:300px;\">' + d[5][i][j] + '</td>';
                } else if (j == 1) {
                  result += '<td style=\"width:120px;\">' + d[5][i][j] + '</td>';
                } else {
                  result += '<td>' + d[5][i][j] + '</td>';
                }
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
            td.html('▼');
          } else {
            row.child(format(row.data())).show();
            td.html('▲');
          }
        });"
      )
     ,escape = F
      ) %>%
      formatStyle(
        names(tbCommittees),
        target = 'row',
        backgroundColor = 'white', fontSize = '18px')  %>%
      formatStyle('Priority Area', fontSize = '18px', fontWeight = 'bold') %>% 
      formatStyle('Progress', fontSize = '18px', fontWeight = 300) %>% 
      formatStyle('Expand', fontSize = '18px', color="grey", fontWeight = 300)
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
  
  # output$tbUpdates <- DT::renderDataTable({DT::datatable(tbUpdates, 
  #                                     options=list(
  #                                       pageLength=10,
  #                                       searching = T,
  #                                       initComplete = JS("function(settings, json) 
  #                                                         {$(this.api().table().container()).css({'font-size' : '18px'});",
  #                                                         "}"),
  #                                       columnDefs = list(
  #                                         list(visible = FALSE, targets = c(0)),
  #                                         list(orderable = FALSE, targets = c(0, 1, 3)),
  #                                         list(className = 'dt-center', targets = c(2))
  #                                       )),
  #                                     escape = F) %>% 
  #   formatStyle(names(tbUpdates), target = 'row',
  #     backgroundColor = 'white', fontSize = '16px')})
  
  #----------------------------
  
  }
