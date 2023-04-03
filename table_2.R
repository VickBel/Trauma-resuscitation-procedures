source("main.R")
library(broom)

# create two models
model1 <- glm(ofi ~ pt_Gender + res_survival + pt_age_yrs + ed_sbp_value + ed_rr_value + ed_gcs_sum + ISS + resuscitation.procedures, data = study.dataset, family = binomial())

model1.table <- tidy(model1, conf.int = TRUE)
saveRDS(model1.table, "model1-table.Rds")
## combine the two models using rbind()
#combined_model <- cbind(summary(model1)$coefficients, summary(model2)$coefficients, summary(model3)$coefficients)

## print the combined model
#model_table <- tbl_regression(combined_model)
#print(model_table)

