#set working directory
setwd("C:/Git_Clarivate/_RStudio/exploratory_data_analysis_week4_project2")
path <- getwd()

#download data for peer assessment
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "dataFiles.zip"
download.file(url = url1, destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#read two files using readRDS()
NEI_data <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

## subset data from Baltimore City from type "on road"
baltimore_car_data <- subset(NEI_data, NEI_data$fips=="24510" 
                             & NEI_data$type=="ON-ROAD")
baltimore_car_year <- aggregate(baltimore_car_data$Emissions, 
                                by=list(baltimore_car_data$year), FUN=sum)
colnames(baltimore_car_year) <- c("Year", "Emissions")

#load ggplot2 library
library(ggplot2)

# plot5.png
png("plot5.png")

plot(baltimore_car_year$Year, baltimore_car_year$Emissions,
     type = "o",
     xlab = "year",
     ylab = "Total Emissions (tons)",
     main = "Motor Vehicle Related Emissions of PM2.5 in US from 1999-2008",
     sub = "Baltimore City")

dev.off()
