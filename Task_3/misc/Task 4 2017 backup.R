library(ggplot2)

nrow(diamonds)

set.seed(1410)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

ggplot(data=dsmall) +
  geom_point(mapping=aes(x=x, y=y, color=z))+ 
  facet_wrap(~cut, nrow=2)

ggplot(mtcars, aes(x = disp, y = mpg)) + 
  geom_point()
