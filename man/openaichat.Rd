% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/openaichat.R
\name{openaichat}
\alias{openaichat}
\title{Open-AI API Interface Function.}
\usage{
openaichat(message, model, showtokennum = TRUE)
}
\arguments{
\item{message}{Text string passed directly to the model.}

\item{model}{The name string of the model you want to use.}

\item{showtokennum}{Whether to show the token's usage, defaults to TRUE.}
}
\value{
A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
}
\description{
Open-AI API Interface Function.
}
\examples{
\donttest{

chat_1 <- openaichat("Hello!", "gpt-4")
print(chat_1$answer)

}


}
