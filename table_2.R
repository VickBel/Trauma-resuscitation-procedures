source("main.R")
library(gtsummary)

# Create a data frame with the variables of interest, 
df <- clean_variables

# create two models
model1 <- glm(ofi ~ pt_Gender + res_survival + pt_age_yrs + ed_sbp_value + ed_rr_value + ed_gcs_sum + ISS, data = df, family = binomial())
model2 <- glm(ofi ~ ed_emerg_proc_other, data = df, family = binomial())
model3 <- glm(ofi ~ ed_emerg_proc, data = df, family = binomial())

model1_table <- tbl_regression(model1)
model1_table
model2_table <- tbl_regression(model2)
model2_table
model3_table <- tbl_regression(model3)
model3_table

## combine the two models using rbind()
#combined_model <- cbind(summary(model1)$coefficients, summary(model2)$coefficients, summary(model3)$coefficients)

## print the combined model
#model_table <- tbl_regression(combined_model)
#print(model_table)

