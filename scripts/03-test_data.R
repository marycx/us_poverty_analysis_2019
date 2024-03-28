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
# [...UPDATE THIS...]

#### Test data ####
# read in cleaned data
test_poverty_data <- read_parquet("data/analysis_data/cleaned_poverty_data.parquet")

# Check column class poverty_status, mortgage, income, age
class(test_poverty_data$poverty_status) == "character"
class(test_poverty_data$mortgage) == "character"
class(test_poverty_data$income) == "character"
class(test_poverty_data$age) == "character"

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

# check the range of data for mortgage
correct_mortgage <- c("Owner without mortgage", "Owner with mortgage", "Renter")

if (all(test_poverty_data$mortgage |>
        unique() %in% correct_mortgage)) 
{
  "The cleaned mortgage match the expected mortgage"
} else {
  "Not all of the mortgage have been cleaned completely"
}

# check the range of data for income
correct_income <- 
  c(
    "below 10k",
    "10k-50k",
    "50k-100k",
    "100k-150k",
    "150k-200k",
    "200k-150k",
    "above 250k"
  )
if (all(test_poverty_data$income |>
        unique() %in% correct_income)) 
{
  "The cleaned income match the expected income"
} else {
  "Not all of the income have been cleaned completely"
}

# check the range of data for age
correct_age <- 
  c(
    "25-34",
    "35-44",
    "45-54",
    "55-64",
    "above 65"
  )
if (all(test_poverty_data$age |>
        unique() %in% correct_age)) 
{
  "The cleaned age match the expected age"
} else {
  "Not all of the age have been cleaned completely"
}


