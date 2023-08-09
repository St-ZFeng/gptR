#' Openai API Interface Function that Provides Continuous Chat.
#' @description
#'
#' This function provides a continuous way to chat with the openai gpt models by transmitting multiple messages.
#' It's best not to utilize unlimited loops to build successive chats, which can cause a lot of problems in R.
#'
#' @param messagelist A list of message(s).
#' @param model The name string of the model you want to use.
#' @param showresult Whether to show the chat result, defaults to FALSE.
#' @param showtokennum Whether to show the token's usage, defaults to TRUE.
#'
#' @return A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
#' @export
#'
#' @examples
#' message_A <- list(role = "user", content = "Hello!")
#' message_B <- list(role = "assistant", content = "Hello!")
#' message_C <- usermessage("How are you?")
#' message_step1 <- addmessage(message_A, message_B)
#' message_step2 <- addmessage(message_step1, message_C)
#' openaichat_continue(message_step2, "gpt-4", showresult = TRUE)
#'
openaichat_continue <- function(messagelist, model, showresult = FALSE, showtokennum = TRUE){

  api_key <- Sys.getenv("OPENAI_API_KEY")
  base_url <- ifelse(Sys.getenv("OPENAI_BASE_URL") == "", "https://api.openai.com/v1", Sys.getenv("OPENAI_BASE_URL"))
  max_tokens <- ifelse(Sys.getenv("OPENAI_MAX_TOKENS") == "", Inf, Sys.getenv("OPENAI_MAX_TOKENS"))
  temperature <- ifelse(Sys.getenv("OPENAI_TEMPERATURE") == "", 1, Sys.getenv("OPENAI_TEMPERATURE"))
  top_p <- ifelse(Sys.getenv("OPENAI_TOP_P") == "", 1, Sys.getenv("OPENAI_TOP_P"))
  frequency_penalty <- ifelse(Sys.getenv("OPENAI_FREQUENCY_PENALTY") == "", 0, Sys.getenv("OPENAI_FREQUENCY_PENALTY"))
  presence_penalty <- ifelse(Sys.getenv("OPENAI_PRESENCE_PENALTY") == "", 0, Sys.getenv("OPENAI_PRESENCE_PENALTY"))


  chaturl <- paste0(base_url,"/chat/completions")


  response <- httr::POST(
    url = chaturl,
    add_headers(Authorization = paste("Bearer", api_key)),
    content_type_json(),
    encode = "json",
    body = list(
      model = model,
      messages = messagelist,
      max_tokens = max_tokens,
      temperature = temperature,
      top_p = top_p,
      presence_penalty = presence_penalty,
      frequency_penalty = frequency_penalty
    )
  )

  if (response$status_code == 200)
  {


    chatGPT_answer <- httr::content(response)$choices[[1]]$message$content

    if (showtokennum)
    {
      cat("\nToken usage:\n\n")
      tokennum <- httr::content(response)$usage
      for (ts in 1:length(tokennum))
      {
        cat(names(tokennum)[ts],":",tokennum[[ts]],"\n")
      }
      data.frame(tokennum)
    }
    chatGPT_answer <- stringr::str_trim(chatGPT_answer)
    if (showresult)
    {
      cat("\nBot:\n")
      cat(chatGPT_answer)
    }


  }else
  {
    chatGPT_answer <- httr::content(response)
    message("Internet connection error: ", chatGPT_answer)
  }
  return(list(answer = chatGPT_answer, status_code = response$status_code))
}
