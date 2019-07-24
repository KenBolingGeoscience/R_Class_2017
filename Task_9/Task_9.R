



#1) a good dataframe
gooddataframe <- data.frame(
  a=c(1,2,3,4,5,6,7),
  b=c(1,2,3,4,5,6,7)
)

#2) a data frame with non-numeric values
baddataframe <- data.frame(
  a=c(3,11,37,"the number 12",66,10,1),
  b=c(1,2,4,80,44,"A small off duty czechoslovakian traffic warden",11)
)

#3) something that isn't a dataframe
whatdataframe <- "lol this isn't a dataframe"


#Next we make the function that will add the columns "a" and "b" from the dataframe and return the same dataframe with a new column containing the results of that operation
#This function also checks if the dataframe has non numeric values and if it's actually a dataframe
adding_function <- function(x, name) {
  
  if(is.data.frame(x)!= TRUE)
    stop("Bro do you know what a dataframe is?")
  
  if(is.numeric(x[ ,1])!= TRUE)
    warning("column 1 contains non-numeric values")
  
  if(is.numeric(x[ ,2])!= TRUE)
    warning("column 2 contains non-numeric values")
  
  x[[name]] <- x[ ,1] + x[ ,2] 
  
  return(x)
}

#now we can test this function to see if it works

adding_function(gooddataframe, name="a + b added")



adding_function(baddataframe, name="a + b added")

#Error in x$a + x$b : non-numeric argument to binary operator
#In addition: Warning messages:
#  1: In adding_function(baddataframe, name = "a + b added") :
#  column 1 contains non-numeric values
#2: In adding_function(baddataframe, name = "a + b added") :
#  column 2 contains non-numeric values


#adding_function(whatdataframe, name="a + b added")

#Error in adding_function(whatdataframe, name = "a + b added") : 
#Bro do you know what a dataframe is?

#looks good
