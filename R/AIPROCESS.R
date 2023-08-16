#' Using Chatgpt or Any Other Large Model to Achieve Your Need.
#'
#' @description
#'
#' This function is the most critical function in this R package, with which you can actually plug models such as GPT into your R language data analysis process.
#' All you need to do is write down your requirements, choose a model, and pass the necessary data variables into the function. The model then gives you everything, including variables, data frames, and even plots! The best part is that it all runs automatically and is customized to your data structure, so it is relatively efficient and fast. This somewhat avoids the dilemma of laboriously chatting with your model and then copying the resulting code into R to run it.
#' Rest assured that the content of your data is not passed on to the model, thus ensuring a degree of data privacy. The model only gets the name and class of the variable and, for data types such as data frames, also the name and class of its columns.
#'
#' \bold{Process}
#'
#' - The process is very simple. First, provide the requirements and data structure to the chat model using the prompt template. Then get the formatted code and extract the code. Finally run the string code directly.
#'
#'
#' \bold{Prerequisites}
#'
#' - You need to store your openai API key and base url as environment variables, this can be achieved by:
#'
#' \code{\bold{Sys.setenv(OPENAI_API_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX")}}
#'
#'
#' \code{\bold{Sys.setenv(OPENAI_BASE_URL = "https://XXXXXXXXXXXXXXXXXXXX/v1")}}
#'
#'
#' - In some cases these two parameters are not required, the BASE_URL defaults to the openai official API url, in which case you can leave this environment variable unset. The default API_KEY is an empty string.
#'
#'
#' \bold{Some suggestions}
#'
#' - You can try to use this function to realize some complex operations or draw complex plots, if the model can't meet your requirement, please fix the code manually or try again.
#'
#' - If the model does not meet your needs, you can change your requirement text to provide more details, which usually leads to better results.
#'
#' - For some operations, the model itself may not be capable of achieving, or it may have limited understanding, so you can change models or solve the problem yourself.
#'
#'
#' \bold{Some problems}
#'
#' - The function does not seem to change your original data as the code given by the model seems to run inside the function body. But it is not possible to be completely sure about this. However, it has been verified that the code given by the model to change the column type of the data frame does not act on the original dataframe. So if you are afraid of any problems, it is better to pass in the copied data.
#'
#' - The fact that the model sometimes does not follow the requirements in the prompt words should be a problem with the model itself, perhaps it does not understand them. Therefore the capability of this function depends a lot on the model itself, but its potential is unlimited. Therefore, at this stage, it is best not to have too high expectations for this function.
#'
#' - The model's capabilities may not be able to fulfill some requirements, especially if the methods used are not in the database it is learned from (e.g. some of the latest R packages). This issue may be addressed in the future by giving models external documentation.
#'
#'
#' \bold{Can I change the prompt template?}
#'
#' - Absolutely. Prompts are an important part of the functionality and a key element for better results, so you can customize your prompts for better results or just save on token usage. But some essential parts are indispensable. These are usually a model output form that is consistent with the original template, [[[replacement strings]]], and some core requirements, such as having the model return the result variable at the end of the code.
#'
#' - When you run the function for the first time, the built-in default prompt template is stored as a .md file in the package root folder so you can modify it. Use system.file(package = "gptR") to find it. Subsequent runs utilize this .md prompt template.
#'
#'
#' \bold{How to save on token usage}
#'
#' - Anyone using this package is responsible for keeping an eye on their token usage to avoid excessive consumption (except for free models).
#'
#' - The default maximum prompt template consumes about 400 tokens, and the final number of tokens needs to plus the tokens for your data structure and requirement text, so you can further streamline the prompt templates to save tokens, but there are obvious trade-offs, as few prompts may not yield effective results, or may even increase the final cost (e.g. asking the model not to give any code comments).
#'
#' - Another approach is to filter out the necessary columns for larger data frames and pass them in.
#'
#' - If your model is free to charge, then everything is not a problem. Therefore, the parameter of the custom API interface function is provided, which can satisfy any formation other than the openai interface formation. You can provide your own model's API interface function.
#'
#'
#' \bold{How to customize the API interface function}
#'
#' - See the function \link{mychat} for an example of a custom API interface function.
#'
#' - The input parameters and output form of the function must be consistent with the example function, even if you don't actually use them at all. The input parameters include the text to be passed directly to the model, the type of model to select, and whether to display token usage. The function needs to return a list of model response text (answer =) and web access status codes (status_code =). If you don't use the status code, set it to a constant value of 200 and return it.
#'
#' - Other necessary parameters should be added by reading and writing environment variables.
#'
#'
#' There's not much more to say, you can refer to the example and try to use it. Don't expect too much from it, and if you are an R program expert, you obviously don't need this.
#'
#' @param need Your need, which should be a string.
#' @param model The name string of the model you want to use.
#' @param ... Any data you provide to the model, which can be more than one. But in fact the model doesn't read the data details, just gets it's names and types.
#' @param runmode Whether to have the function automatically execute the code provided by the model, defaults to TURE.
#' @param debugmode If the execution of the code provided by the model fails, whether to try to fix it once, defaults to FALSE.
#' @param showtokennum Whether to show the token's usage, defaults to TRUE.
#' @param chat_function A custom model chat API interface function that takes three parameters, message, model, and tokennum, and returns a list consisting of answer and status_code. Defaults to NULL, at which point the built-in openai style interface function is called. For custom function styles, see the function mychat().
#'
#' @return Anything or nothing.
#' @export
#'
#' @examples
#' \donttest{
#' # Passing 0 variable
#' # In this case the code is not executed automatically, so the runmode and debugmode parameters are invalid.
#' AIPROCESS("How to draw a bar graph", "gpt-4")
#'
#'
#' # Passing a single numeric
#' number <- 1
#' number2 <- AIPROCESS("Add 1 to number", "gpt-4", number)
#'
#' # Passing a data frame
#' x <- 1:100
#' y <- 1:100
#' df1 <- data.frame(x = x, y = y)
#' AIPROCESS("Draw a scatter plot of x and y", "gpt-4", df1)
#'
#' # Passing two data frames
#' # Remember that the parameters after ... must be followed by a parameter name in order to work, e.g. showtokennum = FALSE, otherwise it will be recognized as data passed into the function.
#' df2 <- data.frame(z = x, w = y)
#' df3 <- AIPROCESS("Merge two data frames horizontally", "gpt-4", df1, df2, showtokennum = FALSE)
#'
#' # Using custom model interface functions
#' number3 <- AIPROCESS("Sum all numbers in the data frame", "gpt-4", df3, showtokennum = FALSE, chat_function = mychat)
#'
#' }
#'
AIPROCESS <- function (need, model, ..., runmode=TRUE, debugmode=FALSE, showtokennum=TRUE, chat_function=NULL){
  namelist=c("namelist","num_args","str_asdfa","datatemp","alldatainfo","dataname","datatype","datanameandtype","datainfo","packagen","i",
            "thisdatainfo","alldatainfo","prompttemp","prompt","model","runmode","debugmode","showtokennum","chat_function","code","res","final_res32","package956","package741")
  num_args <- length(list(...))
  if (num_args!=0)
  {

    str_asdfa <- deparse(substitute(list(...)))
    str_asdfa <- strsplit(str_asdfa, "\\(|,\\s*|\\)")
    str_asdfa <- unlist(str_asdfa)[-1]
    datatemp <- 'Existing variable:[[[dataname]]]
It\'s structure:[[[datatype]]]'

    alldatainfo <- ""
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

    prompttemp <- give_prompttemp(temptype = "coding")
    if (!grepl("\\[\\[\\[alldatainfo\\]\\]\\]", prompttemp))
    {
      message("Warning: \"[[[alldatainfo]]]\" is not in the prompt template!")
    }
    if (!grepl("\\[\\[\\[request\\]\\]\\]", prompttemp))
    {
      message("Warning: \"[[[request]]]\" is not in the prompt template!")
    }

    prompt <- gsub("\\[\\[\\[alldatainfo\\]\\]\\]", alldatainfo,prompttemp)
    prompt <- gsub("\\[\\[\\[request\\]\\]\\]", need,prompt)

    res <- start_chat(message = prompt, model = model, showtokennum = showtokennum, chat_function = chat_function)
    if (res$status_code==200)
    {
      cat("\n------------ response:\n")
      print(res$answer[[1]])
      cat("\n\n------------ code:\n")
      code <- extract_code(json_string = res$answer)
      cat(gsub(";( )*", "\n", code))
      if(runmode){

        cat("\n\n------------ result:\n")

        tryCatch(
          {
            package956=(.packages())
            final_res32=eval(parse(text = code))
            package741=(.packages())[!((.packages()) %in% package956)]


            for (packagen in package741)
            {
                detach(paste0("package:",packagen),force=TRUE, character.only = TRUE)
            }
            return(final_res32)

          },
          error = function(e) {
            message("An error occurred while executing the code:", conditionMessage(e))
            if (class(e)[1]=="packageNotFoundError")
            {
              message("Please download the package and try running the above code manually...")
            }
            else{

              if (debugmode)
              {
                cat("\n\nAttempting to fix...")
                trydebug(need = need, code = code, error = conditionMessage(e), model = model, ..., runmode = runmode, showtokennum = showtokennum, chat_function = chat_function)
              }else{
                message("No further processing, please rerun or debug by yourself...")

              }
            }
          }
        )
      }
    }
  }
  else
  {
    prompttemp <- give_prompttemp(temptype = "asking")
    if (!grepl("\\[\\[\\[request\\]\\]\\]", prompttemp))
    {
      message("Warning: \"[[[request]]]\" is not in the prompt template!")
    }
    prompt <- gsub("\\[\\[\\[request\\]\\]\\]", need,prompttemp)

    res <- start_chat(message = prompt, model = model, showtokennum = showtokennum, chat_function = chat_function)
    if (res$status_code==200)
    {
      cat("\n------------ response:\n")
      print(res$answer[[1]])
      cat("\n\n------------ code:\n")
      code <- extract_code(json_string = res$answer)
      code <- gsub("\\\\n", "\n", code)
      cat(gsub(";", "\n", code))
    }
  }

}

