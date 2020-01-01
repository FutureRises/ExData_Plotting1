## Written by James Johnson

## plot4.R the creates the 'plot4.png' file

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

#make DateTime Column
myData$DateTime <- as.POSIXct(myData$Date +myData$Time)

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(myData$DateTime, myData$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

plot(myData$DateTime, myData$Voltage, type = "l",
     ylab = "Voltage")

plot(myData$DateTime, myData$Sub_metering_1,  type = "l", col = "black",
     xlab = "", ylab = "Energy sub Metering")
lines (myData$DateTime,myData$Sub_metering_2, type = "l", col = "red")
lines (myData$DateTime,myData$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), 
       col = c("black", "red", "blue"), lty = 1)

plot(myData$DateTime, myData$Global_reactive_power, type = "l", xlab = "",
     ylab = "Global Reactive Power (kilowatts)")

dev.off()
