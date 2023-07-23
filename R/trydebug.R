#' Using Chatgpt or Any Other Large Model to Fix Your Code to Achieve Your Need.
#' @description
#'
#' This function is actually a subsidiary function of the AIPROCESS function. If it's debugmode parameter is TRUE, this function is automatically called once for better results when the model-supplied code runs an error. However, this function can also be called independently, please refer to the parameter explanation and sample code for specific usage.
#'
#' @param need Your need, which should be a string.
#' @param code Your code string.
#' @param error The problem of the code.
#' @param model The name string of the model you want to use.
#' @param ... Any data you provide to the model, which can be more than one. But in fact the model doesn't read the data details, just gets it's names and types.
#' @param runmode Whether to show the token's usage, defaults to TRUE.
#' @param showtokennum Whether or not to show the use amount of tokens after a model call, defaults to TRUE.
#' @param chat_function A custom model chat API interface function that takes three parameters, message, model, and tokennum, and returns a list consisting of answer and status_code. Defaults to NULL, at which point the built-in openai style interface function is called. For custom function styles, see the function mychat().
#'
#' @return Anything or nothing.
#' @export
#'
#' @examples
#' \donttest{
#'
#' x <- 1:100
#' y <- 1:100
#' df1 <- data.frame(x = x, y = y)
#'
#' trydebug("Add 1 to the first column of the data frame","df1 <- df1+1","The code adds 1 to all columns in the data frame", "gpt-4")
#'
#'
#' }
#'
trydebug <- function (need, code, error, model, ..., runmode = FALSE, showtokennum = TRUE, chat_function = NULL){
    namelist=c("namelist","num_args","str_asdfa","datatemp","alldatainfo","dataname","datatype","datanameandtype","datainfo",
             "thisdatainfo","alldatainfo","prompttemp","prompt","model","runmode","debugmode","showtokennum","chat_function","code","res")
    num_args <- length(list(...))
    str_asdfa <- deparse(substitute(list(...)))
    str_asdfa <- strsplit(str_asdfa, "\\(|,\\s*|\\)")
    str_asdfa <- unlist(str_asdfa)[-1]
    datatemp <- 'Existing variable:[[[dataname]]]
It\'s structure:[[[datatype]]]'

    alldatainfo <- ""
    if (num_args>=1)
    {


    for (i in 1:num_args) {

      dataname <- str_asdfa[i]
    if (dataname %in% namelist | dataname %in% ls("package:base"))
    {
      stop("Don't use this varible name which has been used in the function: ",dataname)
    }
    datatype <- class(list(...)[[i]])[1]
    datanameandtype <- paste0(dataname,",",datatype)
    datainfo <- paste0(names(list(...)[[i]]),",", paste("", sapply(list(...)[[i]],class),"", sep = ""), collapse = ";")
    thisdatainfo <- gsub("\\[\\[\\[dataname\\]\\]\\]", datanameandtype, datatemp)
    thisdatainfo <- gsub("\\[\\[\\[datatype\\]\\]\\]", datainfo, thisdatainfo)

    alldatainfo <- paste0(alldatainfo,thisdatainfo,"\n")
    }
    }
  prompttemp <- give_prompttemp(temptype = "debuging")
  if (!grepl("\\[\\[\\[alldatainfo\\]\\]\\]", prompttemp))
  {
    message("Warning: \"[[[alldatainfo]]]\" is not in the prompt template!")
  }
  if (!grepl("\\[\\[\\[request\\]\\]\\]", prompttemp))
  {
    message("Warning: \"[[[request]]]\" is not in the prompt template!")
  }
  if (!grepl("\\[\\[\\[oldcode\\]\\]\\]", prompttemp))
  {
    message("Warning: \"[[[oldcode]]]\" is not in the prompt template!")
  }
  if (!grepl("\\[\\[\\[error\\]\\]\\]", prompttemp))
  {
    message("Warning: \"[[[error]]]\" is not in the prompt template!")
  }
  prompt <- gsub("\\[\\[\\[alldatainfo\\]\\]\\]", alldatainfo,prompttemp)
  prompt <- gsub("\\[\\[\\[request\\]\\]\\]", need,prompt)
  prompt <- gsub("\\[\\[\\[oldcode\\]\\]\\]", code,prompt)
  prompt <- gsub("\\[\\[\\[error\\]\\]\\]", error,prompt)

  res <- start_chat(message = prompt, model = model, showtokennum = showtokennum, chat_function = chat_function)
  if (res$status_code == 200)
  {
    cat("\n------------ response:\n")
    print(res$answer[[1]])
    cat("\n\n------------ code:\n")
    code <- extract_code(json_string = res$answer)
    cat(gsub(";", "\n", code))
    if(runmode){


      cat("\n\n------------ result:\n")

      tryCatch(
        {
          eval(parse(text = code))
        },
        error = function(e) {
          message("An error occurred while executing the code: ", conditionMessage(e))
          if (class(e)[1]=="packageNotFoundError")
          {
            message("Please download the package and try running the above code manually...")
          }
          else{
            message("No further processing, please rerun or debug by yourself...")
          }
        }
      )
    }
  }
}
