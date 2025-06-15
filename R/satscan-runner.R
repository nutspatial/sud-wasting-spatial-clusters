#'
#'
#' Run SaTScan through its GUI
#'
#'

run_satscan <- function(
    .data,
    filename,
    destfile,
    destfile_params = destfile,
    .scan_for = c("high-rates", "high-low-rates")) {
  
  ## Enforce options in `.scan_for` ----
  .scan_for <- match.arg(.scan_for)

  ## Get SaTScan input data ready for the job ----
  do.call(
    what = prepare_case_ctr_geo_files,
    args = list(
      .data = .data,
      filename = filename,
      destfile = destfile
    )
  )

  ## Set SaTScan parameters for purely spatial analysis ----
  do.call(
    what = configure_satscan,
    args = list(
      .scan_for = .scan_for, 
      destfile_params = destfile_params, 
      filename = filename
    )
  )

  ## Run de facto SaTScan ----
  results <- do.call(
    what = satscan,
    args = list(
      prmlocation = do.call(what = dirname, args = list(destfile_params)),
      prmfilename = do.call(what = basename, args = list(filename))
    )
  )

  results
}
