#################################################
#################################################
## plot5.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment 
### and creates a plot of Emissions in Baltimore related to vehicle sources.
 
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

## Determine which SCC's are related to vehicles
x <- unique(as.character(scc$SCC[grep("veh", as.character(scc$EI.Sector), ignore.case = TRUE)]))

## Correlate SCC idetifier to emissions data set and filter data for Balitmore
motor <- nei[nei$SCC %in% x, ]
motor <- motor[motor$fips %in% 24510, ]

## Preview plot 5
qplot(year, Emissions, data = motor)
g <- ggplot(data = motor, aes(year, Emissions))
g + geom_point(aes(color = year), alpha = .5) +
      geom_smooth(method = "lm") +
      #coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Vehicle Emissions in Baltimore")

## Create png file of plot 5
png(filename = paste("plot5", ".png", sep = ""))
g <- ggplot(data = motor, aes(year, Emissions))
g + geom_point(aes(color = year), alpha = .5) +
      geom_smooth(method = "lm") +
      #coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Vehicle Emissions in Baltimore")
dev.off()