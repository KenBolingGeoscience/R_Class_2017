Task\_7
================
Ken
May 4, 2017

Task 7
------

``` r
#install.packages("dplyr")
#install.packages("nycflights13") #installs the package containing the required data
#install.packages("babynames")

library(babynames)#initializes the package from the library
```

    ## Warning: package 'babynames' was built under R version 3.3.3

``` r
library(nycflights13) 
```

    ## Warning: package 'nycflights13' was built under R version 3.3.3

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.3.3

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(ggplot2)

dim(flights)
```

    ## [1] 336776     19

``` r
head(flights)
```

    ## # A tibble: 6 × 19
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## 4  2013     1     1      544            545        -1     1004
    ## 5  2013     1     1      554            600        -6      812
    ## 6  2013     1     1      554            558        -4      740
    ## # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
    ## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
    ## #   time_hour <dttm>

``` r
head(nycflights13::weather)
```

    ## # A tibble: 6 × 15
    ##   origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
    ##    <chr> <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
    ## 1    EWR  2013     1     1     0 37.04 21.92 53.97      230   10.35702
    ## 2    EWR  2013     1     1     1 37.04 21.92 53.97      230   13.80936
    ## 3    EWR  2013     1     1     2 37.94 21.92 52.09      230   12.65858
    ## 4    EWR  2013     1     1     3 37.94 23.00 54.51      230   13.80936
    ## 5    EWR  2013     1     1     4 37.94 24.08 57.04      240   14.96014
    ## 6    EWR  2013     1     1     6 39.02 26.06 59.37      270   10.35702
    ## # ... with 5 more variables: wind_gust <dbl>, precip <dbl>,
    ## #   pressure <dbl>, visib <dbl>, time_hour <dttm>

``` r
wind_direction <- nycflights13::weather #loads the weather data 

#1) Determine whether there are any clear outliers in wind speed (wind_speed) that should be rejected. If so, filter those bad point(s) and proceed.

ggplot(wind_direction, aes(x=wind_speed, y=wind_dir))+
  geom_point()
```

    ## Warning: Removed 418 rows containing missing values (geom_point).

![](Task_7_files/figure-markdown_github/Task_7-1.png)

``` r
#determines that yes, there are data points which are outliers. These will be filtered in the next step  

#2) What direction has the highest median speed at each airport? Make a table and a plot of median wind speed by direction, for each airport. Optional fun challenge: If you like, this is a rare opportunity to make use of coord_polar().


wind_direction %>% #begins the pipe loading the vector
  filter(wind_speed<253 | wind_speed<0 ) %>% #selects only the rows in which the wind speed is less than 253mph which is the highest recorded non-tornado windspeed on earth and greater than zero (negative numbers should not be possible)
  group_by(origin,wind_dir) %>% #groups the windspeed by origin and direction
  summarize(median_speed = median(wind_speed)) %>% #calculates the median wind speed for each direction
  print() %>% #prints a table showing the median speed of each direction and origin
  ggplot(aes(x=wind_dir, y=median_speed))+facet_wrap(~origin)+geom_bar(stat="identity") #plots the data in three faceted bar graphs separated by origin
```

    ## Source: local data frame [114 x 3]
    ## Groups: origin [?]
    ## 
    ##    origin wind_dir median_speed
    ##     <chr>    <dbl>        <dbl>
    ## 1     EWR        0      0.00000
    ## 2     EWR       10      9.20624
    ## 3     EWR       20      9.20624
    ## 4     EWR       30      9.20624
    ## 5     EWR       40     10.35702
    ## 6     EWR       50      8.05546
    ## 7     EWR       60      8.05546
    ## 8     EWR       70      6.90468
    ## 9     EWR       80      6.90468
    ## 10    EWR       90      6.32929
    ## # ... with 104 more rows

    ## Warning: Removed 3 rows containing missing values (position_stack).

![](Task_7_files/figure-markdown_github/Task_7-2.png)

``` r
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
```

    ## # A tibble: 10 × 2
    ##                        name median_distance
    ##                       <chr>           <dbl>
    ## 1    Hawaiian Airlines Inc.            4983
    ## 2     United Air Lines Inc.            2586
    ## 3            Virgin America            2475
    ## 4      Delta Air Lines Inc.            1990
    ## 5    American Airlines Inc.            1598
    ## 6           JetBlue Airways            1028
    ## 7           US Airways Inc.             541
    ## 8         Endeavor Air Inc.             427
    ## 9                 Envoy Air             425
    ## 10 ExpressJet Airlines Inc.             228

``` r
#4)Make a wide-format data frame that displays the number of flights that leave Newark ("EWR") airport each month, from each airline

