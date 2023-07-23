#' Open-AI API Interface Function.
#'
#' @param message Text string passed directly to the model.
#' @param model The name string of the model you want to use.
#' @param showtokennum Whether to show the token's usage, defaults to TRUE.
#'
#' @return A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
#' @export
#'
#' @examples
#' \donttest{
#'
#' chat_1 <- openaichat("Hello!", "gpt-4")
#' print(chat_1$answer)
#'
#' }
#'
#'
openaichat <- function(message, model, showtokennum = TRUE){

  messagelist <- list(usermessage(message = message))
  cat("\nStart openai chat...\n")
  result <- openaichat_continue(messagelist = messagelist, model = model, showresult = FALSE, showtokennum = showtokennum)
  cat("\nChat complete...\n")
  return (result)

}
