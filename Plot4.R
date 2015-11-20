## Plot4 source file
## The data is available here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## Copy the zip file to your working directory and
## unzip files to working directory

## reading in the data from the current working directory
## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data to only coal combustion-related sources
## I'll take that to mean sources with combustion in level 1
## and coal in level 4
coal <- grepl(pattern = "coal", SCC$SCC.Level.Four, ignore.case = TRUE)
comb <- grepl(pattern = "comb", SCC$SCC.Level.One, ignore.case = TRUE)

## extracting the SCC values that have the desired coal and combustion
## combination in level 1 and 4 from the SCC table
coalcomb <-SCC[comb & coal,]$SCC

## Now subsetting that data out of the NEI data and aggregate it
NEIcoalcomb <- NEI[NEI$SCC %in% coalcomb,]
NEIcoalcombTotalEm <- aggregate(Emissions~year, NEIcoalcomb, sum)

## Opening a graphics device as the default on screen viewing is not good enough
png(file = "plot3.png", width = 600, height = 800)

## This is a very simple plot so using base plotting again
plot(NEIcoalcombTotalEm$year, NEIcoalcombTotalEm$Emissions, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "US national Coal-Combustion related Emissions")

## Add regression line
abline(lm(NEIcoalcombTotalEm$Emissions~NEIcoalcombTotalEm$year),col="red",lwd=1.5)

## Add some more ticks to the plot so measurements at 1999 and 2005 can easily be seen
axis(1, at = c(1999, 2001, 2003, 2005, 2007))

## And remembering to close the file
dev.off()
