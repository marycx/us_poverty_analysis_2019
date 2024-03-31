#### Preamble ####
# Purpose: Model for US poverty prediction
# Author: Mary Cheng
# Date: 27 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# License: --
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R first to get the cleaned dataset


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)
library(testthat)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/cleaned_poverty_data.parquet")

# Convert variables to factors
analysis_data$marital_status <- factor(analysis_data$mortgage_state)
analysis_data$income <- factor(analysis_data$income)

# Create poverty_status variable in binary form
analysis_data$poverty_status <- ifelse(analysis_data$poverty_status == "In poverty", 1, 0)

# Model 1 for n = 1000
set.seed(215)

poverty_data_reduced <- 
  analysis_data |> 
  slice_sample(n = 1000)

poverty_prediction_model <-
  stan_glm(
    poverty_status ~ mortgage_state+income,
    data = poverty_data_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 215
  )


#### Save model ####
saveRDS(
  poverty_prediction_model,
  file = "models/poverty_prediction_model.rds"
)

test_file("scripts/05-test_class.R")
test_file("scripts/06-test_observations.R")
test_file("scripts/07-test_coefficients.R")



