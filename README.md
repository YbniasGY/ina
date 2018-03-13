# Internship on Network Analysis for authorship data

## Description
This package is a result of my internship on Network Analysis and authorship data.
The data used was obtained using the [TescPerf](https://github.com/mihaiconstantin/TescPerf) `Python` tool for web scrapping. This package is only intended for a limited audience and has a very specific usage. If you want to find out more, check the documentation for the exported functions. 

## Installation

```r
# You can use devtools to install this package.
devtools::install('mihaiconstantin/ina')
```

## Examples

```r
# Plotting tesc_matrix_3 (2015-2018).
plot_tesc_matrix('tesc_matrix_3')
```

Output:

- [Authorship collaboration between TESC members for 2015-2018 per department](https://github.com/mihaiconstantin/ina/blob/master/analyses/graphs/tesc_matrix_3_department.png)

![Authorship collaboration between TESC members for 2015-2018 per department](https://raw.githubusercontent.com/mihaiconstantin/ina/master/analyses/graphs/tesc_matrix_3_department.png "Authorship collaboration between TESC members for 2015-2018 per department")

- [Authorship collaboration between TESC members for 2015-2018 and publication status](https://github.com/mihaiconstantin/ina/blob/master/analyses/graphs/tesc_matrix_3_published.png)

![Authorship collaboration between TESC members for 2015-2018 and publication status](https://raw.githubusercontent.com/mihaiconstantin/ina/master/analyses/graphs/tesc_matrix_3_published.png "Authorship collaboration between TESC members for 2015-2018 and publication status")


## Usages
Data from this package is used to power the [collaboration network Shiny app](https://maconstantin.shinyapps.io/tesc-collaborations/).

> This package depends on the [`qgraph`](https://github.com/SachaEpskamp/qgraph) for plotting the networks and more.
