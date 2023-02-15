
library(tidyverse)
library(rofi)
library(bookdown)
library(dplyr)
library(noacsr)
library(ggplot2)
library(DiagrammeR) 
library(table1)
library(rsvg)

data <- rofi::import_data(test = TRUE)
names <- c("swetrau","fmp","atgarder","problem","kvalgranskning2014.2017")
names(data) <- names

## Merge data
combined.dataset <- rofi::merge_data(data)

## Create OFI column
combined.dataset$ofi <- rofi::create_ofi(combined.dataset)
combined.dataset <- clean_audit_filters(combined.dataset)

## Separate and store cases without known outcome (OFI)
missing.outcome <- is.na(combined.dataset$ofi)
combined.dataset <- combined.dataset[!missing.outcome,]

## remove patients < 15 years
combined.dataset <- combined.dataset[combined.dataset$pt_age_yrs > 14,]

## Fix formating and remove wrong values like 999
combined.dataset <- clean_all_predictors(combined.dataset)

## clean Audit filters
combined.dataset <- clean_audit_filters(combined.dataset)
#Do we need to run this a second time?


## Create a flow chart (Saves it as a pdf)
#create_flowchart(combined.dataset, na.data = "")

## Create a flow chart (Saves it as a pdf)
create_flowchart(combined.dataset)

##Hämar alla columner
#colnames(combined.dataset)
#Hamtar det kolumner hag ber om
##bantad.dataset <- combined.dataset[,c("ed_emerg_proc", "pt_age")]

