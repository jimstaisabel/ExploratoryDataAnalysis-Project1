setwd('/Users/jimstaisabel/Documents/R projects/ExploratoryDataAnalysis-Coursera/ExploratoryDataAnalysis-Project1/data')

# READING AND LOADING THE DATA
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
View(data)

# SUBSETTING THE DATA
data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]

# COMBINING DATE AND TIME INTO ONE VARIABLE
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# CLEANING THE DATA
rownames(data) <- 1 : nrow(data)

library(dplyr)
data <- data %>% select(10, 3:9)

colnames(data) <- tolower(colnames(data))


#######################

# PLOT 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 15, ylim = c(0, 1200))
dev.off()