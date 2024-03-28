#### Preamble ####
# Purpose: Downloads and saves the data from United States Census Bureau
# Author: Mary Cheng
# Date: 26 March 2024
# Contact: maryc.cheng@mail.utoronto.ca
# License: --
# Pre-requisites: --
# United States Census Bureau: https://www.census.gov/data/datasets/2019/demo/supplemental-poverty-measure/revised-research.html


#### Workspace setup ####
library(haven)
library(tidyverse)


#### Download data ####
raw_poverty_data <- read_dta('https://www2.census.gov/programs-surveys/supplemental-poverty-measure/datasets/2019-revised/spm2019_newmeth.dta')

raw_poverty_data <-
  raw_poverty_data |>
  select(spm_poor, spm_tenmortstatus, spm_totval, spm_hage)


#### Save data ####
write_csv(raw_poverty_data, "data/raw_data/raw_poverty_data.csv") 

         
