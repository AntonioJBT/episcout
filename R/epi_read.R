#' @title Wraps as.tibble and data.table's fread with several assumptions as defaults
#'
#' @description epi_read() Read files with a consistent convenience function
#'
#' @param input_name file to read as a string
#'
#' @param ... pass any other data.table::fread() parameters
#'
#' @note Other parameters as specified by data.table::fread()
#' You are probably better off using the standard read.csv(),
#' data.table::fread() or other functions unless you are
#' reading in several similarly constructed files.
#' Files are read with data.table first and then converted to a tibble.
#' Columns will be read as integer, numeric or character only.
#' White space is stripped. Strings are read as character only.
#' Assumes the first row is a header.
#'
#' @return A tibble
#'
#' @author Antonio Berlanga-Taylor <\url{https://github.com/AntonioJBT/episcout}>
#'
#' @seealso \code{\link[data.table]{fread}}, \code{\link[tibble]{as.tibble}}.
#'
#' @examples
#'
#' \dontrun{
#' super_data <- epi_read('super_data.tsv')
#' }
#'
#' @export
#'

epi_read <- function(input_name = '',
										 na.strings = c(-Inf, 'NULL', NULL,
										 							 '.', ' ',
										 							 'NA', 'NaN', NA, '<NA>'),
										 header = TRUE,
										 stringsAsFactors = FALSE,
										 strip.white = TRUE,
										 ...) {
	if (!requireNamespace('tibble', quietly = TRUE)) {
		stop("Package tibble needed for this function to work. Please install it.",
				 call. = FALSE)
		}
	if (!requireNamespace('data.table', quietly = TRUE)) {
		stop("Package data.table needed for this function to work. Please install it.",
				 call. = FALSE)
		}
	tibble::as.tibble(as.data.frame(data.table::fread(input_name,
																										na.strings = na.strings,
																										header = header,
																										stringsAsFactors = stringsAsFactors,
																										strip.white = strip.white,
																										...
																										)
																	)

										)
	}