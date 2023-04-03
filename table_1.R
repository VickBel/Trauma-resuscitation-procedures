
# Get format for variables
study.dataset <- format_table(study.dataset)

# Table stratified by ofi.
study.dataset$ofi <- factor(study.dataset$ofi, levels = c("Yes", "No"), labels = c("OFI", "No OFI"))

## create raw table 1 file
table1 <-
    as.data.frame(table1(
    ~ pt_age_yrs + pt_Gender + ISS + ed_rr_value + ed_gcs_sum + ed_sbp_value + resuscitation.procedures + res_survival
    | ofi,
    data = study.dataset,
    caption = "Demographic and Clinical Characteristics of patients screened for OFI."
    ))

saveRDS(table1, "table1.Rds")

