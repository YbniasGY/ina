# Filename: data_functions.R
# Purpose: Used to store various functions related to data preprocessing used internally.


#' Internal. Used to create \code{tesc_data} dataset.
#'
#' Returns a data frame containing the TESC authors as seen in the document provided
#' by Loes. First column is the full name, second is the department.
#'
#' @export
tesc_authors <- function() {

	tesc_authors = as.data.frame(rbind(
		c('Loes Keijsers', 'Developmental Psychology'),
		c('Eeske van Roekel', 'Developmental Psychology'),
		c('Joanne Chung', 'Developmental Psychology'),
		c('Jaap Denissen', 'Developmental Psychology'),
		c('Stefan Bogaerts', 'Developmental Psychology'),
		c('Theo Klimstra', 'Developmental Psychology'),
		c('Sjoerd van Halem', 'Developmental Psychology'),
		c('Neha Moopen', 'Developmental Psychology'),
		c('Savannah Boele', 'Developmental Psychology'),
		c('Amy See', 'Developmental Psychology'),
		c('Marieke de Bruine', 'Developmental Psychology'),
		c('Anne Reitz', 'Developmental Psychology'),
		c('Angelique Cramer', 'Methodology and Statistics'),
		c('Kim de Roover', 'Methodology and Statistics'),
		c('Jeroen Vermunt', 'Methodology and Statistics'),
		c('Leonie Vogelsmeier', 'Methodology and Statistics'),
		c('Kyle Lang', 'Methodology and Statistics'),
		c('Ijsbrand Leertouwer', 'Methodology and Statistics'),
		c('Katrijn van Deun', 'Methodology and Statistics'),
		c('Nina Kupper', 'Medical Psychology'),
		c('Wijo Kop', 'Medical Psychology'),
		c('Hester Trompetter', 'Medical Psychology'),
		c('Mirela Habibovic', 'Medical Psychology'),
		c('Tony Evans', 'Social Psychology'),
		c('Seger Breugelmans', 'Social Psychology'),
		c('Olga Stavrova', 'Social Psychology'),
		c('Michael Bender', 'Social Psychology'),
		c('Willem Sleegers', 'Social Psychology'),
		c('Ilja van Beest', 'Social Psychology'),
		c('Marc Brandt', 'Social Psychology'),
		c('Rabia Kodapanakkal', 'Social Psychology'),
		c('Hannes Rosenbusch', 'Social Psychology'),
		c('Frederca Angeli', 'Organization Studies'),
		c('Marianne van Woerkom', 'HR Studies'),
		c('Dorine Kooij', 'HR Studies'),
		c('Karina van de Voorde', 'HR Studies'),
		c('Marc van Veldhoven', 'HR Studies'),
		c('Daphne van der Kruijssen', 'HR Studies'),
		c('Esther de Vries', 'Tranzo'),
		c('Inge Bongers', 'Tranzo'),
		c('Dike van de Meehn', 'Tranzo'),
		c('Sebastiaan Peek', 'Tranzo'),
		c('Ylva Hendriks', 'Tranzo'),
		c('Aurelie Lemmens', 'Marketing/ Consumer Behavior'),
		c('Rik Pieters', 'Marketing/ Consumer Behavior'),
		c('Groep van Max Louwerse', 'TSH'),
		c('Eric Postma', 'TSH')
		), stringsAsFactors = F)

	colnames(tesc_authors) <- c('Name', 'Department')

	return(as.data.frame(tesc_authors))
}



#' Internal. Used to create \code{authorship_data_1} and \code{authorship_data_3} datasets.
#'
#' Takes as input a .csv file provided by TescPerf Python library, collected
#' from pure.uvt.nl, and outputs a list of collaboration. Each of the
#' collaborations in the list represents a paper and the TSB members
#' that collaborated on that paper. The order in the vector is
#' given by the order of occurrence in the list scrapped from
#' pure.uvt.nl.
#'
#' @param file_path (character) The path to the raw scraped .csv data.
#' @param save (bool)
#' @param file (character)
#'
#' @export
authorship_data <- function(file_path, save = F, file = NA) {

	csv_data = read.csv(file_path, encoding = "UTF-8", stringsAsFactors = F)

	authors = as.character(csv_data$TESC.Authors)
	authors = apply(as.data.frame(authors, stringsAsFactors = F), 2, strsplit, "#")
	authors = authors$authors
	authors = authors[sapply(authors, length) != 0]

	# Perform authorship data cleaning here.
	authors = str_trim(authors)
	authors = get_all_last_names(authors)

	if(save) {
		lapply(authors, write, file, append = TRUE, ncolumns = 1000, sep = '#')
	}

	return(authors)
}



