## Plot6 source file
## The data is available here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## Copy the zip file to your working directory and
## unzip files to working directory

## reading in the data from the current working directory
## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset with Baltimore and Los Angeles data
dfBalti <- subset(NEI, fips == "24510")
dfCali <- subset(NEI, fips == "06037")

## Extracting codes for motorvehicle sources. I am assuming it will
## be all sources with "Highway Veh" in their level two name
HiVeh <- grepl(pattern = "highway veh", SCC$SCC.Level.Two, ignore.case = TRUE)

## extracting the SCC values that have the desired value
HiVehValues <-SCC[HiVeh,]$SCC

## Now subsetting that data out of the Baltimore NEI data and aggregate it
HiVehBalti <- dfBalti[dfBalti$SCC %in% HiVehValues,]
BaltiVeh <- aggregate(Emissions~year, HiVehBalti, sum)

## Now subsetting that data out of the California NEI data and aggregate it
HiVehCali <- dfCali[dfCali$SCC %in% HiVehValues,]
CaliVeh <- aggregate(Emissions~year, HiVehCali, sum)

## Opening a graphics device as the default on screen viewing
## looks a bit cramped
png(file = "plot6.png", width = 1000, height = 1200)

## Combine 2 plots on the same screen
par(mfrow = c(2,1))

## plot the data with meaningful labels and regression lines and axis
plot(BaltiVeh$year, BaltiVeh$Emissions, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "Baltimore City Motor Vehicle Emissions")
abline(lm(BaltiVeh$Emissions~BaltiVeh$year),col="red",lwd=1.5)
axis(1, at = c(1999, 2001, 2003, 2005, 2007))
plot(CaliVeh$year, CaliVeh$Emissions, type = "b", xlab = "Year", ylab = "Sum of Emissions", main = "Los Angeles County Motor Vehicle Emissions")
abline(lm(CaliVeh$Emissions~CaliVeh$year),col="red",lwd=1.5)
axis(1, at = c(1999, 2001, 2003, 2005, 2007))

## And remembering to close the file
dev.off()
