#-----------------------------------------------------------
# Exercise 4: Loop Over Parameters
#-----------------------------------------------------------

# Parameters to process:
# SYSBP, DIABP, PULSE, TEMP

# Goal:
# 1. Filter ADVS to each parameter
# 2. Calculate N, Mean, SD by Treatment and Visit
# 3. Combine all results into one summary table
# Hint: Use map() + bind_rows()

#-----------------------------------------------------------
# 0. Load Libraries
#-----------------------------------------------------------

library(dplyr)
library(purrr)
library(tidyr)
library(haven)

getwd()
setwd("D:/R training/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData-main/UpdatedCDISCPilotData")

#-----------------------------------------------------------
# 1. Read ADVS Dataset
#-----------------------------------------------------------

adsl <- read_xpt("ADAM/ADSL.XPT")
advs0 <- read_xpt("SDTM/VS.XPT")

advs <- adsl |>
  inner_join(advs0, by = "USUBJID")

#-----------------------------------------------------------
# 2. Create Parameter List
# Store vital signs parameters in a vector.
#-----------------------------------------------------------

params <-  unique(advs$VSTEST)
  # Your code here


#-----------------------------------------------------------
# 3. Loop Over Parameters Using map()
# For each parameter:
#   - Filter dataset
#   - Group by TRT01A and AVISIT
#   - Calculate:
#       N
#       Mean of AVAL
#       SD of AVAL
#-----------------------------------------------------------

summary_list <- map(
  params,
  function(param) {
    # Your code here
    advs |>
      filter(VSTEST == param) |>
      group_by(TRT01A, VISIT) |>
      summarise(
        N = sum(!is.na(VSSTRESN)),
        MEAN = mean(VSSTRESN, na.rm = TRUE),
        SD = sd(VSSTRESN, na.rm = TRUE),
        .groups = "drop"
      ) |>
      mutate(PARAM = param)
  }
)

#-----------------------------------------------------------
# 4. Combine Results
# Combine all parameter summaries
# into one final table
# using bind_rows().
#-----------------------------------------------------------

final_summary <- bind_rows(summary_list)
  # Your code here
  
  
  #-----------------------------------------------------------
# 5. Review Final Output
#-----------------------------------------------------------

# Your code here

summary(final_summary)

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
