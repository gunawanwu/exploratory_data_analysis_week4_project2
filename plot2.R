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

#subset NEI data by Baltimore
baltimore_data <- NEI_data[NEI_data$fips=="24510", ]

#Baltimore yearly emissions data
baltimore_data_year <- aggregate(Emissions ~ year, baltimore_data, sum)

# plot2.png
png(filename='plot2.png')

cols <- c("red", "orange", "yellow", "light blue")
barplot(height=baltimore_data_year$Emissions/1000, names.arg=baltimore_data_year$year, xlab="Year", ylab=expression('Total Emission (tons)'),main=expression('Baltimore Total PM'[2.5]*' Emissions by Year'), col = cols)

dev.off()
