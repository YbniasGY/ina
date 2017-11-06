# Filename: helper_functions.R
# Purpose: Used to store various helper functions used internally.



#' Internal. Strips the initials from a name. E.g., M. A. Constantin -> Constantin.
#'
#' @param list_authors (list of vectors)
#'
#' @export
strip_initials <- function(list_authors) {
	return(lapply(list_authors, gsub, pattern = '([A-Z.\\s]+)\\s', replacement = ''))
}



#' Internal. Gets the last word of a full name (i.e., the last name). E.g., M. A. Constantin -> Constantin.
#'
#' Tried against these scenarios: D.M. Beneken Genaamd Kolmer, M.J. Brandt, Geert H. van Kollenburg, Jac J. L. van der Klink, L.V. van de Poll-Franse,
#' Y.T.M. Vanneste-van Zandvoort, M.A.L.M. vanAssen, L.V. van de PollFranse, L.V. van de PFranse, E.A.L. De Caluw? (? = special character).
#'
#' The regex used: \code{([A-Z\\u00C0-\\u017F][a-z\\u00C0-\\u017F]+-)?([A-Z\\u00C0-\\u017F][a-z\\u00C0-\\u017F]+)$}
#'
#' @param full_name (string or vector)
#'
#' @export
get_last_name <- function(full_name) {
	return(regmatches(full_name, regexpr('([A-Z\u00C0-\u017F][a-z\u00C0-\u017F]+-)?([A-Z\u00C0-\u017F][a-z\u00C0-\u017F]+)$', full_name)))
}



#' Internal. Applies get_last_name function to a list of vectors (paper collaboration).
#'
#' @param list_authors (list of vectors)
#'
#' @return A new list of vectors containing only the last names.
#'
#' @export
get_all_last_names <- function(list_authors) {
	return(lapply(list_authors, get_last_name))
}



#' Internal. Trims the leading and trailing space of a string.
#'
#' @param list_authors (list of vectors)
#'
#' @export
str_trim <- function(list_authors) {
	return(lapply(list_authors, gsub, pattern = '^\\s+|\\s+$', replacement = ''))
}



#' Internal. Determines whether a result is of type integer(0) or character(0).
#'
#' @param input (any)
#'
#' @export
is_empty <- function(input) {
	return(((is.integer(input) && !length(input)) || (is.character(input) && !length(input))))
}



#' Internal. Find the location of a name inside a vector.
#'
#' @param name (character) The name that is used for the search.
#' @param inside (vector) The character vector where the \code{name} is searched in.
#'
#' @return The index where the match occurred or \code{integer(0)} otherwise.
#'
#' @export
find_name <- function(name, inside) {
	pattern = paste('\\b', name ,'\\b', sep = '')
	return(grep(pattern, inside))
}



#' Performs the extraction of TESC authors from a larger list of authors.
#'
#' Can be useful to extract only the TESC authors from the TSB vector of authors.
#' The TESC authors vector is based on the \code{tesc_data} data frame.
#' See \code{\link{load_ina_data}} function for more details about the datasets.
#'
#' @param authors (vector) The character vector from which the TESC authors are extracted.
#' Typically it is the TSB vector of authors obtained from \code{rownames(authorship_matrix_1)} or
#' \code{rownames(authorship_matrix_3)}.
#'
#' @return A vector with the indices where TESC authors are found.
#'
#' @export
extract_tesc_authors <- function(authors) {
	tesc_authors_last_names = unlist(get_all_last_names(tesc_data$Name))
	authors_last_names = rownames(authors)

	found_tesc_authors = unlist(lapply(tesc_authors_last_names, find_name, inside = authors_last_names))
	return(found_tesc_authors)
}
