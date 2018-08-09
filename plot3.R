
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

# removing data we don't need
rm(data)

# create PNG file
png('plot3.png')

# plot
plot(myDF$Time, myDF$Sub_metering_1, type = 'l', xlab = "Time", ylab = "Energy sub metering")
lines(myDF$Time, myDF$Sub_metering_2, type = 'l', col = 'red')
lines(myDF$Time, myDF$Sub_metering_3, type = 'l', col = 'blue')
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.3, pt.cex = 10)

# off
dev.off()
