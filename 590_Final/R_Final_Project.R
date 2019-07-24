
#The initial idea for this project was to create a function which would simply print
#a whole bunch of x,y plots at once.  However, upon further investigation this won't be that 
#useful when you have more than 10 variables (which would print 45 individual plots at once).  
#Consequently I decided that it would be nessicary to narrow down the results a bit so things don't get
#out of hand.  I decided the best way would be to calculate the pearson coeffiecints 
#and use that to figure out the best plots to use.  



x <- mtcars





#first lets make the correlation coefficents using the cor() function

too_many_plots <- function(x, uppercutoff, lowercutoff) {
  
  n <- ncol(x)
  
  if(is.data.frame(x)!= TRUE)
    stop("Bro do you know what a dataframe is?")
  
  if(is.numeric(x[ ,1])!= TRUE)
    warning("column 1 contains non-numeric values")
  
  if(is.numeric(x[ ,2])!= TRUE)
    warning("column 2 contains non-numeric values")
  
  correlation_coefficient_initial <- cor(x, method = c("pearson"))
  
  correlation_coefficient_important <- correlation_coefficient_initial
  


  return(correlation_coefficent_important)
}



  
too_many_plots(mtcars)



print(correlation_coefficient_mtcars)


input_data <- mtcars

cutoff <- .85

correlation_coefficient_initial <- cor(input_data, method = c("pearson"))

#this selects the coefficients that are above the cutoff value provided by the user
#It also selects both positive and negative coefficients so that the user only has to input
#one number: (cutoff=0.85 selects coefficients over .85 and under -.85)
a <- which(correlation_coefficient_initial>=cutoff | 
             correlation_coefficient_initial<=cutoff*-1
           ,arr.ind=T)

a
derp <- as.data.frame(row.names(correlation_coefficient_initial[a[,1],]))

x_something <- "x_initial_data"
y_something <- "y_initial_data"

ggplot(input_data, aes(x=x_something, y=y_something)) +
  geom_point()+
  ggtitle(x_something, y_something)

