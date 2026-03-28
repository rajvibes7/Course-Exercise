#-----------------------------------------------------------
# Exercise 6: String Parsing
#-----------------------------------------------------------

# Given variable:
# USUBJID format → "STUDY001-USA-101-0001"

# Goals:
# 1. Extract Study ID
#    (first part before first dash)
# 2. Extract Country Code
#    (second part)
# 3. Create SUBJID_SHORT
#    (last two parts combined)
# 4. Check if any subjects are from "USA" sites

# Use stringr functions:
# str_split(), word(), or str_sub()

#-----------------------------------------------------------
# 0. Load Library
#-----------------------------------------------------------

library(dplyr)
library(stringr)

#-----------------------------------------------------------
# 1. Create Sample Data
#-----------------------------------------------------------

df <- data.frame(
  USUBJID = c(
    "STUDY001-USA-101-0001",
    "STUDY001-IND-102-0002",
    "STUDY001-USA-103-0003"
  ),
  stringsAsFactors = FALSE
)

#-----------------------------------------------------------
# 2. Extract Study ID
# Extract first part before first dash.
#-----------------------------------------------------------

df_step1 <- df %>%
  # Your code here
  mutate(
    STUDYID = sub("-.*", "", USUBJID)
  )
  
  #-----------------------------------------------------------
# 3. Extract Country Code
# Extract second part of USUBJID.
#-----------------------------------------------------------

df_step2 <- df_step1 %>%
  # Your code here
  mutate(
    COUNTRY = sub("^[^-]+-([^-]+)-.*", "\\1", USUBJID)
  )
  
  #-----------------------------------------------------------
# 4. Create SUBJID_SHORT
# Combine last two parts:
# Example → "101-0001"
#-----------------------------------------------------------

df_step3 <- df_step2 %>%
  # Your code here
  mutate(
    SUBJID_SHORT = sub("^[^-]+-[^-]+-", "", USUBJID)
  )
  
  #-----------------------------------------------------------
# 5. Check USA Subjects
# Identify if any subjects
# are from "USA" sites.
#-----------------------------------------------------------

usa_check <- df_step3 |>
  # Your code here
  filter(COUNTRY == "USA")
  
  #-----------------------------------------------------------
# 6. Review Output
#-----------------------------------------------------------

# Your code here

df_step3

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
