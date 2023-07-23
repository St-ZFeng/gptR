#' Check the Prompt Template File.
#' @description
#'
#' Check if the prompt template file exists, if it does, import it, if it doesn't, create a .md file and write the built-in template, then import it.
#'
#' @param temptype Type string of the template.
#' @param oldprompttemp Built-in template
#'
#' @return prompt template text string
#' @export
#'
#' @examples
#' # It is best not to call this function independently.
#'
check_prompttemp <- function(temptype, oldprompttemp){
  filename <- paste0(temptype, "temp.md")
  package_root <- system.file(package = "gptR")
  filenamedir <- file.path(package_root, filename)
  if (!file.exists(filenamedir))
  {
    write_prompttemp(md_text = oldprompttemp, filename = filenamedir)
  }
  return (read_prompttemp(filename = filenamedir))
}
