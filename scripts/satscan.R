# ==============================================================================
#                                 SaTScan
#
#                    Bernoulli Purely Spatial analysis
#               Obejctive: Scan for areas with high and low rates
# ==============================================================================


## ---- Create a temporary directory -------------------------------------------
prm_dir <- "data/satscan-input"
prm_file <- "elfasher"


## ---- Set SatScan analysis parameters ----------------------------------------

do.call(
  what = invisible,
  args = list(
    do.call(
      what = ss.options,
      args = list(
        reset = TRUE
      )
    )
  )
)

## ---- Run SaTScan ------------------------------------------------------------
do.call(
  what = run_satscan,
  args = list(
    .data = smart_wfhz,
    base_filename = "elfasher",
    output_dir = "data/satscan",
    .scan_for = "high", 
    basepath = "data/satscan"
  )
)

