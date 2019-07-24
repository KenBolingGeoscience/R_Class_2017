library(ggplot2) # initiallizes the ggplot package

well1rft <- read.csv(file = "C:/Users/Ken/Documents/R_class_2017/data/Well_1_rft_csv.csv") #loads the data from a .csv file

FMTOPS <- data.frame(FMDEPTH=c(5119.5,5242.5,5569), FMNAME=c("Ekofisk Formation", "Tor Formation","Farsund Formation")) #creates a dataframe with the formation top information 

fluidplot<- ggplot()+ #begins the ggplot function.
  geom_point(data=well1rft, aes(x=PFORM, y=DEPTH)) + #creates a scatter plot
  geom_smooth(data=well1rft, method = lm, se=FALSE, fullrange=TRUE, aes(x=PFORM, y=DEPTH, color=INTERP))+ # adds trend lines using the lm method, se=FALSE removes error bars
  geom_hline(data=FMTOPS, aes(yintercept=FMDEPTH))+
  geom_text(data=FMTOPS, aes(x=3300, y=FMDEPTH, label=FMNAME), size=4, angle=0, vjust=1, hjust=0) +
  ggtitle("Well-1 Repeat Formation Test")+ #adds a title with a text break
  xlab("Formation Pressure (PSI)")+ #labels the x axis
  ylab("Measured Depth (ft)")+ #labels the y axis
  scale_y_reverse(limits=c(5600,5100), breaks=c(5100, 5200, 5300, 5400, 5500, 5600)) #reverses the y axis scale bar
print(fluidplot)




