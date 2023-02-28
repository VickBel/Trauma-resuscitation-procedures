# Extract variables by name
#
# JA: Lägger till mortalitet: res_survival
#
# Behöver också lite styling paket
# install.packages("kableExtra")
#
library(kableExtra)
table_one <- combined.dataset %>%
  select(pt_age_yrs, Gender, ed_sbp_value, ed_rr_value, ed_gcs_sum, ISS, ed_emerg_proc, ed_emerg_proc_other, res_survival ,ofi)

# Remove patients with missing values
table_one <- table_one[complete.cases(table_one), ]


# Rename variables
table_one <- table_one %>% 
  rename(Age = pt_age_yrs,
         Gender = Gender,
         SBP = ed_sbp_value,
         RR = ed_rr_value,
         GCS = ed_gcs_sum,
         Injury_Severity_Score = ISS,
         Emergency_Procedure = ed_emerg_proc,
         Other_Emergency_Procedure = ed_emerg_proc_other,
         OFI = ofi,
         Mortality = res_survival)

# Recode gender to character values
table_one$Gender <- factor(table_one$Gender, labels = c("Female", "Male"))

# Change Mortality values
table_one$Mortality <- factor(table_one$Gender, labels = c("Dead", "Alive"))

# Recode Emergency_Procedure to character values
table_one$Emergency_Procedure <- as.character(table_one$Emergency_Procedure)

# Recode Emergency_Procedure to new categories
table_one$Emergency_Procedure <- case_when(
  table_one$Emergency_Procedure == 1 ~ "Thoracotomy",
  table_one$Emergency_Procedure == 2 ~ "Laparotomy - hemostasis",
  table_one$Emergency_Procedure == 3 ~ "Pelvic packing",
  table_one$Emergency_Procedure == 4 ~ "Revascularization (including surgery for pulseless extremity)",
  table_one$Emergency_Procedure == 5 ~ "Radiological intervention (Endovascular=embolization, stent, stent graft)",
  table_one$Emergency_Procedure == 6 ~ "Craniotomy",
  table_one$Emergency_Procedure == 7 ~ "Intracranial pressure measurement as sole intervention",
  table_one$Emergency_Procedure == 8 ~ "Other intervention",
  table_one$Emergency_Procedure == 99 ~ "No acute intervention performed",
  table_one$Emergency_Procedure == 999 ~ "Unknown",
  TRUE ~ as.character(table_one$Emergency_Procedure)
)

# Recode Other_Emergency_Procedure to new categories
table_one$Other_Emergency_Procedure <- case_when(
  table_one$Other_Emergency_Procedure == 1 ~ "Thoracic drainage",
  table_one$Other_Emergency_Procedure == 2 ~ "External fixation of fracture",
  table_one$Other_Emergency_Procedure == 3 ~ "Major fracture surgery",
  table_one$Other_Emergency_Procedure == 4 ~ "Surgical wound revision",
  table_one$Other_Emergency_Procedure == 5 ~ "Other intervention",
  TRUE ~ as.character(table_one$Other_Emergency_Procedure)
)

# Create table
#table1 <- tbl_summary(data = table_one, 
#                      by = OFI, 
#                      include = c(Age, Gender, SBP, RR, GCS, Injury_Severity_Score, 
#                                  Emergency_Procedure, Other_Emergency_Procedure),
#                      label = list(OFI = "OFI"),
#                      missing = "no")

# Print table
#print(table1, smd = TRUE)

######################
# Start of JA:s code #
######################

###############################################
#<!--Prepare dataset for tables / Table 1 --> #
###############################################


#
# Om du vill använda funktionen format_table1() så kan du göra det enligt neda,
# den ändrar namnen på både tabeller och rader enligt mitt utkast. Men din kod ovan gör liknande
#
#table_one <- format_table1(table_one)

table1.dpc <- table_one
### Här väljer du vad dina två kollumner ska heta
 
levels(table1.dpc$OFI) <- c("OFI", "No OFI")
##############
### Table 1 ##
##############


## create raw table 1 file
table1 <-
  table1(
    ~ Age + Gender + Mortality + Injury_Severity_Score + RR + GCS + SBP + Emergency_Procedure + Other_Emergency_Procedure
    | OFI,
    data = table1.dpc,
    caption = "Demographic and Clinical Characteristics of patients screened for OFI."
 )

