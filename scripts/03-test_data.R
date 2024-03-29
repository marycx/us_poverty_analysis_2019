#### Preamble ####
# Purpose: Test the cleaned US poverty data
# Author: Mary Cheng
# Date: 27 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# License: --
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R first to get the cleaned dataset


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Test data ####
# read in cleaned data
test_poverty_data <- read_parquet("data/analysis_data/cleaned_poverty_data.parquet")

# Check column class poverty_status, marital_status, income, age
class(test_poverty_data$poverty_status) == "character"
class(test_poverty_data$mortgage_state) == "character"
class(test_poverty_data$income) == "character"

# Range of data
# check the range of data for poverty_status
correct_poverty_status <- c("In poverty", "Not in poverty")

if (all(test_poverty_data$poverty_status |>
        unique() %in% correct_poverty_status)) 
{
  "The cleaned poverty_status match the expected poverty_status"
} else {
  "Not all of the poverty_status have been cleaned completely"
}

# check the range of data for mortgage_state
correct_mortgage_state <- 
  c(
    "Owner with Mortgage",
    "Owner without Mortgage or rent-free",
    "Renter")
if (all(test_poverty_data$mortgage_state |>
        unique() %in% correct_mortgage_state)) 
{
  "The cleaned mortgage_state match the expected mortgage_state"
} else {
  "Not all of the mortgage_state have been cleaned completely"
}

# check the range of data for income
correct_income <- 
  c(
    "below 10k",
    "10k-50k",
    "50k-100k",
    "100k-150k",
    "150k-200k",
    "200k-250k",
    "above 250k"
  )
if (all(test_poverty_data$income |>
        unique() %in% correct_income)) 
{
  "The cleaned income match the expected income"
} else {
  "Not all of the income have been cleaned completely"
}