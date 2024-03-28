#### Preamble ####
# Purpose: Test the model number of observations
# Author:Mary Cheng
# Date: 27 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# Pre-requisites: run 04-model.R to get model

test_that("Check number of observations is correct", {
  # Check if the number of observations is equal to 1000
  expect_equal(nrow(poverty_prediction_model$data), 1000,
               info = "The number of observations is 1000."
  )
})