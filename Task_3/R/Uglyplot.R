library(ggplot2) # initiallizes the ggplot package
EFXRF <- read.csv(file = "C:/Users/Ken/Documents/R class 2017/data/Eagle_Ford_Bad_XRF_data.csv") #loads the data from a .csv file
ggplot(data=EFXRF, aes(x=CaO, y=Sc))+ #begins the ggplot function and defines the x and y variables from the EFXRF data frame.
  geom_point() + #creates a scatter plot
  ggtitle("XRF data from mixed siliciclasitc and \n carbonate mudstones")+ #adds a title with a text break
  xlab("CaO (wt. %)")+ #labels the x axis
  ylab("Sc (ppm)")+ #labels the y axis
  geom_smooth(method = lm, se=FALSE, aes(x=CaO, y=Sc)) # adds a trendline with no error bars

