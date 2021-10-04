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

# total NEI emissions by year
yearly_emissions <- aggregate(Emissions ~ year, NEI_data, sum)

# plot1.png
png(filename='plot1.png')

cols <- c("red", "orange", "yellow", "light blue")
barplot(height=yearly_emissions$Emissions/1000, names.arg=yearly_emissions$year, xlab="Year", ylab=expression('Total Emission (tons)'),main=expression('Total PM'[2.5]*' Emmissions by Year'), col = cols)

dev.off()

