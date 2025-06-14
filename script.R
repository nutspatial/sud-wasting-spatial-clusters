# ==============================================================================
#              WORKFLOW FOR SCANNING SPATIAL CLUSTER WITH {rsatscan}
# ==============================================================================

## ---- Load libraries ---------------------------------------------------------

library(cyphr)
library(dplyr)
library(mwana)
library(lubridate)
library(rsatscan)

## ---- Retrieve project secret key --------------------------------------------

secret_key <- data_key(path_data = ".", path_user = "~/.ssh/id_rsa")

## ---- Load UDF ---------------------------------------------------------------

for (f in list.files(path = "R", full.names = TRUE)) source(f)

## ---- Read data in -----------------------------------------------------------

source(file = "scripts/read-data.R")

## ---- Wrangle data -----------------------------------------------------------

source(file = "scripts/wrangle-data.R")

## ---- Plausibility check -----------------------------------------------------

source(file = "scripts/data-quality.R")

## ---- Run SaTScan ------------------------------------------------------------

source(file = "script.R")
