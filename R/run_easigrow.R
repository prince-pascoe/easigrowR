#' Easigrow
#'
#' Executes easigrow for crack growth measurement
#'
#'
#' @param filename Text file with normalised stress spectrum
#' @param scale Peak stress value for the spectrum (MPa)
#'



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





read_easigrow <- function(filename) {
  # Load file
  con <- file(filename, open = "r")

  #Read each line
  while (TRUE) {

    result_line <- readLines(con, n = 1L)

    if (is_empty(result_line)) {
      break
    }

    if (str_detect(result_line, "block\\s+a")) {

      easigrow_results <- tibble(Block = numeric(), a = numeric())
      result_line <- readLines(con, n = 1L)

      while (!str_detect(result_line, "Failure Event")) {

        refined_line <- str_extract(result_line, "\\S+\\s+\\S+")

        block_val <- as.double(str_extract(refined_line, "\\S+(?=\\s)"))
        a_val <- as.double(str_extract(refined_line, "\\S+$"))

        easigrow_results %<>%
          add_row(Block = block_val, a = a_val)
        result_line <- readLines(con, n = 1L)
      }
      break
    }

  }
  close(con)

  return(easigrow_results)
}



crack_growth <- run_easigrow("data/sequences/rainflow-seq2.txt",
                             50,
                             options = "-a 0.00375,0.05 -e 0.5,0.05 --radius 0.003 -n 0.5 --image_outfile image.svg")

con(close)


