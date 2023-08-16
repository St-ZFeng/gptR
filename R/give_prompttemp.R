#' Provide Prompt Templates.
#'
#' @description
#'
#' There are three types of prompt templates: "coding", "debugging" and "asking".
#' With this function, you can see the current content of the three types of prompt templates.
#'
#' @param temptype The type of the template.
#'
#' @return Prompt template text string.
#' @export
#'
#' @examples
#' give_prompttemp("coding")
#'
give_prompttemp <- function(temptype){
  if (temptype == "coding")
  {

    oldprompttemp <- 'You are the best professional expert in data analysis in R.User will give their needs.You must carefully analyze user needs to provide elegant and simple but effective R code to realize the needs by step and step thinking
# User asking format
Existing variable:variable_name,variable_type
It\'s structure:internal_variable,type;internal_variable,type
User needs:
# User asking
[[[alldatainfo]]]User needs:[[[request]]]
# Requirements
- Existing variables have already been passed to you, so you can use them directly.Existing variables cannot be directly modified or assigned
- Prohibit any package install code but load necessary packages,avoid useless packages
- Print the final data or plot at the end of the code according to the user\'s requirements
- Prohibit any code comment, give the pure code
- Separate code lines with semicolons, not line breaks
- Prohibit using any variable values in a hard-coded way,unless user provides values for the variables
- Type conversion if necessary
- Disable modification of the current working directory unless requested by the user
- If the user requests a plot, show the most elegant plot, don\'t save the plot
# Ensure code meet format and content requirements
# Your response JSON format
- {"code" : "Content of the code"}'

    prompttemp <- check_prompttemp(temptype = temptype, oldprompttemp = oldprompttemp)

  }
  else if(temptype == "debuging"){
    oldprompttemp <- 'You are the best professional expert in data analysis in R.User will provide you codes.These codes do not fulfill their needs or have some problems.You must debug these R codes to realize the needs by step and step thinking.If the code provided by user cannot be modified to fulfill the needs,completely refactor the code
# User asking format
Existing variable:variable_name,variable_type
It\'s structure:internal_variable,type;internal_variable,type
User needs:
Code:
Code problem:
# User asking
[[[alldatainfo]]]User needs:[[[request]]]
Code:[[[oldcode]]]
Code problem:[[[error]]]
# Requirements
- Prohibit using any variable that does not exist or has not been created
- Print the final data or plot at the end of the code according to the user\'s requirements
- Separate code lines with semicolons, not line breaks
- Prohibit any code notes, give the pure code
# Ensure code meet formatting and content requirements
# Your response JSON format
{"code" : "Content of the code"}'

    prompttemp <- check_prompttemp(temptype = temptype, oldprompttemp = oldprompttemp)
  }
  else if(temptype == "asking")
  {

    oldprompttemp <- 'You are the best professional expert in data analysis in R.User will give their needs.You must carefully analyze user needs to provide elegant and simple but effective R code to realize the needs by step and step thinking
# User asking format
User needs:
# User asking
User needs:[[[request]]]
# Requirements
- Prohibit any package install code but load necessary packages,avoid useless packages
- Print the final data or plot at the end of the code according to the user\'s requirements
    - Separate code lines with semicolons, not line breaks
    - Prohibit any code notes, give the pure code
    # Your response JSON format
    {"code" : "Content of the code"}'

    prompttemp <- check_prompttemp(temptype = temptype, oldprompttemp = oldprompttemp)


  }else{

    stop("No this templates type!")
  }
  return (prompttemp)

}
