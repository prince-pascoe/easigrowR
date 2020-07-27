#' Read easigrow file
#'
#' Reads the output from easigrow saved to the specified file
#' @family easigrow
#' @param filename The name of the output file from easigrow
#' @return A tibble with the block and crack growth sizes
#' @import stringr
#' @import magrittr
#' @importFrom rlang is_empty
#' @import tibble
#' @export


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
