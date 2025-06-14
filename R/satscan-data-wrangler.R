#'
#' 
#' Wrangle data to be used in SaTScan 
#' 
#' 


wrangle_data <- function(.data) {
  ### Case file ----
  case_file <- .data |>
    subset(!flag_wfhz == 1) |>
    subset(gam != 0) |>
    select(cluster, gam) |>
    rename(
      cases = gam,
      locationid = cluster
    )

  ### Control file ----
  ctrl_file <- .data |>
    subset(flag_wfhz != 1) |>
    subset(gam != 1) |>
    select(cluster, gam) |>
    rename(
      ctrl = gam,
      locationid = cluster
    ) |>
    mutate(ctrl = replace(ctrl, values = 1))

  ### Geographical file ----
  geo_file <- .data |>
    select(
      locationid = cluster,
      latitude, longitude
    ) |>
    slice_head(
      by = locationid,
      n = 1
    ) |>
    arrange(locationid)

  list(
    case_file, ctrl_file, geo_file
  )
}

#'
#' 
#' Wrangle and save it in the directory
#' 
#' 

prepare_case_ctr_geo_files <- function(.data, base_filename, output_dir) {
  ## Create directory if it does not exist ----
  if (!dir.exists(output_dir)) {
    dir.create(
      path = output_dir,
      showWarnings = TRUE,
      recursive = TRUE
    )
  }

  ## Wrangle data ----
  files <- wrangle_data(.data)

  ## Write cases for Bernoulli model ----

  ### Case file ----
  do.call(
    what = write.cas,
    args = list(
      x = files[[1]],
      location = output_dir,
      filename = base_filename
    )
  )

  ### Control file ----
  do.call(
    what = write.ctl,
    args = list(
      x = files[[2]],
      location = output_dir,
      filename = base_filename
    )
  )

  ### Geographical coordinates file ----
  do.call(
    what = write.geo,
    args = list(
      x = files[[3]],
      location = output_dir,
      filename = base_filename
    )
  )

  # Return full path for later
  file.path(output_dir, base_filename)
}
