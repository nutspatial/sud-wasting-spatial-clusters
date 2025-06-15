# ==============================================================================
#                                 SaTScan
#
#                    Bernoulli Purely Spatial analysis
#               Obejctive: Scan for areas with high and low rates
# ==============================================================================


## ---- Create a temporary directory -------------------------------------------
destfile <- "data/satscan"
filename <- "elfasher"


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
    filename = filename,
    destfile = destfile,
    destfile_params = destfile,
    .scan_for = "high-rates"
  )
)
