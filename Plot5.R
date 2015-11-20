## Plot5 source file
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

## Extracting codes for motorvehicle sources. I am assuming it will
## be all sources with "Highway Veh" in their level two name
HiVeh <- grepl(pattern = "highway veh", SCC$SCC.Level.Two, ignore.case = TRUE)

## extracting the SCC values that have the desired value
HiVehValues <-SCC[HiVeh,]$SCC

## Now subsetting that data out of the Baltimore NEI data and aggregate it
HiVehBaltimore <- df[df$SCC %in% HiVehValues,]
BaltiVeh <- aggregate(Emissions~year, HiVehBaltimore, sum)

## plot the data with meaningful labels
plot(BaltiVeh$year, BaltiVeh$Emissions, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "Baltimore City Motor Vehicle Emissions")

## Add regression line
abline(lm(BaltiVeh$Emissions~BaltiVeh$year),col="red",lwd=1.5)

## Add some more ticks to the plot so measurements at 1999 and 2005 can easily be seen
axis(1, at = c(1999, 2001, 2003, 2005, 2007))

## Copying it to a file. Using the default R Studio resolution as
## it looks good and clear
dev.copy(png, file = "plot5.png", width = 645, height = 503)

## And remembering to close the file
dev.off()
