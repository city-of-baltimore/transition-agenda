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
  output$plot1 <- renderPlot({
    tbPriorities %>%
      ggplot(aes(fill = Progress, x = Count, y = "")) +
      geom_bar(position = position_fill(reverse = TRUE),
               stat = "identity",
               width = .5) +
      theme(legend.position = "bottom",
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=ggpalatte1)
    
  }, height = "auto")
  
  output$plot2 <- renderPlot({
    pg2 %>%
      select(c(1:3)) %>%
      mutate(Days = sapply(pg2$Date,past),
             Total = 1) %>%
      ggplot(aes(fill = Days, x = "", y = Total)) +
      geom_bar(position = "fill", 
               stat = "identity",
               width = .5) +
      coord_flip() +
      theme(legend.position = "bottom",
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.x=element_blank(),
            axis.ticks.y=element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank()
      ) +
      scale_fill_manual(values=ggpalatte2)
    
  }, height = "auto")
  
  output$dis <- renderDataTable({})
  
}