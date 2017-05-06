#################################################
#################################################
## plot2.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment 
### and creates a boxplot of Emission for Balitmore for each year.
 
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

## Filter data to only include locations

## Filter and investigate data from the Baltimore area fips = 24510
balt <- nei[nei$fips %in% 24510, ]
head(balt)
tapply(balt$Emissions, balt$year, FUN = summary)
tapply(balt$Emissions, balt$year, FUN = length)

## Preview Plot 2
boxplot(Emissions ~ year, data = balt, ylim = c(0, 6), #Zoomed in view
        xlab = "Year", ylab = "Emissions", main = "PM2.5 Emissions 1999-2008")
boxplot(log10(Emissions) ~ year, data = balt,
        xlab = "Year", ylab = "Emissions", main = "log10 of PM2.5 Emissions in Balt 1999-2008")

## Create png file of plot 2
png(filename = paste("plot2", ".png", sep = ""))
boxplot(log10(Emissions) ~ year, data = balt,
        xlab = "Year", ylab = "Emissions", main = "log10 of PM2.5 Emissions in Balt 1999-2008")
dev.off()
