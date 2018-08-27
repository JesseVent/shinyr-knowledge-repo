library(shiny)
library(shinydashboard)
shinyServer(function(input, output, session) {
  tab_list <- NULL

#   ____________________________________________________________________________
#   OUTPUTS                                                                 ####

reactiveFiles =  reactive({
   file_data <- scan_repos()
   return(file_data)
  })

files = reactive({
  filesData <- reactiveFiles()
  files <- with(filesData, split(file, title))
  return(files)
})

  output$repos <- renderUI({
    sidebarMenu(
      id = "repotabs",
      lapply(names(files()), function(i) {
        menuItem(i,
          tabName = i,
          icon = icon("chevron-right")
        )
      })
    )
  })

  output$intro <- renderUI({
    includeMarkdown("README.md")
  })

  output$ui_line <- renderUI({
    ## using renderUI here because Knitr will not create a slider
    tagList(
      sliderInput("nr_points", "", min = 10, max = 100, value = 50),
      renderPlot({
        nr <- if (is.null(input$nr_points)) 2 else input$nr_points
        plot(1:nr, rnorm(nr))
      })
    )
  })

#   ____________________________________________________________________________
#   EVENTS                                                                  ####

  observeEvent(input$searchButton, {
    if(input$searchButton > 0L) {
      isolate({
        file_data <- reactiveFiles()
        file_data <- file_data %>% dplyr::filter(grepl(input$searchText, title))
        return(file_data)
      })
    }
  })

  # Render Markdown Files In New Tab
  observeEvent(input$repotabs, {
    mdinput <- input$repotabs
    mdfile <- reactiveFiles()$file[reactiveFiles()$title == mdinput]
    tab_title <- reactiveFiles()$title[reactiveFiles()$title == mdinput]
    if (!(tab_title %in% tab_list)) {
      appendTab(
        inputId = "tabs",
        tabPanel(
          tab_title,
          renderUI(displayMarkdown(mdfile))
        )
      )

      tab_list <<- c(tab_list, tab_title)
    }
    updateTabsetPanel(session, "tabs", selected = tab_title)
  })


  # Remove tabs
  observeEvent(input$remove, {
    tab_list %>%
      walk(~removeTab("tabs", .x))
    tab_list <<- NULL
  })
})
