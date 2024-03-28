#### Preamble ####
# Purpose: Test the model cofficient
# Author: Mary Cheng
# Date: 27 March 2024
# Contact: maqryc.cheng@mail.utoronto.ca
# Pre-requisites: run 04-model.R to get model


test_that("Check summary", {
  summary_poverty <- summary(poverty_prediction_model)
  expect_true("summary.stanreg" %in% class(summary_poverty))
})