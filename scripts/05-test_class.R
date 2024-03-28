#### Preamble ####
# Purpose: Test the model class
# Author: Mary Cheng
# Date: 27 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# Pre-requisites: run 04-model.R to get model

library("testthat")

test_that("Check class", {
  # Check if the model object inherits from any of the expected classes
  expect_true(
    inherits(poverty_prediction_model, "stanreg") ||
      inherits(poverty_prediction_model, "glm") ||
      inherits(poverty_prediction_model, "lm"),
    info = "The class of poverty_prediction_model is as expected."
  )
})