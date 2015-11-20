## Plot2 source file
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

## Aggregate the data over years
df <- aggregate(df$Emissions, list(Year = df$year), FUN = "sum")

## plot the data with meaningful labels
plot(df$Year, df$x, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "Baltimore City Emissions")

## Add regression line
abline(lm(df$x~df$Year),col="red",lwd=1.5)

## Add some more ticks to the plot so measurements at 1999 and 2005 can easily be seen
axis(1, at = c(1999, 2001, 2003, 2005, 2007))

## Copying it to a file. Using 851x561 to make sure it looks as on screen

dev.copy(png, file = "plot2.png", width = 851, height = 561)

## And remembering to close the file

dev.off()
