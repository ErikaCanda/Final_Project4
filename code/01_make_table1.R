# Load necessary libraries
library(gtsummary)

# Set the working directory to the directory containing this script

here::i_am("code/01_make_table1.R")

stacked_data <- readRDS(file = here::here("output/data_clean.rds"))

table_one <- stacked_data  %>%
  tbl_summary (include = c ("Sex",
                            "Education level",
                            "No of household members",
                            "No of children < 5 in household",
                            "Pregnant woman in household",
                            "Pregnancy months"),
  by = "FIPAG water connection") %>% 
  modify_spanning_header(c("stat_1", "stat_2") ~ "**FIPAG water connection**") %>% 
  add_overall() %>% 
  add_p()

saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)

