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

## subset data from Baltimore City, LA county and from type "on road"
baltLA_car_data <- subset(NEI_data, NEI_data$fips=="24510" |
                                  NEI_data$fips=="06037" &
                                  NEI_data$type=="ON-ROAD")
baltLA_car_year <- aggregate(baltLA_car_data$Emissions, 
                             by=list(baltLA_car_data$fips, baltLA_car_data$year),
                             FUN=sum)
colnames(baltLA_car_year) <- c("City", "Year", "Emissions")

#load ggplot2 library
library(ggplot2)

# plot6.png
png(filename = "plot6.png")

qplot(Year, Emissions, data = baltLA_car_year, color = City, geom = "line") +
        ggtitle("Emissions of PM2.5 in Baltimore City (24510) and LA County (06037)") + 
        ylab("Total Emissions from motor vehicle (tons)") + 
        xlab("Year") 

dev.off()