#' Internal. Used to build the \code{tesc_matrix_1} and \code{tesc_matrix_1} datasets.
#'
#' Builds the matrix of weights only for the people that are currently part of TESC.
#' For each paper it checks which authors are part of the TESC and it extracts
#' them preserving the order. The newly extract vector for a particular
#' paper represents how people TESC members collaborated in that case.
#' The first one is considered to have collaborated with the rest
#' of the authors in the vector. Each such edge is awarded
#' one point in the matrix of weights.
#'
#' @param authorship_data (list of vectors) Each vectors represents the TSB authors that collaborated on that paper.
#' @param tesc_data (data frame) A square matrix with only the authors that are TESC collaborators and the output of the \code{tesc_data} function.
#' @param verbose (bool)
#'
#' @return A square matrix with only the authors that are TESC collaborators and the subsequent weights indicating the way they collaborated.
#'
#' @export
tesc_matrix <- function(authorship_data, tesc_data, verbose = T) {

	matrix = matrix(0, length(tesc_data$Name), length(tesc_data$Name))

	for(collaboration in authorship_data)
	{
		tesc_collaborators = integer()

		# If this condition is not meet it means that the last name could
		# not be determined (e.g., S.S. Soedamah-muthu).
		if(!is_empty(collaboration))
		{
			for(index in 1:length(collaboration))
			{
				# The results is the index in the tesc_data$Name where the match occurred.
				# Since tesc_data$Name was used to build the matrix, it means that
				# the correspondence between these two objects remains the same.
				result = grep(paste('\\b', regmatches(collaboration[index], regexpr('(\\w+$)', collaboration[index])), '\\b', sep = ''), tesc_data$Name)

				if(!is_empty(result))
				{
					tesc_collaborators = c(tesc_collaborators, result)
				}
			}
		}

		if(length(tesc_collaborators) > 1)
		{
			# There multiple TESC collaborators working in this paper.
			# The logic: first author in the vector is considered
			# to have collaborated with subsequent authors in
			# the vector. For instance, Bob, Alice, Marry
			# results in: Bob -> Alice, Bob -> Marry.
			# The weights for those coordinates
			# get incremented by one.
			for(edge in tesc_collaborators[-1])
			{
				matrix[tesc_collaborators[1], edge] = matrix[tesc_collaborators[1], edge] + 1
			}

		} else if(length(tesc_collaborators) == 1)
		{
			# There is only one TESC collaborator working on this paper.
			# In this case the value on the main diagonal for that
			# author is incremented by one.
			matrix[tesc_collaborators[1], tesc_collaborators[1]] = matrix[tesc_collaborators[1], tesc_collaborators[1]] + 1
		}

		# Printing some feedback during the matrix construction.
		if(verbose)
		{
			if (length(tesc_collaborators) < 1)
			{
				cat(paste('-> collaborators:', paste(collaboration, collapse = ', ')), '\n')
				cat('-> no TESC collaborators', '\n')
			} else
			{
				cat(paste('-> collaborators:', paste(collaboration, collapse = ', ')), '\n')
				cat(paste('-> TESC collaborators:', paste(tesc_data$Name[tesc_collaborators], collapse = ', ')), '\n')
			}
			cat(rep('-', 30), '\n')
		}
	}

	colnames(matrix) <- tesc_data$Name
	rownames(matrix) <- tesc_data$Name

	return(matrix)
}



#' Internal. Used to build \code{authorship_matrix_1} and \code{authorship_matrix_3} datasets.
#'
#' Builds the matrix of weights for all the authors in the TSB at a point in time.
#' The first one is considered to have collaborated with the rest
#' of the authors in the vector. Each such edge is awarded
#' one point in the matrix of weights.
#'
#' @param authorship_data (list of vectors) Each vectors represents the TSB authors that collaborated on that paper.
#' @param verbose (bool)
#'
#' @return a square matrix with the TSB collaborators and the subsequent weights indicating the way they collaborated.
#'
#' @export
authorship_matrix <- function(authorship_data, verbose = T) {

	all_authors = unlist(authorship_data)

	# Manual corrections.
	all_authors[all_authors == 'Riem'] = 'Hendricx-Riem'


	tsb_data = data.frame(Names = levels(as.factor(sort(all_authors))))
	matrix = matrix(0, length(tsb_data$Names), length(tsb_data$Names))


	for(collaboration in authorship_data)
	{
		tsb_collaborators_indices = integer()

		if(!is_empty(collaboration))
		{
			for(index in 1:length(collaboration))
			{
				result = grep(paste('^', collaboration[index], '$', sep = ''), tsb_data$Name)

				if(!is_empty(result))
				{
					tsb_collaborators_indices = c(tsb_collaborators_indices, result)
				}
			}
		}


		if(length(tsb_collaborators_indices) > 1)
		{
			for(edge in tsb_collaborators_indices[-1])
			{
				matrix[tsb_collaborators_indices[1], edge] = matrix[tsb_collaborators_indices[1], edge] + 1
			}

		} else if(length(tsb_collaborators_indices) == 1)
		{
			matrix[tsb_collaborators_indices[1], tsb_collaborators_indices[1]] = matrix[tsb_collaborators_indices[1], tsb_collaborators_indices[1]] + 1
		}


		if(verbose)
		{
			if (length(tsb_collaborators_indices) < 1)
			{
				cat(paste('-> collaborators:', paste(collaboration, collapse = ', ')), '\n')
				cat('-> no TSB collaborators', '\n')
			} else
			{
				cat(paste('-> collaborators:', paste(collaboration, collapse = ', ')), '\n')
				cat(paste('-> TSB collaborators:', paste(tsb_data$Name[tsb_collaborators_indices], collapse = ', ')), '\n')
			}
			cat(rep('-', 30), '\n')
		}
	}

	colnames(matrix) <- tsb_data$Names
	rownames(matrix) <- tsb_data$Names

	return(matrix)
}
