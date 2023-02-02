
library("tidyverse")
library(rofi)
library(bookdown)
library(dplyr)
library(noacsr)

data <- rofi::import_data(test = TRUE)
names <- c("swetrau","fmp","atgarder","problem","kvalgranskning2014.2017")
names(data) <- names
combined.dataset <- rofi::merge_data(data)
combined.dataset <- clean_all_predictors(combined.dataset)

## Create OFI column
combined.dataset$ofi <- rofi::create_ofi(combined.dataset)





