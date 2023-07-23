#' Get a List of Available Models (Only for Openai Format).
#'
#' @return Models list.
#' @export
#'
#' @examples
#' \donttest{
#' modellist <- model_list()
#' }
#'
model_list <- function(){
  base_url <- Sys.getenv("OPENAI_BASE_URL")
  modelurl <- paste0(base_url,"/models")
  api_key <- Sys.getenv("OPENAI_API_KEY")
  response <- httr::GET(
    url = modelurl,
    add_headers(Authorization = paste("Bearer", api_key)),
    content_type_json(),
    encode = "json"
  )

  modelslist <- content(response)
  return (modelslist)
}
