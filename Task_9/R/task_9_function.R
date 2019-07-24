
#' Task_9_function
#'
#' This function allows you to add two columns in a data frame.
#' @param x a dataframe that has two columns, if it doesn't don't worry you'll know.
#' @param name the name of the third column, it can be whatever you want it to be.
#' @keywords adding
#' @export
#' @examples
#' 
#' gooddataframe <- data.frame(
#' a=c(1,2,3,4,5,6,7),
#' b=c(1,2,3,4,5,6,7)
#' )
#' 
#' Task_9_function(gooddataframe)


#Next we make the function that will add the columns "a" and "b" from the dataframe and return the same dataframe with a new column containing the results of that operation
#This function also checks if the dataframe has non numeric values and if it's actually a dataframe
Task_9_function <- function(x, name) {
  
  if(is.data.frame(x)!= TRUE)
    stop("Bro do you know what a dataframe is?")
  
  if(is.numeric(x[ ,1])!= TRUE)
    warning("column 1 contains non-numeric values")
  
  if(is.numeric(x[ ,2])!= TRUE)
    warning("column 2 contains non-numeric values")
  
  x[[name]] <- x[ ,1] + x[ ,2] 
  
  return(x)
}