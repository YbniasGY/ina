# Filename: plot_functions.R
# Purpose: Used to the matrices of weigths.


#' Plots 2 network graphs for either \code{tesc_matrix_1} or \code{tesc_matrix_3}.
#'
#' The graphs are stored in the current working directory.
#'
#' @param tesc_matrix_name (character) The name of the TESC matrix to plot.
#' The name, not the matrix itself.
#' @param size (vector) Vector of two integer values. First value represents the width
#' of the graph, and the second reprsents the hight of the graph. Defaults to \code{c(15, 15)}.
#' Uses inch as the unit of measurement.
#'
#' @export
plot_tesc_matrix <- function(tesc_matrix_name, size = c(8, 8)) {

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
	} else
	{
		stop('Invalid name for argument "tesc_matrix_name".')
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


	# Plot the graph per department.
	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(tesc_data$Department),

		# General specifications.
		bidirectional = T,
		directed = T,

		# Nodes and edges related.
		vsize = 5,
		vTrans = 100,
		borders = F,
		cut = 2,

		# Layout related.
		layout = 'groups',
		width = size[1],
		height = size[2],

		# Context.
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_department', sep = '')
	)


	# Plot the graph per published paper status.
	qgraph(
		tesc_matrix,
		labels = get_last_name(tesc_data$Name),
		groups = as.factor(published),

		# General specifications.
		bidirectional = T,
		diag = T,
		directed = T,

		# Nodes and edges related.
		# vsize = c(5, 10),
		vsize = 5,
		vTrans = 150,
		borders = F,
		cut = 1,
		color = c('gray', 'green'),

		# Layout related.
		layout = 'spring',
		width = size[1],
		height = size[2],

		# Context.
		filetype = 'png',
		title = paste('Authorship collaboration between TESC members for ', year, sep = ''),
		filename = paste(name, '_published', sep = '')
	)
}



#' Plots a network graph for either \code{authorship_matrix_1} or \code{authorship_matrix_1}.
#'
#' The graphs are stored in the current working directory.
#'
#' @param tesc_matrix_name (character) The name of the authorship matrix to plot.
#' The name, not the matrix itself.
#' @param size (vector) Vector of two integer values. First value represents the width
#' of the graph, and the second reprsents the hight of the graph. Defaults to \code{c(35, 35)}.
#' Uses inch as the unit of measurement.
#'
#' @export
plot_authorship_matrix <- function(authorship_matrix_name, size = c(35, 35)) {

	if(authorship_matrix_name == 'authorship_matrix_1')
	{
		authorship_matrix = authorship_matrix_1
		year = '2017-2018'
		name = 'authorship_matrix_1'

	} else if(authorship_matrix_name == 'authorship_matrix_3')
	{
		authorship_matrix = authorship_matrix_3
		year = '2015-2018'
		name = 'authorship_matrix_3'
	}
	else
	{
		stop('Invalid name for argument "authorship_matrix_name".')
	}

	labels = rownames(authorship_matrix)

	colors_membership = rep('white', dim(authorship_matrix)[1])
	colors_membership[extract_tesc_authors(authorship_matrix)] = 'green'


	qgraph(
		authorship_matrix,
		labels = labels,

		# General specifications.
		bidirectional = T,
		directed = F,
		diag = F,

		# Nodes and edges related.
		vsize = 2,
		vTrans = 150,
		border.width = .1,
		color = colors_membership,

		# Layout related.
		layout = 'spring',
		width = size[1],
		height = size[2],

		# Context.
		filetype = "png",
		title = paste('Authorship collaboration between TSB members for ', year, sep = ''),
		filename = paste(name, '_tsb', sep = '')
	)
}
