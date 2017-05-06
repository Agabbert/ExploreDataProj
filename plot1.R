#################################################
#################################################
## plot1.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment and creates a
### boxplot of total Emissions for each year.

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

## Preview Plot 1
boxplot(Emissions ~ year, data = nei, ylim = c(0, .65), #Zoomed in view
        xlab = "Year", ylab = "Emissions", main = "PM2.5 Emissions 1999-2008")
boxplot(log10(Emissions) ~ year, data = nei,
        xlab = "Year", ylab = "Emissions", main = "log10 of PM2.5 Emissions 1999-2008")

## Create png file of plot 1
png(filename = paste("plot1", ".png", sep = ""))
boxplot(log10(Emissions) ~ year, data = nei,
        xlab = "Year", ylab = "Emissions", main = "log10 of PM2.5 Emissions 1999-2008")
dev.off()
