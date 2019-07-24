#install.packages("dplyr")
#install.packages("nycflights13") #installs the package containing the required data
#install.packages("babynames")

library(babynames)#initializes the package from the library
library(nycflights13) 
library(dplyr)
library(tidyverse)
library(ggplot2)

dim(flights)

head(flights)

head(nycflights13::weather)

wind.direction <- nycflights13::weather #loads the weather data 

#1) Determine whether there are any clear outliers in wind speed (wind_speed) that should be rejected. If so, filter those bad point(s) and proceed.

ggplot(wind.direction, aes(x=wind_speed, y=wind_dir))+
  geom_point()

#determines that yes, there are data points which are outliers. These will be filtered in the next step  

#2) What direction has the highest median speed at each airport? Make a table and a plot of median wind speed by direction, for each airport. Optional fun challenge: If you like, this is a rare opportunity to make use of coord_polar().


wind_direction %>% #begins the pipe loading the vector
  filter(wind_speed<253 | wind_speed<0 ) %>% #selects only the rows in which the wind speed is less than 253mph which is the highest recorded non-tornado windspeed on earth and greater than zero (negative numbers should not be possible)
  group_by(origin,wind_dir) %>% #groups the windspeed by origin and direction
  summarize(median_speed = median(wind_speed)) %>% #calculates the median wind speed for each direction
  print() %>% #prints a table showing the median speed of each direction and origin
  ggplot(aes(x=wind_dir, y=median_speed))+facet_wrap(~origin)+geom_bar(stat="identity") #plots the data in three faceted bar graphs separated by origin


#This returns a data table and a plot showing the median windspeed of each direction as sorted by location (origin)


#3)Make a table with two columns: airline name (not carrier code) and median distance flown from JFK airport. The table should be arranged in order of decreasing mean flight distance. Hint: use a _join function to join flights and airlines.

 

JFK_distance <- nycflights13::flights %>% #loads the data from the nycflights dataset into the vector 
  inner_join(nycflights13::airlines, by="carrier") %>% #join the data frames by the "carrier" column which is present in both tables.  excludes rows that does not occur in both tables
  filter(origin == "JFK") %>% #selects only the planes that departed from JFK
  group_by(name) %>% #groups the name and distance 
  summarize(median_distance = median(distance)) %>% #calculates the median distance for each airline
  arrange(desc(median_distance)) %>% #arrange in order of decreasing mean flight distance
  select(name, median_distance) %>% #selcts these two columns
  print() #prints the resulting data table

#4)Make a wide-format data frame that displays the number of flights that leave Newark ("EWR") airport each month, from each airline

flight_months<- nycflights13::flights %>% #loads the data from the nycflights dataset into the vector  
  inner_join(nycflights13::airlines, by="carrier") %>% #join the data frames by the "carrier" column which is present in both tables.  excludes rows that does not occur in both tables
  filter(origin == "EWR") %>% #filter for planes that left EWR
  group_by(name,month) %>% #Split into groups based on the month and the name of the airline
  summarize(monthly_flights=n()) %>% #calculate the number of occurances of each value broken down into the two groups 
  spread(key=month, monthly_flights) %>% #creates columns based on the colmun headings
  print() #prints the resulting data table

#babynames
#5)Identify the ten most common male and female names in 2014. Make a plot of their frequency (prop) since 1880. (This may require two separate piped statements).

head(babynames)

topnames_2014 <- babynames %>%
  filter(year==2014)%>% #selects baby names from the year 2014
  group_by(sex)%>% #group by sex
  top_n(10,n) %>%#selects the top 10 values in the count column "n"
  select(name,sex) %>% #selcets the columns to output
  print() #prints the resulting data table

top10namehistory <- babynames %>% #loads the original babynames dataset into the vector
  inner_join(topnames_2014,by = c("sex", "name")) %>% #joins the two data tables by both the sex and the name 
  print() #prints the resulting data table

namesplot<-ggplot(top10namehistory, aes(x=year, y=prop))+facet_wrap(~name)+geom_point() #for some reason this line can't be part of the pipe.  It seems to have something to do with loading the data table into the vector on the first line. Weird.

print(namesplot) #prints the plots of the different names since 1880

#6)Make a single table of the 26th through 29th most common girls names in the year 1896, 1942, and 2016

girlsnames <- babynames %>% #loads the original babynames dataset into the vector
  filter(sex=="F", year==1896|year==1942|year==2014) %>% #filters for female names for the desired years
  group_by(year) %>% #groups the names by year
  mutate(name_rank = dense_rank(desc(n))) %>% #ranks the names for each year
  filter((name_rank > 25) & (name_rank < 30)) %>% #filters out the names which occur in the desired ranking range
  print() #prints the resulting data table


#7)Write task that involves some of the functions on the Data Wrangling Cheat Sheet and execute it. You may either use your own data or data packages (e.g., the ones listed here).

#going back lets see if wind speed changes with temperature over the year.
#We will need to average the temperature for each day to reduce the effects of day/night cycles, then average the windspeed for each day.
#we will then need to compare the average daily wind speed to the average daily temperature for each airport.
#we can then plot both wind speed and temperature on the y axis and each day on the x axis.

Windspeed_temp <- nycflights13::weather %>% #loads the dataset into the vector
  filter(wind_speed<253 | wind_speed<0 ) %>% #selects only the rows in which the wind speed is less than 253mph which is the highest recorded non-tornado windspeed on earth and greater than zero (negative numbers should not be possible)
  group_by(origin, month, day) %>%
  summarise_each(funs(mean)) %>% #summarizes each column based on the grouping, variables used for grouping are unaffected
  select(origin,wind_speed,temp, month, day) %>%
  print()

tempplot <- ggplot(Windspeed_temp, aes(x=day, y=temp))+geom_point()+facet_wrap(origin ~ month)
print(tempplot)
