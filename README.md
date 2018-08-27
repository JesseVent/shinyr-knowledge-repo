# The Knowledge Repo

## The **shinyR** curated knowledge sharing platform

![](/www/1.png)

### Introduction

Built in R with use of the [Shiny](https://github.com/rstudio/shiny) package, this application will list any `RMarkdown.Rmd` or `Markdown.md` that sit under the specified/default directory no matter how many folders there are underneath. By listing all these files you get a true sense of the knowledge collective available to you, and by clicking any of the files listed it will dynamically load the content in a new tab for your viewing pleasure.

Through the reticulate package it can even run embedded python chunks inside `RMarkdown.Rmd` files.

![](/www/2.png)

### Inspiration

This application is loosely inspired from a mix of the principles of [Airbnb's Knowledge Repo](https://github.com/airbnb/knowledge-repo) and the user interface from [GetGrav's Learn2](https://github.com/getgrav/grav-theme-learn2) with my own spin on my thought's about what a knowledge repo should be, combined with some functionality that **Shiny** brings together so well.

> The Knowledge Repo project is focused on facilitating the sharing of knowledge between data scientists and other technical roles using data formats and tools that make sense in these professions. It provides various data stores (and utilities to manage them) for "knowledge posts", with a particular focus on notebooks (R Markdown and Jupyter / IPython Notebook) to better promote reproducible research. [^59f65d82]

[^59f65d82]&#x3A; [As Airbnb capture perfectly on their page](https://github.com/airbnb/knowledge-repo)

![](/www/3.png)

### Usage

The following dependencies are required.

```R
pkgs <- c('shiny', 'tidyverse', 'knitr', 'DT', 'shinydashboard', 'markdown', 'purrr', 'rlang', 'functionplotR', 'd3heatmap')
install.packages(pkgs)

# Clone the github repo and then use `RunApp()`
```

The default is to list any markdown files sitting in the source folder, or beneath it. This can easily be changed to look at any directory you wish by providing the path of the directory you wish to use.

Just change the following in the server.R file.

##### server.R

```R
reactiveFiles =  reactive({
   file_data <- scan_repos('~/Add-Path-Here')
   return(file_data)
  })
```

The titles that display in the sidebar are equivalent to the first line in the markdown file, so for consistent experience please align the files to conform to the following standard:

##### Example.Md

    # MARKDOWN HEADER

    ## Subtitle
    <Rest of your content>

![](/www/1.png)

## Next Steps

This application is still in it's infancy, but the next major change I want to make is to allow the application to be given a Gitlab project, and allow you to view all the markdown files that sit in sub-projects beneath it.

Happy for any other feedback or thoughts.

## The Key Principles

-   **Reproducibility** There should be no opportunity for code forks. The entire set of queries, transforms, visualizations, and write-up should be contained in each contribution and be up to date with the results.
-   **Quality** No piece of research should be shared without being reviewed for correctness and precision.
-   **Consumability** The results should be understandable to readers besides the author. Aesthetics should be consistent and on brand across research.
-   **Discoverability** Anyone should be able to find, navigate, and stay up to date on the existing set of work on a topic.
-   **Learning** In line with reproducibility, other researchers should be able to expand their abilities with tools and techniques from others’ work.
