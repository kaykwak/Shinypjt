shinyUI(dashboardPage(
  ## 원본 :   dashboardHeader(title = "Google Playstore App. Analysis"),
  dashboardHeader(title = "Google Playstore App. Analysis"), skin='red',
  dashboardSidebar(
    sidebarUserPanel("Heesuk", 
                     image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHuN2FKT4ZYu-0FbGl09AQ9M7SHecOPNQ0rDWyqez5T5GRFVYB&s'),
  br(),
    br(),
    sidebarMenu(
      menuItem("General Analysis", tabName = "analysis", icon = icon("dashboard")),
      menuItem("App search", tabName = "search", icon = icon("search-plus")),
      menuItem("Raw Data", tabName = "data", icon = icon("database")),
      br() ,
      fluidRow(
          column(width = 11,
            actionButton(  "generate_report_modal", "Download data", icon = icon("download"),
                           style = "width: 95%; color: #111")
          ) )
      )  ),

  dashboardBody(
    tabItems(

      tabItem(
        tabName = "analysis",
          fluidRow( valueBoxOutput("value1"), valueBoxOutput("value2"), valueBoxOutput("value3") ),

        tabPanel("analysis",       
        tabsetPanel(
           tabPanel("Number of Apps",
                wellPanel(style = "background-color: white;", #ffffff;",
                # value = "page1",
                # # fluidRow( ),
                fluidPage(
                  box(style = "background-color: lightgray;", width = 12, height ='auto',  plotlyOutput("nb.by.categ")),
                  box(style = "background-color: lightgray;", width = 6, plotlyOutput("nb.by.categ_simp")),
                  box(style = "background-color: lightgray;", width = 6, plotlyOutput("and.ver"))
                        ))
            ),

          tabPanel("Number of Paid Apps",
                wellPanel(style = "background-color: white;", #ffffff;",
                fluidPage(
                  box(style = "background-color: lightgray;", width = 6, plotlyOutput("apps.by.pay")),
                  box(style = "background-color: lightgray;", width = 6, plotlyOutput("price.range")),
                  box(style = "background-color: lightgray;", width = 12, height ='auto',  plotOutput("type.by.categ.pay"))
                     ))

        ))
        )),


      
      tabItem(
        tabName = "search",
        # box( title = " Filters",
          box(width = 3, height = "100px", background = 'black',
            shinyWidgets::pickerInput( inputId = "categ", 
                                       label = "App Category selection :",   br(),  choices = categ_choices,
                                    multiple = TRUE, selected = categ_choices,
                                    options = list(`actions-box` = TRUE, 
                                                   `size` = 10, `virtual-scroll` = FALSE,
                                                   `selected-text-format` = "count > 3", 
                                                   `live-search` = FALSE, `dropdownAlignRight` = TRUE,
                                                   `data-dropdown-align-right` = TRUE))
                      ), 
          box(width = 3, height = "100px", background = 'black',
            sliderInput( inputId = "rating",  label = "User Rating selection :",
                                       min = 0, max = 5, value = c(0,5), step=0.1, pre=FALSE, dragRange = TRUE)
            ),
        
          box(width = 3, height = "100px", background = 'black',
             
              awesomeRadio( inputId = "pay.type",  label = "Payment Type : \n  ",
                            choices = c("All" = "All", "Free App" = "Free",   "Paid App" = "Paid"),
                            inline = TRUE)
          ),
        
          box(width = 3, height = "100px", background = 'black',
            shinyWidgets::pickerInput( inputId = "install", 
                                       label = "Number of Installed :",   br(),  choices = installed,
                                       multiple = TRUE, selected = installed,
                                       options = list(`actions-box` = TRUE, 
                                                      `size` = 10, `virtual-scroll` = FALSE,
                                                      `selected-text-format` = "count > 3", 
                                                      `live-search` = FALSE, `dropdownAlignRight` = TRUE,
                                                      `data-dropdown-align-right` = TRUE))
        ),
        
        # box(width = 3, height = 230,
        #   title = "Analysis selection",
        #   div(style="display:inline-block",
        #     awesomeRadio("dash_metric",  label = NULL,
        #     choices = c("Apps by category" = "nb.by.categ",   "Apps by Payment type" = "apps.by.pay"),
        #     inline = TRUE  ))),
        
        
        
          box( DT::dataTableOutput("search"), width = 12, options = list(style = 'overflow-x: scroll')     )
      # )
      ),
   ##### SErver로 
               # dash_filters <- reactive({
               #   req(input$categ)
               #   req(nrow(out) > 0)
               #   out
               # })

   
   

   
   
   
   
   #################   
                   

      
      
  
        # fluidRow( valueBoxOutput("value1"), valueBoxOutput("value2"), valueBoxOutput("value3") ),
        

      #       
      
      
                # box(width = 3, height = 230,
                #   title = "Analysis selection",
                #   div(style="display:inline-block",
                #     awesomeRadio("dash_metric",  label = NULL,
                #     choices = c("Apps by category" = "nb.by.categ",   "Apps by Payment type" = "apps.by.pay"),
                #     inline = TRUE  ))),
                # 
                # box( width = 3, height = 370,
                #      title = "Data Filters",
                #      br(),
                #      shinyWidgets::pickerInput( inputId = "categ", label = "App Category selection :", choices = categ_choices,
                #        multiple = TRUE, selected = categ_choices,
                #        options = list(`actions-box` = TRUE, `size` = 10, `virtual-scroll` = FALSE,
                #          `selected-text-format` = "count > 3", `live-search` = FALSE, `dropdownAlignRight` = TRUE,
                #          `data-dropdown-align-right` = TRUE)),
                #      br(),
                #      searchInput( inputId = "categ", label = "App Category search :",
                #      placeholder = "Family",
                #      btnReset = icon("remove"),  btnSearch = icon("search"),  width = "100%"  ) )

      
# 


      tabItem(
        tabName = "data",
              fluidRow(  box(DT::dataTableOutput("table"), width = 12, options = list(style = 'overflow-x: scroll'))
                      )
              )
      )
)))
