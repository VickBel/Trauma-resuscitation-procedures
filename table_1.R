
## Get format for variables
study.dataset <- format_table(study.dataset)

## Table stratified by ofi.
study.dataset$ofi <- factor(study.dataset$ofi, levels = c("Yes", "No"), labels = c("OFI", "No OFI"))

## Create table 1
table1 <- study.dataset %>%
    select(pt_age_yrs, 
           pt_Gender, 
           ISS, 
           ed_rr_value, 
           ed_gcs_sum, 
           ed_sbp_value, 
           resuscitation.procedures, 
           res_survival,
           ofi) %>%
    tbl_summary(by = "ofi") %>%
    add_p(test.args = all_categorical() ~ list(simulate.p.value = TRUE)) %>%
    add_overall() %>%
    bold_labels %>%
    as_tibble() %>%
    replace(is.na(.), "")


## Save to disk and compile as word document
saveRDS(table1, "table1.Rds")
write(kable(table1, format = "pandoc"), "table1.Rmd")
rmarkdown::render("table1.Rmd", output_format = "word_document")

