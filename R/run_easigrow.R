#' Easigrow
#'
#' @description Executes easigrow for crack growth measurement
#'
#' @param seq_filename Text file with normalised stress spectrum
#' @param res_filename Text file with results of simulation
#' @param scale Peak stress value for the spectrum (MPa)
#' @param flags String containing flag specifiers for the simulation
#' @param options String containing option specifiers for the simulation
#'
#' @return A tibble with the block and crack growth sizes
#'
#' @details
#' Flag specifiers include:
#' \itemize{
#' \item \strong{-r} Re-order the sequence to close cycles
#' \item \strong{--summary} Print summary of sequence
#' }
#'
#' Option specifiers include:
#' \itemize{
#' \item \strong{-e <LENGTH>} final termination crack sizes (default 1e-3 m)
#' \item \strong{-a <LENGTH>} initial crack sizes (default 10e-6 m). How many depends on beta factor, typically a,c is used.
#' \item \strong{-b <NAME>} {beta geometry model (default seft-newman84)}
#' \item \strong{--beta_outfile <FILE>} {write the beta model to a file}
#' \item \strong{-c <FILE>} {crack growth measurements that will be matched during optimisation}
#' \item \strong{--crack_weight <WEIGHT>} {weighting factor for matching crack growth curve (default 1.0)}
#' \item \strong{--cycle_deadband <MIN,MAX>} {eliminates cycles with turning points within this band}
#' \item \strong{--cycle_infile <FILE>} {read the cycles from an AFGROW input file}
#' \item \strong{--cycle_max <MAX>} {any range greater than this will be set to this value}
#' \item \strong{--cycle_method <METHOD>} {method used to extract cycles from sequence (default rainflow) possible values:rainflow, tension}
#' \item \strong{--cycle_min <MIN>} {any range less than this will be set to this}
#' \item \strong{--cycle_outfile <FILE>} {write the modified sequence to a file}
#' \item \strong{--cycle_rem_big <DELTA>} {remove cycles with a range bigger than this}
#' \item \strong{--cycle_rem_small <DELTA>} {remove cycles with a range smaller than this}
#' \item \strong{-d <NAME>} {dadn material equation (default white:barter14_aa7050-t7451)}
#' \item \strong{--forward <DISTANCE>} {distance forwards from crack origin to free edge in 'a' direction of growth (default: infinite)}
#' \item \strong{--image_bar <LENGTH>} {size of scale bar for image (default 50e-6 m)}
#' \item \strong{--image_outfile <FILE>} {generate a pseudo image of the fracture surface and write to FILE}
#' \item \strong{--image_size <V,H>} {size of image VxH pixels (default 300x8000)}
#' \item \strong{--image_type <TYPE>} {type of image output (default sem) possible values: Sem, Optical}
#' \item \strong{-N <N>} {maximum number of blocks (default +1000)}
#' \item \strong{--limit_k1c <KIC>} {fracture toughness K1C for termination (default 33 MPa sqrt(m))}
#' \item \strong{--limit_yield <STRESS>} {yield or flow stress for plastic zone calculations and net section yield (default 450 MPa).}
#' \item \strong{--opt_infile <FILE>} {optimises model parameters to match a set of target crack growth data.}
#' \item \strong{--opt_max <N>} {maximum number of iterations to be used for optimisation (default 100)}
#' \item \strong{--opt_method <METHOD>} {method used for optimisation (default Levenberg) possible values: Sweep, Nelder,All}
#' \item \strong{--opt_nelder <p1,...,p5>} {nelder-mead parameters (default step: 0.1, alpha: 1.0, gamma: 2.0, rho: 0.5, sigma: 0.5)}
#' \item \strong{--opt_sweep <f1,...,fM>} {perform a brute force sweep over a range of scaling factors applied to M dadn parameters}
#' \item \strong{--opt_tol <TOL>} {terminate optimisation when the change in error function is less than this amount (default 1e-3)}
#' \item \strong{-n <N>} {output crack growth data every +N blocks or -N cycles (default +1)}
#' \item \strong{--output_lines <l1,l2,...>} {output growth at the given load lines l1,l2,l3... (default 1)}
#' \item \strong{-o <v1,v2,...>} {comma separated list of variables to be output (default block,a)}
#' \item \strong{-p <p1,p2,...,pM>} {material parameters (default parameters for white:barter14_aa7050-t7451)}
#' \item \strong{--radius <R>} {radius of hole or notch (default: infinite)}
#' \item \strong{-s <SCALE>} {scale factor for load sequence (no default)}
#' \item \strong{-q <FILE>} {file of loading sequence for one block of loading}
#' \item \strong{--seq_max <MAX>} {any value greater than this will be set to this value}
#' \item \strong{--seq_min <MIN>} {any value less than this will be set to this}
#' \item \strong{--seq_outfile <FILE>} {write the modified sequence to a file}
#' \item \strong{--seq_rem_big <BIG>} {any values greater than this will be removed}
#' \item \strong{--seq_rem_small <SMALL>} {any value less than this will be removed}
#' \item \strong{--sequence <S1,S2,...>} {explicitly set the sequence of loading (default: [0.0, 1.0, 0.0])}
#' \item \strong{--sideways <DISTANCE>} {distance sideways from crack origin to free edge in 'c' direction of growth (default: infinite)}
#' \item \strong{--youngs <MODULUS>} {Young's modulus for compact tension coupon displacements (default 71000 MPa)}
#' }
#' @export

run_easigrow <- function(seq_filename,res_filename, scale, flags = NULL, options = NULL) {

  cmd = paste("-q", seq_filename,
              flags,
              "-s", scale,
              options,
              sep = " ")

  system2("easigrow", args = cmd, stdout = res_filename, stderr = "error.txt")

  if (file.info(res_filename)$size != 0) {
    return(read_easigrow(res_filename))
  } else {
    stop("Easigrow encountered errors, see error.txt")
  }


}

# crack_growth <- run_easigrow("data/sequences/rainflow-seq2.txt",
#                              50,
#                              options = "-a 0.00375,0.05 -e 0.5,0.05 --radius 0.003 -n 0.5 --image_outfile image.svg")



