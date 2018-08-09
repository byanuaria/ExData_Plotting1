# loading packages
library(tidyverse)

# reading in data
data <- read.table("household_power_consumption.txt",
                   header = TRUE, sep = ';',
                   na.strings = "?")

# convert date column to Date 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# convert time column to PSOSCIXlt
data$Time <- strptime(data$Time, format = "%H:%M:%S")

# subset data for two day period in February, 2007
# (2007-02-01 - 2007-02-02)
myDF <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# remove data we don't need
rm(data)

# create PNG file
png('plot4.png')

# set parameters for 2 rows and 2 columns
par(mfrow = c(2,2), mar=c(2,4,1,1))

# first plot
with(myDF, plot(Time, Global_active_power, type = 'h', ylab = "Global Active Power"))

# second plot 
with(myDF, plot(Time, Voltage, type = 'l'))

# third plot
plot(myDF$Time, myDF$Sub_metering_1, type = 'l', xlab = "Time", ylab = "Energy sub metering")
lines(myDF$Time, myDF$Sub_metering_2, type = 'l', col = 'red')
lines(myDF$Time, myDF$Sub_metering_3, type = 'l', col = 'blue')
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# fourth plot
with(myDF, plot(Time, Global_reactive_power, type = 'l'))

dev.off()
