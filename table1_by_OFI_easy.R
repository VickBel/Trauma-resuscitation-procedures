# Define variables to extract and rename
vars_to_extract <- c("pt_age_yrs", "Gender", "ed_sbp_value", "ed_rr_value", "ed_gcs_sum", "ISS", "ed_emerg_proc", "ed_emerg_proc_other", "ofi")
vars_to_rename <- c("Age", "Gender", "SBP", "RR", "GCS", "Injury_Severity_Score", "Emergency_Procedure", "Other_Emergency_Procedure", "OFI")

# Define new categories for Emergency_Procedure and Other_Emergency_Procedure
emergency_categories <- c("Thoracotomy", "Laparotomy - hemostasis", "Pelvic packing", "Revascularization (including surgery for pulseless extremity)", "Radiological intervention (Endovascular=embolization, stent, stent graft)", "Craniotomy", "Intracranial pressure measurement as sole intervention", "Other intervention", "No acute intervention performed", "Unknown")
other_emergency_categories <- c("Thoracic drainage", "External fixation of fracture", "Major fracture surgery", "Surgical wound revision", "Other intervention")

# Extract variables by name and rename them
table_one <- combined.dataset %>%
  select(all_of(vars_to_extract)) %>%
  rename_all(~vars_to_rename)

# Remove rows with missing values
table_one <- table_one %>% 
  drop_na()

# Recode Gender and Emergency_Procedure to character values
table_one$Gender <- factor(table_one$Gender, labels = c("Female", "Male"))
table_one$Emergency_Procedure <- as.character(table_one$Emergency_Procedure)

# Recode Emergency_Procedure and Other_Emergency_Procedure to new categories
table_one$Emergency_Procedure <- factor(table_one$Emergency_Procedure, levels = unique(table_one$Emergency_Procedure), labels = emergency_categories)
table_one$Other_Emergency_Procedure <- factor(table_one$Other_Emergency_Procedure, levels = unique(table_one$Other_Emergency_Procedure), labels = other_emergency_categories)

# Create table
table1 <- tbl_summary(
  data = table_one, 
  by = OFI, 
  include = all_of(vars_to_rename[-9]),
  label = list(OFI = "OFI"),
  missing = "no"
)

# Print table
print(table1, smd = TRUE)
