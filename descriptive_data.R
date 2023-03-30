
source("main.R")

# Patients before exclusion
total_pts <- as.numeric(nrow(variables))

# Get excluded patients due to missing data, total
excluded_pts = nrow(variables) - nrow(variables[complete.cases(variables),])

# Patients after exclusion
df <- clean_variables
# Calculate summary statistics
  a <- df %>%
  summarize(
    # Percentage of males and females
    male_pct = mean(df$pt_Gender == levels(df$pt_Gender)[1]) * 100,
  
    age_mean = mean(df$pt_age_yrs),
    age_median = median(df$pt_age_yrs),

    sbp_mean = mean(df$ed_sbp_value),
    sbp_median = median(df$ed_sbp_value),

    rr_mean = mean(df$ed_rr_value),
    rr_median = median(df$ed_rr_value),
  
    gcs_mean = mean(df$ed_gcs_sum),
    gcs_median = median(df$ed_gcs_sum),

    iss_mean = mean(df$ISS),
    iss_median = median(df$ISS),
    # Percentage of patients who survived
    alive_pct = mean(df$res_survival == levels(df$res_survival)[2]) * 100,
    # Percentage of patients who had a positive outcome (ofi = 1)
    ofi_yes_pct = mean(df$ofi == levels(df$ofi)[1]) * 100,
    # total patients with ofi
    ofi_yes_count = sum(df$ofi == levels(df$ofi)[1])
  )
  
  
# Association between ed_emerg_proc_other and ofi
  table(df$ed_emerg_proc_other, df$ofi)
  
  
#########
# Association between ed_emerg_proc and ofi
  table(df$ed_emerg_proc, df$ofi)
df_summary <- df %>% 
  mutate(ofi = as.numeric(ofi)) %>% 
  group_by(ed_emerg_proc) %>% 
  summarize(total_ofi = sum(ofi, na.rm = TRUE)) %>% 
  arrange(desc(total_ofi))

ed_emerg_proc_1 <- df_summary$ed_emerg_proc[1]
total_ofi_1 <- df_summary$total_ofi[1]
total_ofi_1
ed_emerg_proc_1
ed_emerg_proc_2 <- df_summary$ed_emerg_proc[2]
total_ofi_2 <- df_summary$total_ofi[2]
total_ofi_2
ed_emerg_proc_3 <- df_summary$ed_emerg_proc[3]
total_ofi_3 <- df_summary$total_ofi[3]
total_ofi_3
if(total_ofi_1 == total_ofi_2 | total_ofi_1 == total_ofi_3 | total_ofi_2 == total_ofi_3){
  warning("Two or more total_ofi values are the same")
}
