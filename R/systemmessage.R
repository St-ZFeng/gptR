#' Create a System Message.
#'
#' @param message Message text string.
#'
#' @return A two-element list consisting of role = "system", content = message.
#' @export
#'
#' @examples
#' systemmessage_1 <- systemmessage("Hello!")
#'
systemmessage <- function(message){
  return(list(role = "system", content = message))
}
