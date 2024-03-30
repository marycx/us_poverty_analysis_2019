#### Preamble ####
# Purpose: Simulates the US 2019 poverty status data
# Author: Mary Cheng
# Date: 29 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# License: --
# Pre-requisites: --


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# set seed
set.seed(215)

num_obs <- 200

# simulate poverty status data based on mortgage state and income level
simulate_poverty_status <- 
  tibble(
    mortgage_state = sample(0:2, num_obs, replace = TRUE, prob = c(0.33, 0.33, 0.34)), # Simulate mortgage state (0 = without mortgage, 1 = with mortgage, 2 = renter)
    income = rnorm(num_obs, mean = 60000, sd = 20000), # Simulate income level
    poverty_status = ifelse(
      (mortgage_state == 0 & income < 40000) | 
        (mortgage_state == 1 & income < 30000) | 
        (mortgage_state == 2 & income < 25000), 1, 0) # Simulate poverty status based on mortgage state and income level
  ) |>
  mutate(
    poverty_status = if_else(poverty_status == 1, "In poverty", "Not in poverty"),
    mortgage_state = case_when(
      mortgage_state == 0 ~ "Owner without mortgage",
      mortgage_state == 1 ~ "Owner with mortgage",
      mortgage_state == 2 ~ "Renter"
    ),
    income = case_when(
      income < 50000 ~ "below 50k",
      50000 <= income & income < 60000 ~ "50k-60k",
      60000 <= income & income < 70000 ~ "60k-70k",
      70000 <= income ~ "above 70k"
    )) |>
  select(poverty_status, mortgage_state, income)
  