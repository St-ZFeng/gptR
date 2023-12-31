% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/openaichat_continue.R
\name{openaichat_continue}
\alias{openaichat_continue}
\title{Openai API Interface Function that Provides Continuous Chat.}
\usage{
openaichat_continue(
  messagelist,
  model,
  showresult = FALSE,
  showtokennum = TRUE
)
}
\arguments{
\item{messagelist}{A list of message(s).}

\item{model}{The name string of the model you want to use.}

\item{showresult}{Whether to show the chat result, defaults to FALSE.}

\item{showtokennum}{Whether to show the token's usage, defaults to TRUE.}
}
\value{
A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
}
\description{
This function provides a continuous way to chat with the openai gpt models by transmitting multiple messages.
It's best not to utilize unlimited loops to build successive chats, which can cause a lot of problems in R.
}
\examples{
message_A <- list(role = "user", content = "Hello!")
message_B <- list(role = "assistant", content = "Hello!")
message_C <- usermessage("How are you?")
message_step1 <- addmessage(message_A, message_B)
message_step2 <- addmessage(message_step1, message_C)
openaichat_continue(message_step2, "gpt-4", showresult = TRUE)

}
