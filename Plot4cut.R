library(plyr)
library(ggplot2)
library(data.table)
library(grid)
library(scales)
library(httr)

NEI <- readRDS("./data/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/NEI_data/Source_Classification_Code.rds")
Coal <- SCC[grep("Comb.*Coal", SCC$Short.Name), "SCC"]
CoalNEI <- NEI[NEI$SCC %in% Coal, ]

TData <- ddply(CoalNEI, .(year), summarise, TotalEmissions = sum(Emissions))

png(filename = "Plot4.png", width = 480, height = 480, units = "px")

ggplot(TData, aes(year, TotalEmissions)) + geom_line(color = "red") + geom_point() + labs(title = "Total Emissions from Coal Combustion-Related Sources", x = "Year", y = "Total Emissions")
dev.off()