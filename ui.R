library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(
    tags$div(id = "header", tags$h2("Knowledge Repo"),
             sidebarSearchForm(label = "Search Repos", "searchText", "searchButton")
             ),
  tags$h4("Repositories"),
    uiOutput("repos"),
    actionLink("remove", "Remove repo tabs", icon = icon("remove"))
  ),
  dashboardBody(
    skin = "black",
    tags$script(
      HTML("var openTab = function(tabName){ $('a', $('.sidebar')).each(function() {if(this.getAttribute('data-value') == tabName) { this.click()};});}")
    ),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css?family=Muli|Work+Sans"),
      tags$link(rel = "stylesheet", type = "text/css", href = "theme.css")
    ),
    tabsetPanel(
      id = "tabs",
      tabPanel(
        title = "README",
        value = "intro",
        uiOutput("intro")
      )
    ),
    getdeps()
  )
)
