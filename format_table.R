## change "labels" for columns -> better outputs in tables

format_table <- function(data) {

    ## "res_survival"
    data$res_survival <- factor(
        data$res_survival,
        levels = c(1, 2),     
        labels = c("Dead", "Alive"))

    ##"pt_Gender"              
    data$pt_Gender <- factor(
        data$pt_Gender,
        levels = c(2, 1),
        labels = c("Female", "Male"))

    ## ed_emerg_proc_other
    data$ed_emerg_proc_other <- factor(
        data$ed_emerg_proc_other,
        levels = c(1, 2, 3, 4, 5), 
        labels = c("Thoracic drainage",
                   "External fracture fixation",
                   "Major fracture surgery",
                   "Surgical wound revision",
                   "Other intervention")) 

    ## "ed_emerg_proc" 
    data$ed_emerg_proc <- factor(
        data$ed_emerg_proc,
        levels = c(1, 2, 3, 4, 5, 6, 7, 8), # exclusion of 8, 99, 999 (8 - "Other intervention" removed since they are present in ed_emerg_proc_other)
        labels = c("Thoracotomy",
                   "Laparotomy - hemostasis",
                   "Pelvic packing",
                   "Revascularization",
                   "Radiological intervention",
                   "Craniotomy",
                   "Intracranial pressure measurement as sole intervention",
                   "Other intervention")) 
    
    ## Merge ed_emerg_proc_other and ed_emerg_proc
    resuscitation.procedures <- as.character(data$ed_emerg_proc)
    index <- resuscitation.procedures == "Other intervention" & !is.na(resuscitation.procedures)
    resuscitation.procedures[index] <- as.character(data$ed_emerg_proc_other[index])
    resuscitation.procedures <- factor(resuscitation.procedures, levels = c(sort(unique(resuscitation.procedures)), "None"))
    resuscitation.procedures[is.na(resuscitation.procedures)] <- "None"
    data$resuscitation.procedures <- factor(resuscitation.procedures, levels = unique(resuscitation.procedures))
    
    ##Requires library(labelled)
    var_label(data) <- list(
        ofi = "Opportunity for improvement",
        ed_gcs_sum = "GCS",
        ed_sbp_value = "Systolic Blood Pressure",
        pt_age_yrs = "Age",
        ed_rr_value = "Respiratory rate",
        ISS = "Injury severity score (ISS)",
        pt_Gender = "Gender",
        resuscitation.procedures = "Resuscitation procedure",
        res_survival = "Mortality (within 30 days)"
    ) 

    data_format <- data
    return(data_format)

}



