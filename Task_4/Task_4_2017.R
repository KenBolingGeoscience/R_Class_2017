library(ggplot2) 
#initializes the ggplot2 package

nrow(diamonds) 
#returns the number of rows in the diamonds dataframe

set.seed(1410) 
# sets the seed for the random number generator

dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
# loads a subset of 100 random rows from the diamonds dataframe into the vector "dsmall"  

ggplot(data=dsmall) +                         #tells the ggplot package to use the data from the vector "dsmall"
  geom_point(mapping=aes(x=x, y=y, color=z))+ #tells ggplot to make a scatter plot and designates the x and y values, also sets the z value to represent the color of the points
  facet_wrap(~cut, nrow=2)                    #splits the graph into a series of graphs based on the "cut" variable

ggplot(data=dsmall) +                                                  #tells the ggplot package to use the data from the vector "dsmall"
  geom_point(aes(x=carat, y=price, color=cut))+                        #tells ggplot to make a scatter plot and designates the x and y values, also sets the color to varry with the "cut" variable
  geom_smooth(method = lm, se=FALSE, aes(x=carat, y=price, color=cut)) # adds trend lines using the lm method, se=FALSE removes error bars

ggplot(data=dsmall) +                                                  #tells the ggplot package to use the data from the vector "dsmall"
  geom_density(aes(x=carat, color=clarity))+                           #tells ggplot to make a scatter plot and designates the x and y values, also sets the color to varry with the "cut" variable
  facet_wrap(~clarity, nrow=2)                                         #splits the graph into a series of graphs based on the "clarity" variable and arranges them in two rows


ggplot(data=dsmall) +               #tells the ggplot package to use the data from the vector "dsmall"
  geom_boxplot(aes(x=cut, y=price)) #tells ggplot to make a box plot and designates the x and y values

ggplot(data=dsmall) +                                                             #tells the ggplot package to use the data from the vector "dsmall"
  geom_point(colour = "red", aes(x=x, y=y))+                                      #tells ggplot to make a scatter plot and designates the x and y values, also sets the color of all the points to red
  geom_smooth(method = lm, se=FALSE, linetype=2, color="blue",  aes(x=x, y=y))+   # adds trend lines using the lm method, se=FALSE removes error bars, linetype=2 changes the line to be a dashed line
  xlab("x in mm")+                                                                #designates the x axis label
  ylab("y in mm")                                                                 #designates the y axis label
  
  
  




