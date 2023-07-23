#' Get a Data Frame of Available Models(Only for Openai Format).
#'
#' @return Models data frame.
#' @export
#'
#' @examples
#'
#' model_table()
#'
model_table <- function(){
  modellist <- model_list()
  modellist <- modellist$data
  model1 <- modellist[[1]]
  names <- names(model1)
  modeltable <- data.frame()
  for (model in modellist){
    row <- data.frame()
    for (i in 1:(length(names)))
    {
      if (!(names[i] %in% names(model)))
      {
        row[1,names[i]] <- NA
      }

      else if (length(model[[names[i]]])==0)
      {
        row[1,names[i]] <- NA
      }
      else if (length(model[[names[i]]])==1)
      {
        row[1,names[i]]=model[[names[i]]]
      }
      else
      {
        text <- ""
        for (j in 1:length(model[[names[i]]]))
        {
          text=paste(text,(model[[names[i]]][[j]]))
        }
        row[1,names[i]] <- text
      }
    }
    modeltable <- rbind(modeltable, row)
  }
  return(modeltable)
}
