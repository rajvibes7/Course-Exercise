#-----------------------------------------------------------
# Exercise 1: Multi-Domain Join
#-----------------------------------------------------------

# You have:
# ADSL → USUBJID, SAFFL, TRT01A
# VS   → USUBJID, VSTESTCD, VSSTRESN, VISITNUM

# Load library
library(dplyr)
library(lubridate)
library(tidyverse)
library(haven)

getwd()
setwd("D:/R training/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData")

#-----------------------------------------------------------
# 0. Read ADSL and VS datasets
#-----------------------------------------------------------

adsl <- read_xpt("ADAM/ADSL.XPT") |>
  filter(SAFFL == "Y") |>
  select(USUBJID, SAFFL, TRT01A)

vs   <- read_xpt("SDTM/VS.XPT")

#-----------------------------------------------------------
# 1. Check Row Counts Before Join
# Check number of rows in ADSL and VS
# before performing the join.
#-----------------------------------------------------------

# Your code here

before <- vs |>
  summarise(
    bfore_cnt = sum(!is.na(USUBJID)))

#-----------------------------------------------------------
# 2. Join ADSL Population Flags onto VS
# Join SAFFL and TRT01A from ADSL to VS
# using USUBJID.
#-----------------------------------------------------------

vs_joined <-
  # Your code here
  inner_join(adsl, vs, by = "USUBJID") 

  
  #-----------------------------------------------------------
# 3. Filter to Safety Population Only
# Keep records where SAFFL == "Y".
#-----------------------------------------------------------

vs_safety <- vs_joined 
  # Your code here
  
  
  #-----------------------------------------------------------
# 4. Keep Only Required Parameters
# Keep only:
# SYSBP (Systolic Blood Pressure)
# DIABP (Diastolic Blood Pressure)
# using VSTESTCD.
#-----------------------------------------------------------

vs_bp <- vs_safety %>%
  # Your code here
    filter(VSTESTCD %in% c("SYSBP", "DIABP"))
  
  #-----------------------------------------------------------
# 5. Check Row Counts After Join & Filtering
# Check number of rows after:
# - Join
# - Safety filter
# - Parameter filter
#-----------------------------------------------------------

# Your code here
after <- vs_bp |> 
  summarise(
    after_cnt = sum(!is.na(USUBJID))
  )

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
