#-----------------------------------------------------------
# Exercise 2: Transpose for Table
#-----------------------------------------------------------

# Starting dataset: ADVS (long format)

# Goal:
# Rows    → Treatment groups (TRT01A)
# Columns → Visit (AVISIT)
# Values  → Mean AVAL for SYSBP
# Use group_by() + summarise() + pivot_wider()

# Load libraries
library(dplyr)
library(tidyr)
library(haven)

getwd()
setwd("D:/R training/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData")

#-----------------------------------------------------------
# 0. Read ADVS dataset
#-----------------------------------------------------------

adsl <- read_xpt("ADAM/ADSL.XPT")
advs0 <- read_xpt("SDTM/VS.XPT")

advs <- adsl |>
  inner_join(advs0, by = "USUBJID")

#-----------------------------------------------------------
# 1. Filter Parameter
# Keep only SYSBP records
# using PARAMCD or VSTESTCD (as applicable).
#-----------------------------------------------------------

step1 <- advs %>%
  # Your code here
  filter(VSTESTCD == "SYSBP")
  
  #-----------------------------------------------------------
# 2. Group Data
# Group by:
# Treatment group (TRT01A)
# Visit (AVISIT)
#-----------------------------------------------------------

step2 <- step1 %>%
  # Your code here
  group_by(TRT01A, VISIT)
  
  #-----------------------------------------------------------
# 3. Calculate Mean AVAL
# Calculate mean of AVAL
# for each TRT01A + AVISIT group.
#-----------------------------------------------------------

step3 <- step2 %>%
  # Your code here
  summarise(
    MEAN_AVAL = mean(VSSTRESN, na.rm = TRUE),
    .groups = "drop"
  )
  
  
  #-----------------------------------------------------------
# 4. Transpose to Wide Format
# Create wide table:
# Rows    → TRT01A
# Columns → AVISIT
# Values  → Mean AVAL
# Use pivot_wider().
#-----------------------------------------------------------

tfl_table <- step3 %>%
  # Your code here
  pivot_wider(
    names_from = VISIT,
    values_from = MEAN_AVAL
  )
  
  
  #-----------------------------------------------------------
# 5. Final Table Output
# Review the transposed table.
#-----------------------------------------------------------

# Your code here

View(tfl_table)

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
