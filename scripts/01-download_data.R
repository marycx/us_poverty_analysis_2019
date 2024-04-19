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
library(arrow)


#### Download data ####
raw_poverty_data <- read_dta('https://www2.census.gov/programs-surveys/supplemental-poverty-measure/datasets/2019-revised/spm2019_newmeth.dta')

# Select the feature: h_seq, spm_poor, spm_tenmortstatus, spm_totval
raw_poverty_data <-
  raw_poverty_data |>
  select(h_seq, spm_poor, spm_tenmortstatus, spm_totval, spm_snapsub, spm_caphousesub, spm_schlunch, spm_engval, spm_wicval, spm_fedtax, spm_eitc, spm_actc, spm_fica, spm_sttax, spm_childsuppd, spm_capwkccxpns, spm_medxpns)


#### Save data ####
write_parquet(raw_poverty_data, sink = "data/raw_data/raw_poverty_data.parquet")

         
