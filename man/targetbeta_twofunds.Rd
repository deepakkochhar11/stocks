% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/targetbeta_twofunds.R
\name{targetbeta_twofunds}
\alias{targetbeta_twofunds}
\title{Backtest a Two-Fund Strategy that Targets a Certain Beta}
\usage{
targetbeta_twofunds(tickers = NULL, intercepts = NULL, slopes = NULL, ...,
  benchmark.ticker = NULL, reference.tickers = NULL, tickers.gains = NULL,
  benchmark.gains = NULL, reference.gains = NULL, target.beta = 0,
  tol = 0.15, window.units = 50, failure.method = "closer",
  maxall.tol = tol - 0.05, initial = 10000)
}
\arguments{
\item{tickers}{Character vector specifying 2 ticker symbols that Yahoo! 
Finance recognizes, if you want to download data on the fly.}

\item{intercepts}{Numeric vector of values to add to daily gains for each 
ticker.}

\item{slopes}{Numeric vector of values to multiply daily gains for each ticker 
by. Slopes are multiplied prior to adding intercepts.}

\item{...}{Arguments to pass along with \code{tickers} to 
\code{\link{load_gains}}.}

\item{benchmark.ticker}{Character string specifying ticker symbol for 
benchmark index for calculating beta. If unspecified, the first fund in 
\code{tickers} is used as the benchmark.}

\item{reference.tickers}{Character vector of ticker symbols to include on
graph as data points for comparative purposes.}

\item{tickers.gains}{Numeric matrix of gains, where each column has gains for 
a particular fund.}

\item{benchmark.gains}{Numeric vector of gains for the benchmark index for 
calculating beta. If unspecified, the first fund in \code{tickers.gains} is 
used as the benchmark.}

\item{reference.gains}{Numeric vector or matrix of gains for funds to 
include on graph as data points for comparative purposes.}

\item{target.beta}{Numeric value.}

\item{tol}{Numeric value specifying how far the effective portfolio beta has 
to deviate from \code{target.beta} to trigger a rebalancing trade.}

\item{window.units}{Numeric value specifying the width of the trailing moving 
window used to estimate each fund's beta.}

\item{failure.method}{Character string or vector specifying method(s) to use 
when fund betas are such that the target portfolio beta cannot be achieved. 
Choices are \code{"cash"}, \code{"fund1"}, \code{"fund2"}, 
\code{"fund1.maxall"}, \code{"fund2.maxall"}, \code{"inverse1"}, 
\code{"inverse2"}, and \code{"closer"}. See Details.}

\item{maxall.tol}{Numeric value specifying tolerance to use when implementing 
the \code{"fund1.maxall"} or \code{"fund2.maxall"} failure method. To 
illustrate, if \code{target.beta = 0}, fund 1 has a current beta of 1, fund 2 
has a current beta of 0.25, \code{failure.method = "fund2.maxall"}, and 
\code{maxall.tol = 0.1}, a trade will be triggered that results in 40\% fund 
2 and 60\% cash. The portfolio beta is \code{0.4 * 0.25 = 0.1}. The reason 
you might want \code{maxall.tol} to be less than \code{tol} is to avoid 
frequently triggering another trade on the very next day, as fund 2's beta 
changes a little and moves the portfolio beta outside of 
\code{[target.beta - tol, target.beta + tol]}.}

\item{initial}{Numeric value specifying what value to scale initial prices 
to.}
}
\value{
For each method, a 4-element list containing: 
\enumerate{
\item Numeric matrix named \code{fund.balances} giving fund balances over 
time. 
\item Numeric matrix named \code{fund.betas} giving fund betas over time. 
\item Numeric vector named \code{effective.betas} giving effective portfolio 
beta over time. 
\item Numeric value named \code{trades} giving the total number of trades 
executed.
}
}
\description{
Implements a two-fund strategy where allocations to each fund are adjusted to 
maintain some user-specified portfolio beta. For example, you could back-test 
a zero-beta (i.e. market neutral) UPRO/VBLTX strategy using this function.
}
\details{
The general implementation is as follows. Beta for each of the two funds is 
estimated based on the first \code{window.units} gains. Initial allocations 
are selected to achieve portfolio beta of \code{target.beta}. If that is not 
possible - for example, if \code{target.beta = 0} and both funds have 
positive beta - then the action taken depends on what method is selected 
through the \code{failure.method} input (details below).

Assuming the target beta is attainable, the function moves over 1 day, and 
applies each fund's gains for that day. It then re-calculates each fund's 
beta based on the \code{window.units}-width interval, and determines the 
effective portfolio beta based on fund allocations and betas. If the 
effective beta is outside of \code{[target.beta - tol, target.beta + tol]}, a 
rebalancing trade is triggered. As before, if the target beta cannot be 
achieved, certain actions are taken depending on the selected method.

When outside of a trade because the target beta could not be achieved, the 
function attempts to rebalance each time it shifts over to a new day, 
regardless of the effective portfolio beta.

When \code{failure.method = "cash"}, the entire portfolio balance is 
allocated to cash when the target beta cannot be achieved.

When \code{failure.method = "fund1"} (or \code{"fund2"}), the entire 
portfolio balance is allocated to the first (or second) fund when the target 
beta cannot be achieved.

When \code{failure.method = "fund1.maxall"} (or \code{"fund2.maxall"}), when 
the target beta cannot be achieved, fund 1 (or fund 2) is combined with cash, 
with the fund 1 (fund 2) allocation as high as possible while staying within 
\code{maxall.tol} of \code{target.beta}.

When \code{failure.method = "inverse1"} (or \code{"inverse2"}), an inverse 
version of the first (or second) fund is used when the target beta cannot be 
achieved. In many cases where the target beta cannot be achieved with the two 
funds, it can be achieved with an inverse version of one and the other. If 
the target beta still cannot be achieved, the entire portfolio balance is 
allocated to cash.

When \code{failure.method = "closer"}, the entire portfolio balance is 
allocated to whichever fund has a beta closer to \code{target.beta}.
}
\examples{
\dontrun{
# Backtest zero-beta UPRO/VBLTX strategy
beta0 <- targetbeta_twofunds(tickers = c("UPRO", "VBLTX"), target.beta = 0)
plot(beta0$fund.balances[, "Portfolio"])
}

}
\references{
Ryan, J.A. and Ulrich, J.M. (2017) quantmod: Quantitative Financial Modelling 
Framework. R package version 0.4-12, 
\url{https://CRAN.R-project.org/package=quantmod}.
}
