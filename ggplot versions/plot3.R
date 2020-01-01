## Written by James Johnson

## plot3.R the creates the 'plot3.png' file

library(lubridate)
library(ggplot2)
library(reshape2)

options(digits = 6)

myData <- read.delim("household_power_consumption.txt", sep = ";", 
                     stringsAsFactors = FALSE)

#extract data
myData <- myData[(myData$Date == "2/2/2007") | (myData$Date == "1/2/2007"),]

#convert labels
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


png("plot3.png", width = 480, height = 480)

#Melt data
dataMelt <- melt(myData, id = "DateTime", measure.vars = 
                  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

g <- ggplot(dataMelt) + 
        geom_line(aes(x = DateTime, y = value, color = variable)) +
        scale_x_datetime(date_breaks = "day", date_labels = "%a") + 
        labs(x = "", y = "Energy sub metering") +
        theme(legend.position = c(.89, .92), legend.title = element_blank()) +
        scale_color_manual(labels = c("Sub Metering 1","Sub Metering 2",
                                      "Sub Metering 3"), values = 
                                   c("black", "red", "blue")) 


print(g)

dev.off()
