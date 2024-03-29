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
class(test_poverty_data$marital_status) == "character"
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

# check the range of data for marital_status
correct_marital_status <- 
  c(
    "Married - civilian spouse present",
    "Married - armed forces spouse present",
    "Married - spouse absent (excluding separated)",
    "Widowed",
    "Divorced",
    "Separated",
    "Never Married")

if (all(test_poverty_data$marital_status |>
        unique() %in% correct_marital_status)) 
{
  "The cleaned marital_status match the expected marital_status"
} else {
  "Not all of the marital_status have been cleaned completely"
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


