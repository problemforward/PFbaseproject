# Title: Base Project Setup
# Author: Ken Morales
# Contact: kmorales@problemforward.com
# Date Created: 11.13.2018 
# Purpose: To generate a template for Problem Forward repos with report formatting

# Library
library(devtools)

# Create file folder architecture
directories <- c("data", "data/raw_data", "data/tidy_data", "code", "code/raw_code", "code/final_code", "products")
lapply(directories, dir.create)



# Download template .rmd readme
# url <- "https://github.com/problemforward/base_project/blob/master/README.md"
# destfile <- "README.md"
# download.file(url, destfile)
