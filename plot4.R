#################################################
#################################################
## plot4.R for Week 4 Exploratory Analysis

### This script reads data regarding PM2.5 Emissions provided for this assignment 
### and creates a plot of Emissions across the US from sources related to 
### coal combustion.
 
#############################################################
## Load useful packages
library(tidyr)
library(dplyr)

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

## Filter nei data to only locations that have occured in each year
byear <- split(nei, nei$year)
str(byear)

byear$`1999` <- mutate(byear$`1999`, locpoint = paste(fips, SCC, sep = "."))
byear$`2002` <- mutate(byear$`2002`, locpoint = paste(fips, SCC, sep = "."))
byear$`2005` <- mutate(byear$`2005`, locpoint = paste(fips, SCC, sep = "."))
byear$`2008` <- mutate(byear$`2008`, locpoint = paste(fips, SCC, sep = "."))

#byear$`1999`$locpoint %in% byear$`2002`$locpoint
byear.row <- byear$`1999`[byear$`1999`$locpoint %in% byear$`2002`$locpoint, ]
byear.row <- byear.row[byear.row$locpoint %in% byear$`2005`$locpoint, ]
byear.row <- byear.row[byear.row$locpoint %in% byear$`2008`$locpoint, ]

nei <- mutate(nei, locpoint = paste(fips, SCC, sep = "."))
nei <- nei[nei$locpoint %in% byear.row$locpoint, ]

## Determine which SCC's are related to coal
x <- unique(as.character(scc$SCC[grep("coal", as.character(scc$EI.Sector), ignore.case = TRUE)]))

## Correlate SCC idetifier to emissions data set
coal <- nei[nei$SCC %in% x, ]

## Preview Plot 4
plot(Emissions ~ year, data = coal)
plot(Emissions ~ year, data = coal, ylim = c(0, 1000),
        xlab = "Year", ylab = "Emissions", 
        main = "PM2.5 Emissions 1999-2008 Related to Coal")
model <- with(coal, lm(Emissions ~ year))
abline(model, lwd = 2, col = "blue")

## Create png file of plot 4
png(filename = paste("plot4", ".png", sep = ""))
g <- ggplot(data = coal, aes(year, Emissions))
g + geom_point(aes(color = year), alpha = .5) +
    geom_smooth(method = "lm") +
    coord_cartesian(ylim = c(0, 1000)) +
    scale_x_discrete(name="year", limits=c(1999, 2002, 2005, 2008)) +
    ggtitle("PM2.5 Emissions 1999-2008 Related to Coal")
dev.off()
