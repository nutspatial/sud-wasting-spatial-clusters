#'
#' 
#' Configure SaTScan Parameters for Bernoulli Purely Spatial Analysis
#' 
#' 
#' 

configure_satscan <- function(basepath, .scan_for = c("high-rates, high-low-rates")) {
  .scan_for <- match.arg(.scan_for)

  switch(.scan_for,
    "high-rates" = {
      do.call(
        what = ss.options,
        list(reset = TRUE)
      )

      do.call(
        what = ss.options,
        args = list(
          CaseFile = do.call(
            what = paste0,
            args = list(basepath, ".cas")
          ),
          ControlFile = do.call(
            what = basepath,
            args = list(basepath, ".ctl")
          ),
          CoordinatesFile = do.call(
            what = paste0,
            args = list(basepath, ".geo")
          ),
          CoordinatesType = 2, # Latitude/Longitude
          AnalysisType = 1, # Purely Spatial
          ModelType = 2, # Bernoulli
          MaxSpatialSizeInPopulationAtRisk = 50, # e.g., max cluster size (%)
          ScanAreas = 2, # High clusters only
          PrecisionCaseTimes = 0
        )
      )

      # Write parameter file
      do.call(
        what = write.ss.prm,
        args = list(
          do.call(
            what = dirname,
            args = list(basepath),
            do.call(
              what = basename,
              args = list(basepath)
            )
          )
        )
      )
    },

    "high-low-rates" = {
      do.call(
        what = ss.options,
        list(reset = TRUE)
      )

      do.call(
        what = ss.options,
        args = list(
          CaseFile = do.call(
            what = paste0,
            args = list(basepath, ".cas")
          ),
          ControlFile = do.call(
            what = basepath,
            args = list(basepath, ".ctl")
          ),
          CoordinatesFile = do.call(
            what = paste0,
            args = list(basepath, ".geo")
          ),
          CoordinatesType = 2, # Latitude/Longitude
          AnalysisType = 1, # Purely Spatial
          ModelType = 2, # Bernoulli
          MaxSpatialSizeInPopulationAtRisk = 50, # e.g., max cluster size (%)
          ScanAreas = 0, # High clusters only
          PrecisionCaseTimes = 0
        )
      )

      # Write parameter file
      do.call(
        what = write.ss.prm,
        args = list(
          do.call(
            what = dirname,
            args = list(basepath),
            do.call(
              what = basename,
              args = list(basepath)
            )
          )
        )
      )
    }
  )
}

