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
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_fill_manual(values=ggpalette1, drop = FALSE, name="Status")
    
  }, height = "auto")
  
  output$plotTimeline <- renderPlot({
    tbDays %>%
      select(c(1:3)) %>%
      mutate(Days = factor(sapply(pg2$Date,past), levels=c("Past", "Current","Remaining")),
             Total = 1) %>%
      ggplot(aes(fill = Days, x = Total, y = "")) +
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
      scale_fill_manual(values=c(iteam_green,bc_gold,"whiteSmoke"), drop=FALSE)
    
  }, height = "auto")
  
  output$dis <- renderDataTable({})
  
}
