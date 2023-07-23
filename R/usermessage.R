#' Create a User Message.
#'
#' @param message Message text string.
#'
#' @return A two-element list consisting of role = "user", content = message.
#' @export
#'
#' @examples
#' usermessage_1 <- usermessage("Hello!")
#'
usermessage <- function(message){
  return(list(role = "user", content = message))
}
