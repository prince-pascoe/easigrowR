#' Write easigrow text file
#'
#' write_easigrow
#'
#' @param x Input data
#' @param filename Name of text file to write to
#' @param ... Numeric or character arguments
#' @return NULL, writes data to the specified filename
#' @import magrittr
#' @import readr
#' @export


write_easigrow <- function(x, filename, ...) UseMethod("write_easigrow")

write_easigrow.default <- function(x, filename, ...) {

  if (!is.numeric(x)) {
    stop("x must be numeric")
  }

  x %>%
    round(digits = 4) %>%
    as.data.frame() %>%
    write_delim(filename, delim = "\n", na = "NA", append = FALSE,
                col_names = FALSE, quote_escape = "double")

}


#' @rdname write_easigrow
#' @export
write_easigrow.data.frame <- function(x, filename, ...) {

  if (min(dim(x)) > 1) {
    stop("Input should be one dimensional")
  }

  x %>%
    round(digits = 4) %>%
    write_delim(filename, delim = "\n", na = "NA", append = FALSE,
                col_names = FALSE, quote_escape = "double")

}
