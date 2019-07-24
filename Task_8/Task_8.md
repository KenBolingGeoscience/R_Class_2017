Task\_8
================
Ken
May 4, 2017

Task 8
------

``` r
#First lets make some objects to use for testing the function later:

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


#Next we make the function that will add the columns "a" and "b" from the dataframe and return the same dataframe with a new column containing the results of that operation and just for fun lets make it so the new column name can be specified by the user.

#This function also checks if the dataframe has non numeric values in column 1 or 2 and if it's actually a dataframe

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
```

    ##   a b a + b added
    ## 1 1 1           2
    ## 2 2 2           4
    ## 3 3 3           6
    ## 4 4 4           8
    ## 5 5 5          10
    ## 6 6 6          12
    ## 7 7 7          14

``` r
adding_function(baddataframe, name="a + b added")
```

    ## Warning in adding_function(baddataframe, name = "a + b added"): column 1
    ## contains non-numeric values

    ## Warning in adding_function(baddataframe, name = "a + b added"): column 2
    ## contains non-numeric values

    ## Warning in Ops.factor(x[, 1], x[, 2]): '+' not meaningful for factors

    ##               a                                               b
    ## 1             3                                               1
    ## 2            11                                               2
    ## 3            37                                               4
    ## 4 the number 12                                              80
    ## 5            66                                              44
    ## 6            10 A small off duty czechoslovakian traffic warden
    ## 7             1                                              11
    ##   a + b added
    ## 1          NA
    ## 2          NA
    ## 3          NA
    ## 4          NA
    ## 5          NA
    ## 6          NA
    ## 7          NA

``` r
#Warning messages:
#  1: In adding_function(baddataframe, name = "a + b added") :
#  column 1 contains non-numeric values
#2: In adding_function(baddataframe, name = "a + b added") :
#  column 2 contains non-numeric values
#3: In Ops.factor(x[, 1], x[, 2]) : ‘+’ not meaningful for factors


#adding_function(whatdataframe, name="a + b added")

#This time the function returns the following:

#Error in adding_function(whatdataframe, name = "a + b added") : 
#Bro do you know what a dataframe is?

#looks good


#Next we can make a function that adds up all the numbers between 1 and 10,000 using a for loop
#This is done by determining the length of the vector and storing that as "n"
#The for loop repeats from 1 to n and each cycle adds the next number in that column to the next number
#the output needs to start at zero and not a null value 

additionloop <- function(x){
  
  n <- (length(x))
  
  output <- 0
  
  for (i in 1:n) {
    
    output <- output + x[i]
  }
  
  return(output)
  
}

#so now this function should return the same output as the sum() function:

additionloop(1:10^4)
```

    ## [1] 50005000

``` r
sum(1:10^4)
```

    ## [1] 50005000

``` r
#Now to test how fast each of these are, we need to install the microbenchmark pakage first:  

#install.packages("microbenchmark")
library(microbenchmark)
```

    ## Warning: package 'microbenchmark' was built under R version 3.3.3

``` r
#and now to test the two functions:

test.vec <- 1:10^4
microbenchmark(
  additionloop(test.vec),
  sum(test.vec)
)
```

    ## Unit: microseconds
    ##                    expr       min        lq        mean     median
    ##  additionloop(test.vec) 10818.315 11129.309 11653.38996 11307.0870
    ##           sum(test.vec)    18.665    19.132    26.06057    27.5305
    ##        uq       max neval
    ##  11954.97 14293.614   100
    ##     31.73    48.994   100

``` r
#The sum() function is about 1000 times faster than doing this with a For Loop. 
#This is because sum() is a primative function which are coded in C.  
#Code execution in C is faster than R. 
```
