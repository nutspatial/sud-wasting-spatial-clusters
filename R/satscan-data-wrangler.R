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
    relocate(longitude, .after = locationid) |> 
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

prepare_case_ctr_geo_files <- function(.data, filename, destfile) {
  ## Create directory if it does not exist ----
  if (!dir.exists(destfile)) {
    dir.create(
      path = destfile,
      showWarnings = TRUE,
      recursive = TRUE
    )
  } else {
    message(
      paste0("`", destfile, "` already exists in project repo.")
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
      location = destfile,
      filename = filename
    )
  )

  ### Control file ----
  do.call(
    what = write.ctl,
    args = list(
      x = files[[2]],
      location = destfile,
      filename = filename
    )
  )

  ### Geographical coordinates file ----
  do.call(
    what = write.geo,
    args = list(
      x = files[[3]],
      location = destfile,
      filename = filename
    )
  )

  # Return full path for later
  file.path(destfile, filename)
}
