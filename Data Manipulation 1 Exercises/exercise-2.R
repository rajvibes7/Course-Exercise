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

adlb <- read.csv("ADLB.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------
# 01. Filter Visits
# Filter to post-baseline visits only
# (AVISITN > 0).
#-----------------------------------------------------------

tfl_step1 <- adlb %>%
  # Your code here
  
  
  #-----------------------------------------------------------
# 02. Filter Tests
# Filter to liver function tests:
# PARAMCD %in% c("ALT", "AST", "BILI").
#-----------------------------------------------------------

tfl_step2 <- tfl_step1 %>%
  # Your code here
  
  
  #-----------------------------------------------------------
# 03. Group Data
# Group by:
# Treatment group (TRTGRP),
# Parameter (PARAMCD),
# Visit (AVISITN).
#-----------------------------------------------------------

tfl_step3 <- tfl_step2 %>%
  # Your code here
  
  
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
  
  
  #-----------------------------------------------------------
# 05. Handle Missing Values
# Ensure proper handling of missing values
# (e.g., using na.rm = TRUE).
#-----------------------------------------------------------

tfl_step5 <- tfl_step4 %>%
  # Your code here
  
  
  #-----------------------------------------------------------
# 06. Drop Grouping
# Remove grouping structure after summarization
# (using .groups = "drop").
#-----------------------------------------------------------

tfl_final <- tfl_step5 %>%
  # Your code here
  
  
  #-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
