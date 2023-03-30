
# Get format for variables
format_variables <- format_table(clean_variables)

# Table stratified by ofi.
levels(format_variables$ofi) <- c("OFI", "No OFI")

## create raw table 1 file
table1 <-
  table1(
    ~ pt_age_yrs + pt_Gender + ISS + ed_rr_value + ed_gcs_sum + ed_sbp_value + ed_emerg_proc + ed_emerg_proc_other + res_survival
    | ofi,
    data = format_variables,
    caption = "Demographic and Clinical Characteristics of patients screened for OFI."
  )

