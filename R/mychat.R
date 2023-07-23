#' A Custom API Interface Function Example.
#'
#' @param message Text string passed directly to the model.
#' @param model The name string of the model you want to use.
#' @param showtokennum Whether to show the token's usage, defaults to FALSE.
#'
#' @return A two-element list consisting of answer(answer of the model) and status_code(Internet access status code, 200 for subsequent functions to work properly).
#' @export
#'
#' @examples
#' #The function as follows:
#'
#' mychat <- function(message, model, showtokennum = FALSE){
#'
#' # Provide environment variables to change the base URL
#' my_base_url <- Sys.getenv("MY_BASE_URL")
#'
#' # List structure of the JSON data to be transferred
#' data <- list(
#'   conversation_id = "123456",
#'   action = "_ask",
#'   model = model,
#'   jailbreak = "default",
#'   meta = list(
#'     id = as.character("12345678"),
#'     content = list(
#'       conversation = list(),
#'       internet_access = FALSE,
#'       content_type = "text",
#'       parts = list(
#'         list(
#'           content = message,
#'           role = "user"
#'         )
#'       )
#'     )
#'   )
#' )
#' cat("Start my chat...")
#'
#' # Send a POST request
#' response <- httr::POST(url = my_base_url, body = data, encode = "json")
#' cat("Chat complete...")
#'
#' # Determining the success of the request
#' if (response$status_code==200)
#' {
#'   myGPT_answer <- content(response, "text")
#' }else{
#'   myGPT_answer <- content(response, "text")
#'   message("Internet connection error: ", myGPT_answer)
#' }
#'
#' # Returns a list of answers and status_code (200 for subsequent functions to work properly) as a fixed structure.
#' return(list(answer = myGPT_answer, status_code = response$status_code))
#' }
#'
mychat <- function(message, model, showtokennum = FALSE){

  my_base_url <- Sys.getenv("MY_BASE_URL")
  data <- list(
    conversation_id = "123456",
    action = "_ask",
    model = model,
    jailbreak = "default",
    meta = list(
      id = as.character("12345678"),
      content = list(
        conversation = list(),
        internet_access = FALSE,
        content_type = "text",
        parts = list(
          list(
            content = message,
            role = "user"
          )
        )
      )
    )
  )
  cat("\nStart my chat...\n")
  response <- httr::POST(url = my_base_url, body = data, encode = "json")
  cat("\nChat complete...\n")
  if (response$status_code==200)
  {
    myGPT_answer <- httr::content(response, "text")
  }else{
    myGPT_answer <- httr::content(response, "text")
    message("Internet connection error: ", myGPT_answer)
  }
  return(list(answer = myGPT_answer, status_code = response$status_code))
}
