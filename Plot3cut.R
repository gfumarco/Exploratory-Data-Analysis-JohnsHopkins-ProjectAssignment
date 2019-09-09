library(plyr)
library(ggplot2)
library(data.table)
library(grid)
library(scales)
library(httr)

NEI <- readRDS("./data/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/NEI_data/Source_Classification_Code.rds")
BaltimoreData <- NEI[NEI$fips == "24510", ]
BData <- ddply(BaltimoreData, .(type, year), summarize, TotalEmissions = sum(Emissions))

png(filename = "Plot3.png", width = 750, height = 720, units = "px")
ggplot(BData, aes(year, TotalEmissions, colour = type)) + geom_line() + geom_point() + labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City, Maryland from 1999 to 2008"), x = "Year", y = expression('Total PM'[2.5]*" Emission (in tons)"))
dev.off()