flight_months<- nycflights13::flights %>% #loads the data from the nycflights dataset into the vector  
  inner_join(nycflights13::airlines, by="carrier") %>% #join the data frames by the "carrier" column which is present in both tables.  excludes rows that does not occur in both tables
  filter(origin == "EWR") %>% #filter for planes that left EWR
  group_by(name,month) %>% #Split into groups based on the month and the name of the airline
  summarize(monthly_flights=n()) %>% #calculate the number of occurances of each value broken down into the two groups 
  spread(key=month, monthly_flights) %>% #creates columns based on the colmun headings
  print() #prints the resulting data table
```

    ## Source: local data frame [12 x 13]
    ## Groups: name [12]
    ## 
    ##                        name   `1`   `2`   `3`   `4`   `5`   `6`   `7`
    ## *                     <chr> <int> <int> <int> <int> <int> <int> <int>
    ## 1      Alaska Airlines Inc.    62    56    62    60    62    60    62
    ## 2    American Airlines Inc.   298   268   295   288   297   291   303
    ## 3      Delta Air Lines Inc.   279   249   319   364   377   347   340
    ## 4         Endeavor Air Inc.    82    75    91    88   103    88    94
    ## 5                 Envoy Air   212   196   228   220   226   218   228
    ## 6  ExpressJet Airlines Inc.  3838  3480  3996  3870  4039  3661  3747
    ## 7           JetBlue Airways   573   532   612   567   517   506   546
    ## 8     SkyWest Airlines Inc.    NA    NA    NA    NA    NA     2    NA
    ## 9    Southwest Airlines Co.   529   490   532   518   530   501   526
    ## 10    United Air Lines Inc.  3657  3433  3913  4025  3874  3931  4046
    ## 11          US Airways Inc.   363   328   372   361   381   390   402
    ## 12           Virgin America    NA    NA    NA   170   186   180   181
    ## # ... with 5 more variables: `8` <int>, `9` <int>, `10` <int>, `11` <int>,
    ## #   `12` <int>

``` r
#babynames
#5)Identify the ten most common male and female names in 2014. Make a plot of their frequency (prop) since 1880. (This may require two separate piped statements).

head(babynames)
```

    ## # A tibble: 6 × 5
    ##    year   sex      name     n       prop
    ##   <dbl> <chr>     <chr> <int>      <dbl>
    ## 1  1880     F      Mary  7065 0.07238433
    ## 2  1880     F      Anna  2604 0.02667923
    ## 3  1880     F      Emma  2003 0.02052170
    ## 4  1880     F Elizabeth  1939 0.01986599
    ## 5  1880     F    Minnie  1746 0.01788861
    ## 6  1880     F  Margaret  1578 0.01616737

``` r
topnames_2014 <- babynames %>%
  filter(year==2014)%>% #selects baby names from the year 2014
  group_by(sex)%>% #group by sex
  top_n(10,n) %>%#selects the top 10 values in the count column "n"
  select(name,sex) %>% #selcets the columns to output
  print() #prints the resulting data table
```

    ## Source: local data frame [20 x 2]
    ## Groups: sex [2]
    ## 
    ##         name   sex
    ##        <chr> <chr>
    ## 1       Emma     F
    ## 2     Olivia     F
    ## 3     Sophia     F
    ## 4   Isabella     F
    ## 5        Ava     F
    ## 6        Mia     F
    ## 7      Emily     F
    ## 8    Abigail     F
    ## 9    Madison     F
    ## 10 Charlotte     F
    ## 11      Noah     M
    ## 12      Liam     M
    ## 13     Mason     M
    ## 14     Jacob     M
    ## 15   William     M
    ## 16     Ethan     M
    ## 17   Michael     M
    ## 18 Alexander     M
    ## 19     James     M
    ## 20    Daniel     M

``` r
top10namehistory <- babynames %>% #loads the original babynames dataset into the vector
  inner_join(topnames_2014,by = c("sex", "name")) %>% #joins the two data tables by both the sex and the name 
  print() #prints the resulting data table
