Task\_6\_Well-1\_rft
================
Ken
February 17, 2017

Repeat formation test for Well-1
--------------------------------

The Repeat formation test records information about the formation pressure at specific points along the wellbore. using this information it is possible to identify the oil-water contact and oil-gas contact by the changes observed in the pressure gradient.

The code below creates a plot of the rft pressure data. The points of intersection between the gas, water, and oil lines indicate the contacts of each within the Tor Formation. An impermeable layer occurs in the lower Ekofisk Formation, and an overpressured gas pocket occurs in the upper part of the Ekofisk.

``` r
library(ggplot2) # initiallizes the ggplot package

well1rft <- read.csv(file = "C:/Users/Ken/Documents/R Programing/R_class_2017/data/Well_1_rft_csv.csv") #loads the data from a .csv file

FMTOPS <- data.frame(FMDEPTH=c(5119.5,5242.5,5569), FMNAME=c("Ekofisk Formation", "Tor Formation","Farsund Formation")) #creates a dataframe with the formation top information 

fluidplot<- ggplot()+ #begins the ggplot function.
  geom_point(data=well1rft, aes(x=PFORM, y=DEPTH)) + #creates a scatter plot
  geom_smooth(data=well1rft, method = lm, se=FALSE, fullrange=TRUE, aes(x=PFORM,  y=DEPTH, color=INTERP))+ # adds trend lines using the lm method, se=FALSE removes error bars, fullrange=true extends the bars to the maximum extent
  geom_hline(data=FMTOPS, aes(yintercept=FMDEPTH))+ #adds formation top lines
  geom_text(data=FMTOPS, aes(x=3300, y=FMDEPTH, label=FMNAME), size=4, angle=0, vjust=1, hjust=0) + #labels the formation tops
  ggtitle("Well-1 Repeat Formation Test")+ #adds a title with a text break
  xlab("Formation Pressure (PSI)")+ #labels the x axis
  ylab("Measured Depth (ft)")+ #labels the y axis
  scale_y_reverse(limits=c(5600,5100), breaks=c(5100, 5200, 5300, 5400, 5500, 5600)) #reverses the y axis scale bar, sets the limits of the scales, sets the locations of tick marks on the scale bar
print(fluidplot) #prints the plot
```

    ## Warning: Removed 3 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3 rows containing missing values (geom_point).

    ## Warning: Removed 28 rows containing missing values (geom_smooth).

![](Well-1_rft_markdown_files/figure-markdown_github/well-1_rft-1.png)

``` r
ggsave("Well-1_rft_plot.png", plot = fluidplot)
```

    ## Saving 7 x 5 in image

    ## Warning: Removed 3 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3 rows containing missing values (geom_point).

    ## Warning: Removed 28 rows containing missing values (geom_smooth).
