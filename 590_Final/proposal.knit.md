---
title: "Infinite XY plots"
author: "Ken"
date: "March 22, 2017"
output: html_document
---



# Infinite Print XY plots

  This would be a package that would read a .csv file which with a relatively large number (>20) of variables for every sample (such as elemental data or lower order taxonomic data).  The user will then be able to select a limited number of qualifiers that would be used to differentiate between samples.  These qualifiers would be mapped to either the color or shape of the data points (for example: if the user had a series of wells or some other data collected in a way that there are a large number of data points associated with different depths at different locations which also had intervals identified by rock type or unconformity surfaces.) 

  Once these qualifiers are selected, the function will print a series of XY plots which will compare every variable to every other variable using (probably) a For Loop until a comparison occurs only once (hopefully).  The idea is to be able to quickly and easily generate identically formatted XY plots that can be examined for relationships that might exist but that would be limited to certain intervals along a depth profile.  Kind of like a longwinded pearson diagram but with the ability to see if there are covariation between different variables that might exist in the data set but which are limited to certain intervals.  This would be useful for quickly visualizing the covariation of different variables that might not be seen over the entire length of the dataset in a very basic way.
