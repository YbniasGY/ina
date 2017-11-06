# Filename: plot_functions.R
# Purpose: Used to the matrices of weigths.


#' Plots 4 network graphs for either \code{tesc_matrix_1} or \code{tesc_matrix_3}.
#'
#' The graphs are stored in the current working directory.
#'
#' @param tesc_matrix_name (character) The name of the TESC matrix to plot.
#' The name, not the matrix itself.
#' @param directed (bool) Enables or disables the \code{directed} parameter
#' within \code{qgraph} function.
#'
#' @export
plot_tesc_matrix <- function(tesc_matrix_name, directed = FALSE) {

	if (tesc_matrix_name == 'tesc_matrix_1')
	{
		tesc_matrix = tesc_matrix_1
		year = '2017-2018'
		name = 'tesc_matrix_1'

	} else if (tesc_matrix_name == 'tesc_matrix_3')
	{
		tesc_matrix = tesc_matrix_3
		year = '2015-2018'
		name = 'tesc_matrix_3'
	}

	# Determine whether a TESC author has published on not a paper.
	published = apply(tesc_matrix, 1, sum) > 0
	published[published == T] = 'Published'
	published[published == F] = 'Not Published'

	if (tesc_matrix_name == 'tesc_matrix_1')
	{
		tesc_data$Published_1 = as.factor(published)

	} else if(tesc_matrix_name == 'tesc_matrix_3')
	{
		tesc_data$Published_3 = as.factor(published)
	}


	# Plot the graphs per department.
	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(tesc_data$Department),

		# General specifications.
		bidirectional = T,
		directed = directed,

		# Nodes and edges related.
		vsize = c(5, 13),
		vTrans = 150,
		esize = 1,
		borders = F,

		# Layout related.
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_department_1.0', sep = '')
	)

	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(tesc_data$Department),

		# General specifications.
		bidirectional = T,
		directed = directed,

		# Nodes and edges related.
		vsize = 4,
		vTrans = 150,
		esize = 1,
		borders = F,

		# Layout related.
		layout = 'groups',
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_department_1.1', sep = '')
	)


	# Plot the graphs per published paper status.
	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(published),

		# General specifications.
		bidirectional = T,
		directed = directed,

		# Nodes and edges related.
		vsize = c(5, 13),
		vTrans = 150,
		esize = 1,
		borders = F,
		color = c('gray', 'green'),

		# Layout related.
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_published_1.0', sep = '')
	)

	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(published),

		# General specifications.
		bidirectional = T,
		directed = directed,

		# Nodes and edges related.
		vsize = 4,
		vTrans = 150,
		esize = 1,
		borders = F,
		color = c('gray', 'green'),

		# Layout related.
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_published_1.1', sep = '')
	)
}



#' Plots 4 network graphs for either \code{authorship_matrix_1} or \code{authorship_matrix_1}.
#'
#' The graphs are stored in the current working directory.
#'
#' @param tesc_matrix_name (character) The name of the authorship matrix to plot.
#' The name, not the matrix itself.
#' @param directed (bool) Enables or disables the \code{directed} parameter
#' within \code{qgraph} function.
#'
#' @export
plot_authorship_matrix <- function(authorship_matrix_name, directed = FALSE) {

}
