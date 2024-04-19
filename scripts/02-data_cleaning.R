#### Preamble ####
# Purpose: Cleans the raw poverty data in the data folder
# Author: Mary Cheng
# Date: 26 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# License: --
# Pre-requisites: run 01-download_data.R in scripts folder first to get the raw data


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Clean data ####
# read in raw data
raw_poverty_data <-
  read_parquet("data/raw_data/raw_poverty_data.parquet")

# Calculate money income after tax, minus expenses, plus credits and benefits
raw_poverty_data$income_after_tax <- raw_poverty_data$spm_totval + raw_poverty_data$spm_snapsub + raw_poverty_data$spm_caphousesub + raw_poverty_data$spm_schlunch + raw_poverty_data$spm_engval + raw_poverty_data$spm_wicval - raw_poverty_data$spm_fedtax + raw_poverty_data$spm_eitc + raw_poverty_data$spm_actc - raw_poverty_data$spm_fica - raw_poverty_data$spm_sttax - raw_poverty_data$spm_childsuppd - raw_poverty_data$spm_capwkccxpns - raw_poverty_data$spm_medxpns

# first rename column names to increase readability
# remove duplicate entries
# poverty status: 1-in poverty; 0-not in poverty
# mortgage state: 1-Owner with Mortgage; 2-Owner without Mortgage or rent-free; 3-Renter
# mutate income variable into categorical variable
  # income level: below 5000, 5000 - 49999, 50000 - 99999, 100000 - 1499999, 150000 - 199999, 200000 - 249999, above 250000
# remove any NA, select features: poverty-status, mortgage_state, income

cleaned_poverty_data <-
  raw_poverty_data |>
  rename(
    poverty_status = spm_poor, 
    mortgage_state = spm_tenmortstatus, 
    income = income_after_tax
  ) |>
  unique() |>
  mutate(
    poverty_status = if_else(poverty_status == 1, "In poverty", "Not in poverty"),
    mortgage_state = case_when(
      mortgage_state == 1 ~ "Owner with Mortgage",
      mortgage_state == 2 ~ "Owner without Mortgage",
      mortgage_state == 3 ~ "Renter"
    ),
    income = case_when(
      income < 5000 ~ "below 5k",
      5000 <= income & income < 49999 ~ "5k-50k",
      50000 <= income & income < 99999 ~ "50k-100k",
      100000 <= income & income < 149999 ~ "100k-150k",
      150000 <= income & income < 199999 ~ "150k-200k",
      200000 <= income & income < 249999 ~ "200k-250k",
      250000 <= income ~ "above 250k"
    )
  ) |>
  na.omit() |>
  select(poverty_status, mortgage_state, income)

#### Save data ####
write_parquet(x = cleaned_poverty_data, sink = "data/analysis_data/cleaned_poverty_data.parquet")
