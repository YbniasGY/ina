#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Part 1: Setting the stage.
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#
# First install the package ina - Internship on Network Analysis.
devtools::install_github('mihaiconstantin/ina')

# If devtools is not installed, you may run:
install.packages('devtools')

# Note that when you load this, qgraph is also being loaded.
library(ina)

# Set the working directory for outputing the graphs later.
setwd('your-directory-of-choice-here')

# Checking the documentation for the load_data function gives
# an overall idea about the datasets we have available.
?load_ina_data

# Let's load those datasets.
load_ina_data()



#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Part 2: Network visualization.
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#
# We have 4 matrices of weights we can plot. Number 1 indicates that
# the data was collected for the period between 2017 and 2018, and
# number 3 indicates that the data is for the period 2015-2018.
# - tesc_matrix_3
# - tesc_matrix_1
# - authorship_matrix_3
# - authorship_matrix_1
#

# Plotting tesc_matrix_1 (2017-2018).
plot_tesc_matrix('tesc_matrix_1')

# Plotting tesc_matrix_3 (2015-2018).
plot_tesc_matrix('tesc_matrix_3')

# Plotting authorship_matrix_1 (2017-2018).
plot_authorship_matrix('authorship_matrix_1')

# Plotting authorship_matrix_3 (2015-2018).
plot_authorship_matrix('authorship_matrix_3')
