#' Extract Code String from JSON Structure String.
#'
#' @description
#'
#' Extracts code text content from the structured JSON string returned by the model.
#'
#' @param json_string JSON string to be extracted
#'
#' @return Code string.
#' @export
#'
#' @examples
#' Jsonstring <- '{"code":"x=1"}'
#' codestring <- extract_code(Jsonstring)
#'
extract_code <- function(json_string) {

  if (grepl("```R", json_string)|grepl("```r", json_string))
  {
    pattern <- "```(R|r)(.*?)```"
    match <- regmatches(json_string, regexec(pattern, json_string))
    code <- match[[1]][3]
  }
  else{
    pattern <- "\".?code.?\".?:.?\"(.*?)\".?}"
    match <- regmatches(json_string, regexec(pattern, json_string))

    code <- match[[1]][2]
    code<- gsub("\\\\n", "\n", code)
    code<- gsub("\\\\t", "\t", code)
    code<- gsub("\\\\\\\"", "\\\"", code)

  }



  return(code)
}

