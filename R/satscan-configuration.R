#'
#'
#' Configure SaTScan Parameters for Bernoulli Purely Spatial Analysis
#'
#'
#'

configure_satscan <- function(filename, 
  destfile_params,
  satscan_version,
  startdate,
  enddate,
  .scan_for = c("high-rates", "high-low-rates")) {

  ## Enfornce options in `.scan_for` ----
  .scan_for <- match.arg(.scan_for)

  ## Run workflow conditionally, based on selected option in `.scan_for` ----
  switch(.scan_for,
    
    ### Likely clusters of high-rates only ----
    "high-rates" = {
      do.call(
        what = ss.options,
        list(
          reset = TRUE,
          version = satscan_version
        )
      )

      #### Set parameters as in SaTScan input tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
            CaseFile = do.call(what = paste0, args = list(filename, ".cas")),
            ControlFile = do.call(what = paste0, args = list(filename, ".ctl")),
            CoordinatesFile = do.call(what = paste0, args = list(filename, ".geo")),
            CoordinatesType = 1 # Latitude/Longitude
          ), 
          reset = TRUE
        )
      )

      #### Set parameters as in SaTScan analysis tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
          AnalysisType = 1, # Purely Spatial
          ModelType = 1, # Bernoulli
          ScanAreas = 1,
          MaxSpatialSizeInPopulationAtRisk = 50,
          SpatialWindowShapeType = 0, 
          PrecisionCaseTimes = 0,
          StartDate = startdate,
          EndDate = enddate
          ), 
          reset = FALSE
        )
      )

     #### Set parameters as in SaTScan output tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
          ResultsTitle = "results",
          LaunchMapViewer = "n",
          CompressKMLtoKMZ = "n",
          IncludeClusterLocationsKML = "y",
          ReportHierarchicalClusters = "y" # To get nested clusters, if any.
          ), 
          reset = FALSE
        )
      )

      #### Write parameter file ----
      do.call(
        what = write.ss.prm,
        args = list(
          location = destfile_params,
          filename = filename,
          matchout = TRUE
          )
        )
    },

    ### Likely clusters of high- and low-rates ----
    "high-low-rates" = {
      do.call(
        what = ss.options,
        list(
          reset = TRUE, 
          version = satscan_version
        )
      )

      #### Set parameters as in SaTScan input tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
            CaseFile = do.call(what = paste0, args = list(filename, ".cas")),
            ControlFile = do.call(what = paste0, args = list(filename, ".ctl")),
            CoordinatesFile = do.call(what = paste0, args = list(filename, ".geo")),
            CoordinatesType = 1 # Latitude/Longitude
          ), 
          reset = FALSE
        )
      )

      #### Set parameters as in SaTScan analysis tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
          AnalysisType = 1, # Purely Spatial
          ModelType = 1, # Bernoulli
          ScanAreas = 3,
          MaxSpatialSizeInPopulationAtRisk = 50,
          SpatialWindowShapeType = 0,
          StartDate = startdate,
          EndDate = enddate
          ), 
          reset = FALSE
        )
      )

      #### Set parameters as in SaTScan output tab ----
      do.call(
        what = ss.options,
        args = list(
          invals = list(
          ResultsTitle = "results",
          LaunchMapViewer = "n",
          CompressKMLtoKMZ = "n",
          IncludeClusterLocationsKML = "y",
          ReportHierarchicalClusters = "y" # To get nested clusters, if any.
          ), 
          reset = FALSE
        )
      )

      #### Write parameter file ----
      do.call(
        what = write.ss.prm,
        args = list(
          location = destfile_params,
          filename = filename,
          matchout = TRUE
          )
        )
    }
  )
}
