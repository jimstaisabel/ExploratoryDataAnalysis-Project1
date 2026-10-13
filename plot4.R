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


# PLOT 4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

# Row 1, Col 1
plot(data$datetime, data$global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
lines(data$datetime, data$global_active_power, col = "black")
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")), labels = c("Thu", "Fri", "Sat"))

# Row 1, Col 2
plot(data$datetime, data$voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
lines(data$datetime, data$voltage, col = "black")
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")), labels = c("Thu", "Fri", "Sat"))

# Row 2, Col 1
plot(data$datetime, data$sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$datetime, data$sub_metering_1, col = "black")
lines(data$datetime, data$sub_metering_2, col = "red")
lines(data$datetime, data$sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")), labels = c("Thu", "Fri", "Sat"))

# Row 2, Col 2
plot(data$datetime, data$global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = colnames(data)[3], xaxt = "n")
lines(data$datetime, data$global_reactive_power, col = "black")
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")), labels = c("Thu", "Fri", "Sat"))

dev.off()