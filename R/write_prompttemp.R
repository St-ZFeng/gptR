#' Exporting Prompt Template from .md File.
#'
#' @param md_text Prompt template text string.
#' @param filename File name of the .md file.
#'
#' @return Nothing.
#' @export
#'
#' @examples
#' write_prompttemp("Template content.", "temp.md")
#'
write_prompttemp <- function(md_text, filename){
  #package_root <- system.file(package = "gptR")
  #filename <- file.path(package_root, filename)
  writeLines(text = md_text, con = filename)
  cat("\nThe prompt template has been created in:\n",filename,"\n")
}
