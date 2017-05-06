#################################################
#################################################
## plot6.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment 
### and creates a plot of Emissions comparing LA and Baltimore

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

## Determine which SCC's are related to vehicle emissions
x <- unique(as.character(scc$SCC[grep("veh", as.character(scc$EI.Sector), ignore.case = TRUE)]))

## Correlate SCC idetifier to emissions data set for Baltimore and LA
motor <- nei[nei$SCC %in% x, ]
motor <- motor[motor$fips %in% c("24510", "06037"), ]

## Preview Plot 6
qplot(year, Emissions, data = motor)
g <- ggplot(data = motor, aes(year, Emissions))
g + geom_point(aes(color = fips), alpha = .5) +
      geom_smooth(method = "lm") +
      #coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008))

g <- ggplot(data = motor, aes(year, Emissions, color = fips))
g + geom_point(alpha = .5) +
      geom_smooth(method = "lm") +
      coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Vehicle Emissions for Baltimore (24510) and LA (06037)")

## Create png file of plot 6
png(filename = paste("plot6", ".png", sep = ""))
g <- ggplot(data = motor, aes(year, Emissions, color = fips))
g + geom_point(alpha = .5) +
      geom_smooth(method = "lm") +
      coord_cartesian(ylim = c(0, 100)) +
      scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
      ggtitle("Vehicle Emissions for Baltimore (24510) and LA (06037)")
dev.off()