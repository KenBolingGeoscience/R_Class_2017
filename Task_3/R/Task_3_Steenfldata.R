#1) 1)	Explore vectorization. Explain the differences and the similarities between the following code snippets. What data structure are a, b, and c?

#The objects a, b, and c are vectors.  In the first code snippet; line 1 loads the integer 1 into vector a.  Line 2 loads the integer 2 into vector b.  Line 3 loads the sum of vectors a and b into vector c.
#The objects d, e, and f are also vectors.  In the second code snippet; line 1 sets the seed for the random number generator.  Line 2 uses the function rnorm(20) to generate 20 random numbers and loads them into the vector d.  Line 3 does the same as line 2 but loads the numbers into vector e.  Line 4 loads the sum of the vectors d and e into vector f.

#2)	Name three ways you could use attributes to make data analysis code more reproducible (i.e., easier for yourself and others to understand).
#You could use attributes to store metadata.

#3)	What happens to a factor when you modify it’s levels?
#The attributes associated with each integer stored in the factor change.

#4)	2.2.2.3: What does this code do?


f1 <- factor(letters)
levels(f1) <- rev(levels(f1))
#The order of the associated attributes reverse so that a = 1 goes to z = 1

#5)	2.3.1.1: What does `dim` return when applied to a vector, **and why**?

#The function dim(x) returns the lengths of the row.names attribute of x.  This function gets or sets the dimension of a matrix, array or data frame.

#6)	* 2.4.5.1: What attributes does a data frame possess?
#Equal length vectors

#7)	* 2.4.5.2: What does `as.matrix()` do when applied to a data frame with columns of different types?
#Organizes data into simplest format


#8)	* 2.4.5.3: Can you have a data frame with 0 rows? What about 0 columns?

#Yes and yes.

#9)	Use read.csv() to read the file 2016_10_11_plate_reader.csv in the github data directory, and store it in memory as an object. This is an output from an instrument that I have, that measures fluorescence in each well of a 96-well plate. (Hint: use the optional argument skip = 33. What effect does that have?)

library(tidyverse)
Steenfldata <- read.csv(file ="2016_10_11_plate_reader.csv",skip=33) #This process loaded the data from the .csv file into a data frame with three columns containing a factor, a number, and an integer.

str(Steenfldata)

#10)	What kind of object did you create? What data type is each column of that object? (str())
#The read_csv() function loads the data from the .csv file into a data.frame (which is also a tbl and a tbl_df) which contains a character, a number, and an integer.




#11)  Read the same file using the read_csv function. How is the resulting object different?
#The read_csv() function loads the data from the .csv file into a data.frame (which is also a tbl and a tbl_df) which contains a character, a number, and an integer.

#SUBSETTING

#1)	Why does nrow(mtcars) give a different result than length(mtcars)? What does ncol(mtcars) return? What is each telling you, and why?

#-nrow(mtcars) returns the number of rows in the data.frame mtcars.  
#-length(mtcars) returns the number of elements in the data.frame mtcars.
#-ncol(mtcars) returns the number of columns in the data.frame mtcars.

#The nrow() function returns the number of rows in a matrix, the ncol() function returns the number of columns in a matrix.  The length () function also returns the number of columns for a matrix, but can be used to return the number of elements in a matrix, vector, array or data.frame.

#Create a vector that is the cyl column of mtcars in two different ways:
#a.	using the $ operator
cyvec <- mtcars$cyl

#b.	using [] subsetting]
cyvecsubsetting <- mtcars[ ,2]

#The $ operator loads all the numbers from a specific column as identified as the name of the column, while the [] subsetting loads specific values identified by the [row, column] coordinates.  Leaving a blank space in the row coordinate causes it to load all values from the specified column.


fourcyl <- mtcars[mtcars$cyl == 4]
mtcars[1,4]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl == 4 | cyl == 6, ] 





