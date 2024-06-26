% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/job_utils.R
\encoding{UTF-8}
\name{export}
\alias{export}
\title{What to return from a job}
\usage{
export(value = "changed", file = NULL)
}
\arguments{
\item{value}{What to return. One of:
\itemize{
\item \code{"all"}: Return everything, including imports
\item \code{"changed"} (default): Return all variables that are not identical to import.
\item \code{"new"}: Return only new variable names.
\item \code{c(var1, var2, ...)}: Return these variable names.
\item \code{NULL} or \code{"none"}: Return nothing. This is particularly useful for unnamed code chunks.
}}

\item{file}{Name of \code{.RData} file to export to. If not \code{NULL}, nothing will be returned
to the main session (corresponding to \code{export("none")}).}
}
\value{
\code{NULL} invisibly.
}
\description{
Call this function as the last line in \code{job::job()} to select what is exported
back into \code{globalenv()}. \code{export()} does nothing if called in any other context.
}
\details{
Under the hood, this function merely \code{rm()} variables that does not match \code{value}.
Because \code{job::job()} returns everything at the end of the script, this defines
what is returned.
}
\examples{
if (rstudioapi::isAvailable()) {
  a = 55
  b = 77
  d = 88
  job::job({n = 11; a = 55; job::export("all")})  # export a, b, d, n
  job::job({n = 11; a = 11; job::export("changed")})  # export a, n
  job::job({n = 11; a = 11; job::export("new")})  # export n
  job::job({n = 11; a = 55; job::export(c(a, d, b))})  # export a, d, b
  job::job({n = 11; a = 55; job::export("none")})  # export nothing

  # To file
  job::job({n = 11; a = 11; job::export("changed", file = "jobresult.RData")})  # save a, n
  jobresult = new.env()  # import to this env instead of global
  load("jobresult.RData", envir = jobresult)
  print(jobresult$n)
}
}
\author{
Jonas Kristoffer Lindeløv, \email{jonas@lindeloev.dk}
}
