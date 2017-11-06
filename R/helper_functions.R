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
