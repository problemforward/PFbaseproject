#' Creates the standard Problem Forward infrastructure for a new project.
#'
#' After creating a repo on GitHub and cloning it to your session, use this
#' function to create the basic repo infrastructure for a project in that
#' project's working directory.
#'
#' @export
#'
#' @examples
#' TBD.

newproject <- function(){
    # Create file folder architecture
    directories <- c("data", "data/raw_data", "data/tidy_data", "code", "code/raw_code", "code/final_code", "products")
    lapply(directories, dir.create)

    # Create .gitignore
    gi <- c(".Rproj.user",
            ".Rhistory",
            ".RData",
            ".Ruserdata",
            ".httr-oauth",
            "token.rds",
            "gs_token.rds",
            "googlesheets_token.rds")
    writeLines(gi,
               con = ".gitignore")

    # Download template .rmd readme
    url <- "https://github.com/problemforward/base_project/blob/master/README.md"
    destfile <- "README.md"
    download.file(url, destfile)
  }