```

    ## # A tibble: 2,470 × 5
    ##     year   sex      name     n         prop
    ##    <dbl> <chr>     <chr> <int>        <dbl>
    ## 1   1880     F      Emma  2003 0.0205216999
    ## 2   1880     F Charlotte   237 0.0024281792
    ## 3   1880     F     Emily   210 0.0021515512
    ## 4   1880     F    Sophia   138 0.0014138765
    ## 5   1880     F  Isabella    50 0.0005122741
    ## 6   1880     F    Olivia    44 0.0004508012
    ## 7   1880     F       Ava    13 0.0001331913
    ## 8   1880     F   Abigail    12 0.0001229458
    ## 9   1880     M   William  9531 0.0804989907
    ## 10  1880     M     James  5927 0.0500595444
    ## # ... with 2,460 more rows

``` r
namesplot<-ggplot(top10namehistory, aes(x=year, y=prop))+facet_wrap(~name)+geom_point() #for some reason this line can't be part of the pipe.  It seems to have something to do with loading the data table into the vector on the first line. Weird.

print(namesplot) #prints the plots of the different names since 1880
```

![](Task_7_files/figure-markdown_github/Task_7-3.png)

``` r
#6)Make a single table of the 26th through 29th most common girls names in the year 1896, 1942, and 2016

girlsnames <- babynames %>% #loads the original babynames dataset into the vector
  filter(sex=="F", year==1896|year==1942|year==2014) %>% #filters for female names for the desired years
  group_by(year) %>% #groups the names by year
  mutate(name_rank = dense_rank(desc(n))) %>% #ranks the names for each year
  filter((name_rank > 25) & (name_rank < 30)) %>% #filters out the names which occur in the desired ranking range
  print() #prints the resulting data table
```

    ## Source: local data frame [13 x 6]
    ## Groups: year [3]
    ## 
    ##     year   sex     name     n        prop name_rank
    ##    <dbl> <chr>    <chr> <int>       <dbl>     <int>
    ## 1   1896     F   Martha  2022 0.008024032        26
    ## 2   1896     F   Esther  1964 0.007793867        27
    ## 3   1896     F  Frances  1964 0.007793867        27
    ## 4   1896     F    Edith  1932 0.007666880        28
    ## 5   1896     F   Myrtle  1928 0.007651006        29
    ## 6   1942     F    Helen 10013 0.007201706        26
    ## 7   1942     F  Marilyn  9905 0.007124029        27
    ## 8   1942     F    Diane  9550 0.006868700        28
    ## 9   1942     F   Martha  9514 0.006842807        29
    ## 10  2014     F Brooklyn  6791 0.003486940        26
    ## 11  2014     F     Lily  6760 0.003471022        27
    ## 12  2014     F   Hannah  6551 0.003363708        28
    ## 13  2014     F    Layla  6442 0.003307741        29

``` r
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
```

    ## Source: local data frame [1,092 x 5]
    ## Groups: origin, month [36]
    ## 
    ##    origin wind_speed    temp month   day
    ##     <chr>      <dbl>   <dbl> <dbl> <int>
    ## 1     EWR  12.758648 38.4800     1     1
    ## 2     EWR  12.514732 28.8350     1     2
    ## 3     EWR   7.863663 29.4575     1     3
    ## 4     EWR  13.857309 33.4775     1     4
    ## 5     EWR  10.836512 36.7325     1     5
    ## 6     EWR   8.007511 37.9700     1     6
    ## 7     EWR   8.870596 41.2775     1     7
    ## 8     EWR   6.616985 38.3150     1     8
    ## 9     EWR   4.651069 40.7825     1     9
    ## 10    EWR  10.117274 44.1875     1    10
    ## # ... with 1,082 more rows

``` r
tempplot <- ggplot(Windspeed_temp, aes(x=day, y=temp))+geom_point()+facet_wrap(origin ~ month)
print(tempplot)
```

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](Task_7_files/figure-markdown_github/Task_7-4.png)
