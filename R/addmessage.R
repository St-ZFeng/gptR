#' Putting a New Chat Message into Old Message(s).
#' @description
#' Conveniently constructs chat message list to be passed as arguments to the chatgpt API.
#' @param oldmessage Old message or message list.
#' @param newmessage New message.
#'
#' @return Merged chat message list.
#' @export
#'
#' @examples
#' message_A <- list(role = "user", content = "Hello!")
#' message_B <- list(role = "assistant", content = "Hello!")
#' message_C <- usermessage("How are you?")
#' message_step1 <- addmessage(message_A, message_B)
#' message_step2 <- addmessage(message_step1, message_C)
#'
addmessage <- function(oldmessage, newmessage){
  if (class(oldmessage[[1]])=="list"){
    message <- append(oldmessage,list(newmessage))
  }else{
    message <- list(oldmessage,newmessage)
  }

  return(message)
}
