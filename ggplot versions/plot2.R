## Written by James Johnson

## plot1.R the creates the 'plot2.png' file
library(lubridate)
library(ggplot2)

options(digits = 6)

myData <- read.delim("household_power_consumption.txt", sep = ";", 
                     stringsAsFactors = FALSE)

myData <- myData[(myData$Date == "2/2/2007") | (myData$Date == "1/2/2007"),]

myData$Date <- dmy(myData$Date)
myData$Time <- hms(myData$Time)
myData$DateTime <- as.POSIXct(myData$Date +myData$Time)

myData$Global_active_power <- as.numeric(myData$Global_active_power) 
myData$Global_reactive_power <- as.numeric(myData$Global_reactive_power) 
myData$Voltage <- as.numeric(myData$Voltage) 
myData$Global_intensity <- as.numeric(myData$Global_intensity)
myData$Sub_metering_1 <- as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2 <- as.numeric(myData$Sub_metering_2) 
myData$Sub_metering_3 <- as.numeric(myData$Sub_metering_3)

png("plot2.png", width = 480, height = 480)

g <- ggplot(myData, aes(x = DateTime, y = Global_active_power)) + 
        geom_line() + 
        scale_x_datetime(date_breaks = "day", date_labels = "%a") + 
        labs(x = "", y = "Global Active Power (kilowatts")
print(g)

dev.off()
