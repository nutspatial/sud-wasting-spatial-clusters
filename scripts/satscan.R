# ==============================================================================
#                                 SaTScan
#
#                    Bernoulli Purely Spatial analysis
#               Obejctive: Scan for areas with high and low rates
# ==============================================================================


## ---- Create a temporary directory -------------------------------------------

destfile <- "data/satscan"
filename <- "elfasher"
startdate <- "2025/06/20"
enddate <- "2025/06/21"

## ---- Run SaTScan ------------------------------------------------------------

results <- do.call(
  what = run_satscan,
  args = list(
    .data = smart_wfhz,
    filename = filename,
    destfile = destfile,
    destfile_params = destfile,
    .scan_for = "high-rates", 
    verbose = TRUE, 
    sslocation = "/Applications/SaTScan.app/Contents/app", 
    satscan_version = "10.3.2", 
    startdate = startdate,
    enddate = enddate
  )
)

# =============================== End of Worflow ===============================