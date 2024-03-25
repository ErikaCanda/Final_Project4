# Load necessary libraries
library(openxlsx)
library(here)
library(dplyr)
library(labelled)

# Set the working directory to the directory containing this script
here::i_am("code/00_clean_data.R")

# Specify the absolute paths to the PAASIM data files
absolute_path_to_PAASIM_2019 <- here::here("data", "PAASIM_2019.xlsx")
absolute_path_to_PAASIM_2020 <- here::here("data", "PAASIM_2020.xlsx")

# Read the PAASIM data into data frames
PAASIM_2019 <- read.xlsx(absolute_path_to_PAASIM_2019)
PAASIM_2020 <- read.xlsx(absolute_path_to_PAASIM_2020)

analytic_sample_2019 <- PAASIM_2019[PAASIM_2019$A_1_6 == 1, ]
analytic_sample_2020 <- PAASIM_2020[PAASIM_2020$A_1_6 == 1, ]

#Renaminng all relevant variables for table 1 from 2019 dataset & creating a year variable

colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_3"] <- "Sex"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_5"] <- "Education level"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_6"] <- "No of household members"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_7"] <- "No of children < 5 in household"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_8"] <- "Pregnant woman in household"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-A_2_8a"] <- "Pregnancy months"
colnames(analytic_sample_2019)[colnames(analytic_sample_2019) == "consent_group-B_1_1"] <- "FIPAG water connection"
analytic_sample_2019$Year <- 2019

#creating 2019 analytic subset dataset with relevant variables for analysis  

analytic_sample_2019_subset <- analytic_sample_2019[c("sub_ID",
                                                      "Sex","Education level",
                                                      "No of household members", 
                                                      "No of children < 5 in household",
                                                      "Pregnant woman in household",
                                                      "Pregnancy months",
                                                      "FIPAG water connection",
                                                      "Year")]

#Renaminng all relevant variables for table 1 from 2020 dataset & creating a year variable

colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_3"] <- "Sex"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_5a"] <- "Education level"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_6"] <- "No of household members"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_7"] <- "No of children < 5 in household"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_8"] <- "Pregnant woman in household"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-A_2_8a"] <- "Pregnancy months"
colnames(analytic_sample_2020)[colnames(analytic_sample_2020) == "consent_group-B_1_1"] <- "FIPAG water connection"
analytic_sample_2020$Year <- 2020

#creating 2020 analytic subset dataset with relevant variables for analysis  

analytic_sample_2020_subset <- analytic_sample_2020[c("sub_ID",
                                                      "Sex",
                                                      "Education level",
                                                      "No of household members", 
                                                      "No of children < 5 in household",
                                                      "Pregnant woman in household",
                                                      "Pregnancy months",
                                                      "FIPAG water connection",
                                                      "Year")]


stacked_data <- rbind(analytic_sample_2019_subset, analytic_sample_2020_subset)

var_label(stacked_data) <- list("sub_ID",
                                "Sex",
                                "Education level",
                                "No of household members", 
                                "No of children < 5 in household",
                                "Pregnant woman in household",
                                "Pregnancy months",
                                "FIPAG water connection",
                                "Year")

stacked_data$Sex <- factor(stacked_data$Sex, levels = c(0, 1), labels = c("Female", "Male"))

stacked_data$`FIPAG water connection` <- factor(stacked_data$`FIPAG water connection` , levels = c(0, 1), labels = c("No", "Yes"))

stacked_data$`Pregnant woman in household` <- factor(stacked_data$`Pregnant woman in household`, levels = c(0, 1), labels = c("No", "Yes"))

stacked_data$`Education level` <- ifelse(stacked_data$`Education level` %in% 0:2, 
                                         "No/Incomplete primary education",
                                         ifelse(stacked_data$`Education level` %in% 3:4, 
                                         "Primary education or some secondary education",
                                         ifelse(stacked_data$`Education level` %in% 5:7, 
                                         "Secondary education or higher",
                                         NA
                                         )))

stacked_data$`Pregnancy months` <- ifelse(stacked_data$`Pregnancy months` %in% 1, 
                                          "1-3",
                                          ifelse(stacked_data$`Pregnancy months` %in% 2, 
                                          "4-6",
                                          ifelse(stacked_data$`Pregnancy months` %in% 3, 
                                          "7-9",
                                          NA
                                          )))

stacked_data$`No of children < 5 in household` <- ifelse(stacked_data$`No of children < 5 in household` %in% 1, "1",
                                                  ifelse(stacked_data$`No of children < 5 in household` %in% 2, "2",
                                                  ifelse(stacked_data$`No of children < 5 in household` %in% 3, "3",
                                                  ifelse(stacked_data$`No of children < 5 in household` >=4,"4 or more",
                                                  NA
                                                  ))))

saveRDS(
  stacked_data,
  file = here::here("output/data_clean.rds")
)