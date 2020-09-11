#' Quick easigrow test
#'
#' lazygrow
#'
#' @param scale Peak stress in MPa
#' @param sequence Sequence to apply
#' @param res_filename Name to give the text file containing easigrow results
#'
#'
#' @return A tibble with the block and crack growth sizes
#'
#' @import stringr
#' @export

lazygrow <- function(scale, sequence, res_filename) {

  if (is.character(sequence)) {

    seq_filename = sequence

  } else {

    seq_filename = "lazy_sequence.txt"
    write_easigrow(sequence, seq_filename)

  }


  flags = "-r --seq_tp"
  options = "-b dsht-bowie56 -a 0.00375 --radius 0.0015 -e 0.05 --forward 0.05 -N 1000000"

  res <- run_easigrow(seq_filename, res_filename, scale, flags, options)
  unlink(seq_filename)
  return(res)

}
