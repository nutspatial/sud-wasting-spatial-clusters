#'
#'
#' Run SaTScan
#'
#'

run_satscan <- function(.data, base_filename, basepath, output_dir, .scan_for = c("high, high-low")) {
  .scan_for <- match.arg(.scan_for)
  prepare_case_ctr_geo_files(.data = .data, base_filename = base_filename, output_dir = output_dir)

  configure_satscan(basepath = basepath, .scan_for = .scan_for)

  results <- satscan(
    prmlocation = dirname(basepath),
    prmfilename = basename(basepath)
  )

  results
}
