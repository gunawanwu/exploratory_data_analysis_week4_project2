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

## subset to just data from Baltimore and sum up emissions by variable "type"
baltimore_data <- subset(NEI_data, NEI_data$fips=="24510")
baltimore_type_year <- aggregate(baltimore_data$Emissions, 
                                 by=list(baltimore_data$type, baltimore_data$year), 
                                 FUN=sum)
colnames(baltimore_type_year) <- c("Type", "Year", "Emissions")

#load ggplot2 library
library(ggplot2)

# plot3.png
png("plot3.png")

qplot(Year, Emissions, data = baltimore_type_year, color = Type, geom = "line") +
  ggtitle("Total Emissions of PM2.5 in Baltimore City By pollutant type") + 
  ylab("Total Emissions (tons)") + 
  xlab("Year") 

dev.off()
