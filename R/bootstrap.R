
#' @title Load the data into the environment.
#'
#' @description
#' Makes the authorship data available in the environment for further use.
#'
#' @details
#' Several datasets are made available:
#' \itemize{
#'   \item csv_scarped_data_1. Raw scraped data for one years (2017-2018)
#'   \item csv_scarped_data_3. Raw scraped data for three years (2015-2018)
#'   \item authorship_data_1. Formated list of vectors, where each vector contains
#'   the last name of the TSB authors that collaborated on a particular paper during 2017-2018.
#'   \item authorship_data_1. Formated list of vectors, where each vector contains
#'   the last name of the TSB authors that collaborated on a particular paper during 2015-2018.
#'   \item tesc_data. Data frame with two columns: 'Names' and 'Department'. \code{tesc_data$Names} holds
#'   the full names of the authors that are part of TESC. \code{tesc_data$Department} holds their respective department.
#'   The data is based on the document obtained from Loes.
#'   \item tesc_matrix_1. Matrix of weights indicating the collaborations on publishing papers.
#'   For TESC authors only, 2017-2018.
#'   \item tesc_matrix_3. Matrix of weights indicating the collaborations on publishing papers.
#'   For TESC authors only, 2015-2018.
#'   \item authorship_matrix_1. Matrix of weights indicating the collaborations on publishing papers.
#'   For all TSB employees at that point in time, 2017-2018.
#'   \item authorship_matrix_3. Matrix of weights indicating the collaborations on publishing papers.
#'   For all TSB employees at that point in time, 2015-2018.
#' }
#'
#' The matrices of weights are build in the following manner:
#' \itemize{
#'   \item Let \code{col = c("X1", "Alice", "X2", "Bob", "Beth", "X3")} be a vector that
#'   represents the collaboration on a paper, where \code{Xn} are the external
#'   authors, and Alice, Bob, and Beth are TSB employees. The order of the authors reflects
#'   the order presented on the pure.uvt.nl.
#'   \item The external employees are removed and the \code{col} vector holds only the TSB employees. 
#'   For this example, the result will be \code{"Alice", "Bob", "Beth"}.
#'   \item The resulting order is important because the first TSB in the vector represents the
#'   node of origin and the rest the nodes of destination.
#'   \item In the case of \code{tesc_matrix_1} and \code{tesc_matrix_3} one additional strip is
#'   performed, namely, only the TSB employees that are also part of the TESC are included.
#' }
#'
#' To use these datasets simply type their names in your scripts.
#'
#' @export
load_data <- function() {

	demo <- tesc_matrix(authorship_data_1, tesc_data, verbose = T)
	rm(demo)

	cat('\n')
	cat('The following datasets are available:\n')
	cat('\t', '- csv_scarped_data_3', '\n')
	cat('\t', '- csv_scarped_data_1', '\n')
	cat('\t', '- authorship_data_3', '\n')
	cat('\t', '- authorship_data_1', '\n')
	cat('\t', '- tesc_data', '\n')
	cat('\t', '- tesc_matrix_3', '\n')
	cat('\t', '- tesc_matrix_1', '\n')
	cat('\t', '- authorship_matrix_3', '\n')
	cat('\t', '- authorship_matrix_1', '\n')
	cat('Please check the documentation for "load_data" for a detailed description of these datasets.', '\n\n')
	cat('The list of TESC collaborators was determined based on the document obtained from Loes.', '\n')

}
