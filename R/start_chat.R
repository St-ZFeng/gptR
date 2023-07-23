#' Select a Particular API Interface Function for a Single Chat.
#'
#' @param message Text string passed directly to the model.
#' @param model The name string of the model you want to use.
#' @param showtokennum Whether to show the token's usage, defaults to TRUE.
#' @param chat_function A custom model chat API interface function that takes three parameters, message, model, and tokennum, and returns a list consisting of answer and status_code. Defaults to NULL, at which point the built-in openai style interface function is called. For custom function styles, see the function mychat().
#'
#' @return A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
#' @export
#'
#' @examples
#' \donttest{
#' # Use the openai interface function by default
#'
#' New_chat <- start_chat("Hello!","gpt-4",chat_function=mychat)
#' cat(New_chat$answer)
#'
#' }
start_chat <- function(message, model, showtokennum = TRUE, chat_function = NULL){
  if (is.null(chat_function))
  {
    return(openaichat(message = message, model = model, showtokennum = showtokennum))
  }else{
    return(chat_function(message = message, model = model, showtokennum = showtokennum))
  }
}
