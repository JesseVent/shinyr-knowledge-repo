library(shiny)
library(shinydashboard)
shinyServer(function(input, output, session) {
  tab_list <- NULL

#   ____________________________________________________________________________
#   OUTPUTS                                                                 ####

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

  output$repos <- renderUI({
    sidebarMenu(
      id = "repotabs",
      lapply(names(files), function(i) {
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

#   ____________________________________________________________________________
#   EVENTS                                                                  ####

  observeEvent(input$repotabs, {
    mdinput <- input$repotabs
    mdfile <- file_list$file[file_list$title == mdinput]
    tab_title <- file_list$title[file_list$title == mdinput]
    # tab_title <- readLines(mdfile, n = 1)
    if (!(tab_title %in% tab_list)) {
      appendTab(
        inputId = "tabs",
        tabPanel(
          tab_title,
          renderUI(get_details(mdfile))
        )
      )

      tab_list <<- c(tab_list, tab_title)
    }
    updateTabsetPanel(session, "tabs", selected = tab_title)
  })

  observeEvent(input$remove, {
    tab_list %>%
      walk(~removeTab("tabs", .x))
    tab_list <<- NULL
  })
})
