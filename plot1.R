## Plot1 source file
## The data is available here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## Copy the zip file to your working directory and
## unzip files to working directory

## reading in the data from the current working directory
## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate the date over year

df <- aggregate(NEI$Emissions, list(Year = NEI$year), FUN = "sum")

## plot the data with meaningful labels
plot(df$Year, df$x, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "US Emissions")

## Add regression line
abline(lm(df$x~df$Year),col="red",lwd=1.5)

## Add some more ticks to the plot so measurements at 1999 and 2005 can easily be seen
axis(1, at = c(1999, 2001, 2003, 2005, 2007))

## Copying it to a file. Using the resolution used by R to render the plot on screen
## as it looks good

dev.copy(png, file = "plot1.png", width = 851, height = 561)

## And remembering to close the file

dev.off()
