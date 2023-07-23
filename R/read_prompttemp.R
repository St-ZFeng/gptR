#' Importing Prompt Template from .md File.
#'
#' @param filename File name of the .md file.
#'
#' @return Prompt template text string.
#' @export
#'
#' @examples
#' \donttest{
#' prompttemp <- read_prompttemp("temp.md")
#' }
#'
read_prompttemp<-function(filename){
  #package_root <- system.file(package = "gptR")
  #filename <- file.path(package_root, filename)
  md_text <- readLines(con = filename)
  fulltext<-paste0(md_text, collapse = "", seq = "\n")
  fulltext<-sub("[\r\n]+$", "", fulltext)
  cat("\nThe prompt template has been loaded from:\n",filename,"\n")
  return(fulltext)
}
