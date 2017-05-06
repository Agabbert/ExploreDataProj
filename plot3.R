#################################################
#################################################
## plot3.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment 
### and creates a plot of Emission for Balitmore for each year by type.

#############################################################

## Set working directory to the location which contains "summarySCC_PM25.rds" 
## and "Source_Classification_Code.rds"
# setwd("Type your working directory here")
list.files() #To view files in working directory

## Read the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Investigate the data
tapply(nei$Emissions, nei$year, FUN = summary)
tapply(nei$Emissions, nei$year, FUN = length)

## Filter and investigate data from the Baltimore area fips = 24510
balt <- nei[nei$fips %in% 24510, ]
head(balt)
tapply(balt$Emissions, balt$year, FUN = summary)
tapply(balt$Emissions, balt$year, FUN = length)

## Load helpful packages
library(ggplot2)

## Quick plot preview
qplot(year, Emissions, data = balt, facets = .~type, color = year, 
      geom = c("point","smooth"), method="lm")

## Preview Plot 3
g <- ggplot(data = balt, aes(year, Emissions))
g + geom_point(aes(color = year), alpha = .5) +
      facet_wrap(~as.factor(type)) +
      geom_smooth(method = "lm") +
      coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Emissions for Balitmore by Type")

## Create png file of plot 3
png(filename = paste("plot3", ".png", sep = ""))
g + geom_point(aes(color = year), alpha = .5) +
      facet_wrap(~as.factor(type)) +
      geom_smooth(method = "lm") +
      coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Emissions for Balitmore by Type")
dev.off()
