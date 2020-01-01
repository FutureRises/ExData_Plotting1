## Written by James Johnson

## plot1.R the creates the 'plot1.png' file

library(lubridate)

options(digits = 6)

#load data
myData <- read.delim("household_power_consumption.txt", sep = ";", 
                     stringsAsFactors = FALSE)
#extract subset
myData <- myData[(myData$Date == "2/2/2007") | (myData$Date == "1/2/2007"),]

#convert column classes
myData$Date <- dmy(myData$Date)
myData$Time <- hms(myData$Time)
myData$Global_active_power <- as.numeric(myData$Global_active_power) 
myData$Global_reactive_power <- as.numeric(myData$Global_reactive_power) 
myData$Voltage <- as.numeric(myData$Voltage) 
myData$Global_intensity <- as.numeric(myData$Global_intensity)
myData$Sub_metering_1 <- as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2 <- as.numeric(myData$Sub_metering_2) 
myData$Sub_metering_3 <- as.numeric(myData$Sub_metering_3)

#open device
png("plot1.png", width = 480, height = 480)

hist(myData$Global_active_power,
     main = "Global Active Power",
     xlab = " Global Active Power (kilowatts)",
     col = "red")

#close device
dev.off()
