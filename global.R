library(shiny)
library(tidyverse)
library(knitr)
library(DT)
library(shinydashboard)
library(markdown)
library(purrr)
library(rlang)

## options for knitting/rendering rmarkdown chunks
knitr::opts_chunk$set(echo = FALSE, comment = NA, cache = FALSE,
                      message = FALSE, warning = FALSE)

## function to render .md files to html
includeMd <- function(path) {
  markdown::markdownToHTML(path, fragment.only = TRUE, options = "", stylesheet = "")
}


includeRMarkdown <- function(path, r_env = parent.frame()) {
  paste(readLines(path, warn = FALSE), collapse = '\n') %>%
    knitr::knit2html(text = ., fragment.only = TRUE, envir = r_env,  options = "",
                     stylesheet = "") %>%
    gsub("&lt;!--/html_preserve--&gt;","",.) %>%  ## knitr adds this
    gsub("&lt;!--html_preserve--&gt;","",.) %>%   ## knitr adds this
    HTML
}

## make html table
make_table <- function(dat, width = "50%") {
  knitr::kable(dat, align = "c", format = "html",
               table.attr = paste0("class='table table-condensed table-hover' style='width:", width, ";'"))
}


load_repo  <- function() {
  files <- list.files(file.path("."), full.names = TRUE, all.files = TRUE, recursive = TRUE)
  files       <- gsub("\\./", "", files) %>% trimws()
  files       <- files[!(startsWith(files, "."))]
  files       <- files[files != "README.md"]
  files       <- files[endsWith(files, "md")]
  titles      <- lapply(files, function(x) readLines(x, n = 1))
  home        <- tibble(title = "Knowledge Repo", file = "README.md")
  df          <- tibble(title = titles, file = files)
  df          <- rbind(home, df)
  df$title    <- gsub("#", "", df$title) %>% trimws()
  df$directory <- dirname(df$file)
  df$filename <- basename(df$file)
  return(df)
}

get_details <- function(markdown = NULL) {
  if (endsWith(markdown, ".Rmd")) {
    includeRMarkdown(markdown)
  } else {
    includeMarkdown(markdown)
  }
}

getdeps <- function() {
  htmltools::attachDependencies(
    htmltools::tagList(),
    c(
      htmlwidgets:::getDependency("functionplot","functionplotR"),
      htmlwidgets:::getDependency("datatables","DT"),
      htmlwidgets:::getDependency("d3heatmap","d3heatmap")
    )
  )
}

file_list  <- load_repo()
files      <- with(file_list, split(file, title))

