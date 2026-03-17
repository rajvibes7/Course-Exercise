#-----------------------------------------------------------
# Exercise 2: Create Summary Statistics for TFL
# Using ADLB Dataset
#-----------------------------------------------------------

# Load library
library(dplyr)
library(haven)
#-----------------------------------------------------------
# 0. Read ADLB dataset
#-----------------------------------------------------------

getwd()
setwd("D:/R training/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData")

adlb <- read_xpt("ADAM/ADLBC.XPT")

data.frame(AVISIT = unique(adlb$AVISIT))
#-----------------------------------------------------------
# 01. Filter Visits
# Filter to post-baseline visits only
# (AVISITN > 0).
#-----------------------------------------------------------

tfl_step1 <- adlb %>%
  # Your code here
  filter(AVISITN > 0)
  
  
  #-----------------------------------------------------------
# 02. Filter Tests
# Filter to liver function tests:
# PARAMCD %in% c("ALT", "AST", "BILI").
#-----------------------------------------------------------

tfl_step2 <- tfl_step1 %>%
  # Your code here
  filter(PARAMCD %in% c("ALT", "AST", "BILI"))
  
  
  #-----------------------------------------------------------
# 03. Group Data
# Group by:
# Treatment group (TRTGRP),
# Parameter (PARAMCD),
# Visit (AVISITN).
#-----------------------------------------------------------

tfl_step3 <- tfl_step2 %>%
  # Your code here
  group_by(TRTPN, PARAMCD, AVISITN)
  
  #-----------------------------------------------------------
# 04. Calculate Statistics
# Calculate the following:
# N (number of subjects)
# Mean of AVAL
# Standard Deviation of AVAL
# Median of AVAL
# Min of AVAL
# Max of AVAL
# Mean of CHG (change from baseline)
#-----------------------------------------------------------

tfl_step4 <- tfl_step3 %>%
  # Your code here
  summarise(
    N      = sum(!is.na(USUBJID)),
    MEAN   = mean(AVAL, na.rm = TRUE),
    SD     = sd(AVAL, na.rm = TRUE),
    MEDIAN = median(AVAL, na.rm = TRUE),
    MAX    = max(AVAL, na.rm = TRUE),
    MIN    = min(AVAL, na.rm = TRUE),
    MEAN_CHG = mean(CHG, na.rm = TRUE)
  ) 
  
  #-----------------------------------------------------------
# 05. Handle Missing Values
# Ensure proper handling of missing values
# (e.g., using na.rm = TRUE).
#-----------------------------------------------------------

tfl_step5 <- tfl_step4 
  # Your code here
  
  
  #-----------------------------------------------------------
# 06. Drop Grouping
# Remove grouping structure after summarization
# (using .groups = "drop").
#-----------------------------------------------------------

tfl_final <- tfl_step5 %>%
  # Your code here
  summarise(.groups = "drop")
  
  #-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
