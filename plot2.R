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

# creating PNG file
png('plot2.png')

# plot
with(myDF, plot(Time, Global_active_power, type = 'h'))

dev.off()
