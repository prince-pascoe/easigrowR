#' Easigrow
#'
#' Executes easigrow for crack growth measurement
#'
#'
#' @param filename Text file with normalised stress spectrum
#' @param scale Peak stress value for the spectrum (MPa)
#' @param flags String containing flag specifiers for the simulation
#' @param options String containing option specifiers for the simulation
#' @export

run_easigrow <- function(filename, scale, flags = NULL, options = NULL) {

  cmd = paste("-q", filename,
              "-s", scale,
              flags,
              "-b", "dsht-bowie56",
              "-r", options,
              sep = " ")

  system2("easigrow", args = cmd, stdout = "results.txt", stderr = "error.txt")

  if (file.info("results.txt")$size != 0) {
    return(read_easigrow("results.txt"))
  } else {
    stop("Easigrow encountered errors, see error.txt")
  }


}

# crack_growth <- run_easigrow("data/sequences/rainflow-seq2.txt",
#                              50,
#                              options = "-a 0.00375,0.05 -e 0.5,0.05 --radius 0.003 -n 0.5 --image_outfile image.svg")



