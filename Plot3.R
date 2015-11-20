## Plot3 source file
## The data is available here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## Copy the zip file to your working directory and
## unzip files to working directory

## reading in the data from the current working directory
## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset with Baltimore data
df <- subset(NEI, fips == "24510")

## Adding library ggplot2
library(ggplot2)

## Opening a graphics device as the default on screen viewing is not good enough
png(file = "plot3.png", width = 1200, height = 1000)

## plot the data with facets to create 4 independent graphs
## and add the linear regression line to show increase or decrease.
## Remove outliers with coord_cartesian to be able to see linear
## regression more clearly
g <- ggplot(df, aes( x = year, y = Emissions))
g <- g + geom_point() + geom_smooth(method = "lm", colour="red") + facet_grid(. ~ type) 
g <- g + coord_cartesian(ylim = c(0,75)) + ggtitle("Baltimore City Emissions by Type")

## Print graph to file
print(g)

## And remembering to close the file

dev.off()
