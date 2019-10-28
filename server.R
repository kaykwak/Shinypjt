
shinyServer(function(input, output){

  #creating the valueBoxOutput content
  output$value1 <- renderValueBox({
    valueBox(formatC(nb.of.app.total$total_cnt, format="d", big.mark=','),  paste('Number of Apps (as of Feb.2019) '),
      icon = icon("stats",lib='glyphicon'), color = "aqua") })
  
  output$value2 <- renderValueBox({
    valueBox( formatC(nb.of.category$category_cnt, format="d", big.mark=','), paste('Number of Category '),
      icon = icon("menu-hamburger",lib='glyphicon'), color = "yellow") })
  
  output$value3 <- renderValueBox({
    valueBox( formatC(paste(nb.of.paid.app$paid_cnt, "  (7.38%)"), format="d", big.mark=','),  paste('Number of Paid App. '),
      icon = icon("dollar"),  color = "purple") })

  
##  Number of Apps.
  
  output$nb.by.categ  <- renderPlotly({
    plot_ly(data = nb.by.categ, x = ~count_1.2.1, y = ~reorder(Category, count_1.2.1),
          type = "bar", orientation = 'h',
          marker = list(color= c(1:35), colorscale='Hot', reversescale = F,
                        line = list(color = FALSE, width = 0))) %>% 
    layout( paper_bgcolor= 'lightgray',
            plot_bgcolor='rgba(0,0,0,0)',
            title = "<b>[ Number of Apps by Category ]</b>",
           xaxis = list(title="Number of Apps"), 
           yaxis = list(title="", tickfont = list(size= 10)), 
           margin = list( l = 5, r = 5, b = 30, t = 40,  pad = 4) ) 
   })
  
  colors <- c('rgb(114,147,203)', 'rgb(211,94,96)', 'rgb(171,104,87)', 'rgb(128,133,133)', 'rgb(144,103,167)')
  
  output$nb.by.categ_simp <- renderPlotly({
    plot_ly(nb.by.categ_simp, labels = ~Category.simple.new, values = ~count_1.1.1, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = F) %>%
            layout(paper_bgcolor= 'lightgray',
                   plot_bgcolor='rgba(0,0,0,0)',
                   title = "<b>[ Number of Apps by Category</b> (simplyfied) <b>]</b>", 
             xaxis = list(showgrid = TRUE, zeroline = TRUE, showticklabels = TRUE),
             yaxis = list(showgrid = TRUE, zeroline = TRUE, showticklabels = TRUE), 
             margin = list( l = 5, r = 5, b = 20, t = 40,  pad = 4) ) 
    })

  
    output$and.ver <- renderPlotly({
    plot_ly(and.ver, labels = ~Android.Ver.update, values = ~count_1.1.4, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            marker = list(
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = F) %>%
      layout(paper_bgcolor= 'lightgray',
             plot_bgcolor='rgba(0,0,0,0)',
             title = "<b>[ Number of Apps by Android Ver. ]</b>", font= c(face='bold'),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), 
             margin = list( l = 5, r = 5, b = 20, t = 40,  pad = 4) ) 
  })
    
    
    
##  Number of Paid Apps.
    
    output$type.by.categ.pay <- renderPlot({
      ggplot(type.by.categ.pay, 
             aes(x=reorder(Category, ratio), y=count_1.2.2, fill=Type)) +
        geom_bar(position='fill', stat='identity') + 
        scale_fill_manual(values = c("darkgrey", "blue4")) +
        coord_flip() +
        labs(title="[ Paid App Proportion by Category ]",  x="", y="Ratio",
             fill = "Payment type") +
        
        theme(plot.title = element_text(hjust = 0.4, fac="bold", size=18),
              panel.background = element_rect(fill = "lightgray", colour = "lightgray",
                                              size = 0.5, linetype = "solid"),
              plot.background = element_rect(fill = "lightgray"),
              legend.position = c(0.8, 0.07),  legend.direction = "horizontal")
      
    })
    
    output$apps.by.pay <- renderPlotly({
    plot_ly(apps.by.pay, labels = ~Type, values = ~count_1.1.2, type = 'pie',
          textposition = 'inside',
          textinfo = 'label+percent',
          insidetextfont = list(color = '#FFFFFF'),
          marker = list(colors = colors,
                        line = list(color = '#FFFFFF', width = 1)),
          showlegend = F) %>%
    layout(paper_bgcolor= 'lightgray',
           plot_bgcolor='rgba(0,0,0,0)',
           title = "<b>[ Paid Apps Proportion ]</b>", font= c(face='bold'),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           margin = list( l = 5, r = 5, b = 20, t = 40,  pad = 4) )
    })

  output$price.range <- renderPlotly({
    plot_ly(price.range, labels = ~Price.range.new, values = ~count_1.1.3, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            marker = list(
                         line = list(color = '#FFFFFF', width = 1)),
            showlegend = F) %>%
      layout(paper_bgcolor= 'lightgray',
             plot_bgcolor='rgba(0,0,0,0)',
             title = "<b>[ Price Range of paid Apps ]</b>", font= c(face='bold'),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             margin = list( l = 5, r = 5, b = 20, t = 40,  pad = 4) )
  })
  

  
  
 # Serch App
  
  output$search <- 
    DT::renderDataTable({
   
      datatable(df %>% 
                  select(., App, Category, Rating, Reviews, Size.update, 
                         Installs.update, Type, Price.dollar, Price.range.new, 
                         Genres, Android.Ver.update) %>% 
                  filter(., Category %in% input$categ) %>%
                  filter(., Rating >= input$rating[1] & Rating <= input$rating[2]) %>% 
                  filter(., if (input$pay.type == "All") {
                                as.character(Type) %in% c("Paid","Free")
                              } else {Type == input$pay.type}) %>% 
                  filter(., Installs.update %in% input$install),
       

                
              options = list(rownames=FALSE,  autoWidth = TRUE,
                             autoHeight = TRUE,
                             scrollCollapse = TRUE,
                             scroller = TRUE,
                             scrollX = TRUE,
                             scrollY = TRUE,
                             # columnDefs = list(list(width = '200px', targets = "_all")),
                             # pageLength = 10,
                             fixedHeader = TRUE,
                             list(paging = FALSE)
              )  )  %>%
      formatStyle(input$selected, background="skyblue", fontWeight='bold')
  })
  
  
  
#  Raw Data

  output$table <- DT::renderDataTable({
    datatable(df, 
              options = list(rownames=FALSE,  
                             scrollCollapse = TRUE,
                             scroller = TRUE,
                             scrollX = TRUE,
                             scrollY = TRUE,
                             autoWidth = FALSE,
                             columnDefs = list(list(width = '200px', targets = "_all")),
                             fixedHeader = TRUE,
                             list(paging = FALSE)
                             ), 
              filter = 'top') %>%
      formatStyle(input$selected, background="skyblue", fontWeight='bold')

  })

})
