#-----------------------------------------------------------
# Exercise 5: Date Derivations
#-----------------------------------------------------------

# Given:
# TRTSDT  = "2024-01-15"
# AESTDTC = "2024-01-20"

# Goals:
# 1. Convert both to Date objects
# 2. Derive Study Day (ASTDY) following CDISC rules (no Day 0)
# 3. Calculate duration in days
# 4. Verify what ASTDY should be

#-----------------------------------------------------------
# 0. Create Input Data
#-----------------------------------------------------------

library(lubridate)
library(tidyverse)

trtsdt_char  <- "2024-01-15"
aestdtc_char <- "2024-01-20"


#-----------------------------------------------------------
# 1. Convert to Date Objects
# Convert TRTSDT and AESTDTC
# from character to Date format.
#-----------------------------------------------------------

trtsdt <- 
  # Your code here
  as.Date(trtsdt_char, format = "%Y-%m-%d")
  
  aestdtc <- 
  # Your code here
    as.Date(aestdtc_char, format = "%Y-%m-%d")
  
  
  #-----------------------------------------------------------
# 2. Derive Study Day (ASTDY)
# Follow CDISC rules:
# - No Day 0
# - If event date ≥ treatment start → positive day
# - If event date < treatment start → negative day
#-----------------------------------------------------------

astdy <- 
  # Your code here
    ifelse(
      aestdtc >= trtsdt,
      as.numeric(aestdtc - trtsdt) + 1,
      as.numeric(aestdtc - trtsdt)
    )
  
  
  #-----------------------------------------------------------
# 3. Calculate Duration
# Calculate difference in days
# between AESTDTC and TRTSDT.
#-----------------------------------------------------------

duration_days <- 
  # Your code here
     as.numeric(aestdtc - trtsdt)  
  
  #-----------------------------------------------------------
# 4. Verify ASTDY
# Print or check ASTDY value.
#-----------------------------------------------------------

# Your code here
  
  astdy
#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
