% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/onemetric_overtime_graph.R
\name{onemetric_overtime_graph}
\alias{onemetric_overtime_graph}
\title{Graph Performance Metric Over Time for Various Investments}
\usage{
onemetric_overtime_graph(tickers = NULL, ..., gains = NULL, prices = NULL,
  y.metric = "cagr", window.units = 50, add.plot = FALSE, colors = NULL,
  lty = NULL, plot.list = NULL, points.list = NULL, legend.list = NULL,
  pdf.list = NULL, bmp.list = NULL, jpeg.list = NULL, png.list = NULL,
  tiff.list = NULL)
}
\arguments{
\item{tickers}{Character vector of ticker symbols that Yahoo! Finance 
recognizes, if you want to download data on the fly.}

\item{...}{Arguments to pass along with \code{tickers} to 
\code{\link{load_gains}}.}

\item{gains}{Numeric matrix with 1 column of gains for each investment (can 
be a vector if there is only one).}

\item{prices}{Numeric matrix with 1 column of prices for each investment (can 
be a vector if there is only one).}

\item{y.metric}{Character string specifying y-axis performance metric. 
Choices are: 

\code{"mean"} or \code{"sd"} for mean or standard deviation of gains.

\code{"growth"} or \code{"cagr"} for total or annualized growth.

\code{"mdd"} for maximum drawdown.

\code{"sharpe"} or \code{"sortino"} for Sharpe or Sortino ratio.

\code{"alpha"}, \code{"beta"}, or \code{"r.squared"} for those metrics from a 
fitted linear regression on benchmark fund.

\code{"pearson"} or \code{"spearman"} for Pearson or Spearman correlation 
with benchmark fund.

\code{"auto.pearson"} or \code{"auto.spearman"} for Pearson or Spearman 
autocorrelation, defined as the correlation between subsequent gains.}

\item{window.units}{Numeric value specifying the width of the moving window.}

\item{add.plot}{Logical value for whether to add plot data to current plot 
frame rather than open a new one.}

\item{colors}{Character vector of colors for each curve.}

\item{lty}{Numeric vector specifying line types for each curve.}

\item{plot.list}{List of arguments to pass to \code{\link[graphics]{plot}}.}

\item{points.list}{List of arguments to pass to 
\code{\link[graphics]{points}}.}

\item{legend.list}{List of arguments to pass to 
\code{\link[graphics]{legend}}.}

\item{pdf.list}{List of arguments to pass to \code{\link[grDevices]{pdf}}.}

\item{bmp.list}{List of arguments to pass to \code{\link[grDevices]{bmp}}.}

\item{jpeg.list}{List of arguments to pass to \code{\link[grDevices]{jpeg}}.}

\item{png.list}{List of arguments to pass to \code{\link[grDevices]{png}}.}

\item{tiff.list}{List of arguments to pass to \code{\link[grDevices]{tiff}}.}
}
\value{
In addition to the graph, a numeric matrix containing the performance metric 
over time for each investment.
}
\description{
Useful for visualizing the performance of a group of investments over time. 
The first investment is used as the benchmark if the requested metric 
requires one.
}
\examples{
\dontrun{
# Plot BRK-B's 50-day alpha over time since the start of 2016
fig <- onemetric_overtime_graph(tickers = c("VFINX", "BRK-B"), 
                                y.metric = "alpha", 
                                from = "2016-01-01")
}

}
\references{
Ryan, J.A. and Ulrich, J.M. (2017) quantmod: Quantitative Financial Modelling 
Framework. R package version 0.4-12, 
\url{https://CRAN.R-project.org/package=quantmod}.
}
