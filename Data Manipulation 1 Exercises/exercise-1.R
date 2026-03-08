#-----------------------------------------------------------
# Exercise 1: Derive ADLB from SDTM LB
#-----------------------------------------------------------

# Load libraries
library(dplyr)
library(haven)

getwd()
setwd("D:/R training/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData")

#-----------------------------------------------------------
# 0. Read SDTM LB and ADSL datasets
#-----------------------------------------------------------

lb   <- read_xpt("sdtm/LB.XPT")
adsl <- read_xpt("ADAM/ADSL.XPT")

#-----------------------------------------------------------
# 01. Select Variables
# Select only essential variables:
# STUDYID, USUBJID, LBTEST, LBSTRESN,
# LBSTRESU, LBDTC, VISITNUM.
#-----------------------------------------------------------

adlb_step1 <- lb %>%
  # Your code here
   inner_join(adsl, by="USUBJID")
  
  #-----------------------------------------------------------
# 02. Filter Data
# Filter to Safety Population (SAFFL == "Y")
# and non-missing results.
#-----------------------------------------------------------

adlb_step2 <- adlb_step1 %>%
  # Your code here
  filter(SAFFL == "Y" & !is.na(LBSTRESN))
  
  #-----------------------------------------------------------
# 03. Create PARAMCD
# Create PARAMCD from LBTEST:
# "Alanine Aminotransferase" → "ALT"
# "Aspartate Aminotransferase" → "AST"
# "Bilirubin" → "BILI"
#-----------------------------------------------------------

adlb_step3 <- adlb_step2 %>%
  # Your code here
  mutate(
  paramcd = case_when(
  toupper(LBTEST) == "ALANINE AMINOTRANSFERASE" ~ "ALT",
  toupper(LBTEST) == "ASPARTATE AMINOTRANSFERASE" ~ "AST",
  toupper(LBTEST) == "BILIRUBIN" ~ "BILI",
  TRUE ~ NA_character_
  ))
  
  #-----------------------------------------------------------
# 04. Create AVAL
# Create AVAL from LBSTRESN
# (numeric analysis value).
#-----------------------------------------------------------

adlb_step4 <- adlb_step3 %>%
  # Your code here
  mutate(AVAL = as.numeric(LBSTRESN))
  
  #-----------------------------------------------------------
# 05. Create AVISITN
# Create AVISITN from VISITNUM.
#-----------------------------------------------------------

adlb_step5 <- adlb_step4 %>%
  # Your code here
  mutate(AVISITN = as.numeric(VISITNUM))
  
  #-----------------------------------------------------------
# 06. Derive ABLFL
# Derive baseline flag (ABLFL)
# where VISITNUM == 0.
#-----------------------------------------------------------

adlb_step6 <- adlb_step5 %>%
  # Your code here
  arrange(USUBJID, LBTESTCD, LBDTC, VISITNUM) |>
  group_by(USUBJID, LBTESTCD) |>
  mutate(
    is_last = row_number() == n(),
    ABLFL = if_else(
      is_last & !is.na(AVAL) & !is.na(LBDTC) &
        !is.na(TRTSDT) & LBDTC <= TRTSDT,
      "Y",
      NA_character_
    )
  ) 
  
  
  #-----------------------------------------------------------
# 07. Calculate BASE
# Calculate baseline value (BASE)
# for each USUBJID and PARAMCD.
#-----------------------------------------------------------

baseline <- adlb_step6 %>%
  # Your code here
  group_by(USUBJID, LBTESTCD) |>
  mutate(
    BASE = if_else(ABLFL == "Y", AVAL, NA_real_)
  ) |>
  fill(BASE)
  
  #adlb_step7 <- adlb_step6 %>%
  adlb_step7 <- baseline
  # Your code here
  
  
  #-----------------------------------------------------------
# 08. Calculate CHG
# Calculate change from baseline
# (CHG = AVAL - BASE).
#-----------------------------------------------------------

adlb_final <- adlb_step7 %>%
  # Your code here
   mutate(CHG  = if_else(!is.na(AVAL) & !is.na(BASE),
                     AVAL - BASE,
                     NA_real_)
   )
  
  
  #-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
