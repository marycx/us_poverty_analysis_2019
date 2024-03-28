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
  read_csv(
    "data/raw_data/raw_poverty_data.csv"
  )

# first rename column names to increase readability
# remove duplicate entries (because all those people live in the same household)
# filter out ages under 25
# filter out income is negative
# poverty status: 1-in poverty; 0-not in poverty
# mortgage status: 1-Owner with Mortgage; 2-Owner without Mortgage; 3-Renter
# mutate income and age variables into categorical variables
  # income level: below 10000, 10000 - 49999, 50000 - 99999, 100000 - 1499999, 150000 - 199999, 200000 - 249999, above 250000
  # age group: 25-34, 35-44, 45-54, 55-64, above 65

cleaned_poverty_data <-
  raw_poverty_data |>
  rename(
    poverty_status = spm_poor, 
    mortgage = spm_tenmortstatus, 
    income = spm_totval, 
    age = spm_hage
  ) |>
  distinct() |>
  filter(age > 25) |>
  filter(income > 0) |>
  mutate(
    poverty_status = if_else(poverty_status == 1, "In poverty", "Not in poverty"),
    mortgage = case_when(
      mortgage == 1 ~ "Owner with mortgage",
      mortgage == 2 ~ "Owner without mortgage",
      mortgage == 3 ~ "Renter",
    ),
    income = case_when(
      income < 10000 ~ "below 10k",
      10000 <= income & income < 49999 ~ "10k-50k",
      50000 <= income & income < 99999 ~ "50k-100k",
      100000 <= income & income < 149999 ~ "100k-150k",
      150000 <= income & income < 199999 ~ "150k-200k",
      200000 <= income & income < 249999 ~ "200k-150k",
      250000 <= income ~ "above 250k"
    ),
    age = case_when(
      25 <= age & age <= 34 ~ "25-34",
      35 <= age & age <= 44 ~ "35-44",
      45 <= age & age <= 54 ~ "45-54",
      55 <= age & age <= 64 ~ "55-64",
      65 <= age ~ "above 65"
    )
  )


#### Save data ####
write_parquet(x = cleaned_poverty_data, sink = "data/analysis_data/cleaned_poverty_data.parquet")
