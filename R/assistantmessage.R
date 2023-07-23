#' Create an Assistant Message.
#'
#' @param message Message text string.
#'
#' @return A two-element list consisting of role = "assistant", content = message.
#' @export
#'
#' @examples
#' assistantmessage_1 <- assistantmessage("How can I help you?")
#'
assistantmessage <- function(message){
  return(list(role = "assistant", content = message))
}
