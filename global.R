library(shiny)
library(tidyverse)
library(knitr)
library(DT)
library(shinydashboard)
library(markdown)
library(purrr)
library(rlang)
library(htmlwidgets)
library(d3heatmap)

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


#' Scan Repositories
#' Search and scan directories for markdown and RMarkdown files to display
#' @param path Optional path to search from.
#' @note If Path unspecified will recursively scan from the current directory.
#'
#' @return Dataframe of files and directories
#' @export
#'
#' @examples {
#' repos <- scan_repos()
#' }
scan_repos  <- function(path=NULL) {
  if (is.null(path)) { path <- "." }
  files  <- list.files(file.path(path), full.names = TRUE, all.files = TRUE, recursive = TRUE)
  files  <- gsub("\\./", "", files) %>% trimws()
  files  <- files[!(startsWith(files, "."))]
  files  <- files[files != "README.md"]
  files  <- files[endsWith(files, "md")]
  titles <- lapply(files, function(x) readLines(x, n = 1))
  home   <- tibble::tibble(title = "Knowledge Repo", file = "README.md")
  df     <- tibble::tibble(title = titles, file = files)
  file_df          <- rbind(home, df) %>% dplyr::filter(!grepl("/R/", file))
  file_df$title    <- gsub(".*?(\\b[A-Za-z0-9 ]+\\b).*","\\1", file_df$title) %>% trimws()
  file_df$title    <- substr(file_df$title, 1, 25)
  file_df$dir      <- dirname(file_df$file)
  file_df$filename <- basename(file_df$file)
  return(file_df)
}

#' Display Markdown
#' Renders either RMarkdown or Markdown file
#'
#' @param document The document to render
#'
#' @return file
#' @export
#'
#' @examples
#' \dontrun{
#' displayMarkdown("README.md")
#' }
displayMarkdown <- function(document = NULL) {
  if (endsWith(document, ".Rmd")) {
    includeRMarkdown(document)
  } else {
    includeMarkdown(document)
  }
}

getdeps <- function() {
  htmltools::attachDependencies(
    htmltools::tagList(),
    c(
      htmlwidgets:::getDependency("datatables","DT"),
      htmlwidgets:::getDependency("d3heatmap","d3heatmap")
    )
  )
}

file_list  <- scan_repos()
files      <- with(file_list, split(file, title))

