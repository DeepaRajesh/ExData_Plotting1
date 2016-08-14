## Loading the data

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
power$Date <- as.Date(power$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
power<- subset(power,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
power <- power[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(power$Date, power$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
power <- power[ ,!(names(power) %in% c("Date","Time"))]
  
## Add DateTime column
power <- cbind(dateTime, power)
  
## Format dateTime Column
power$dateTime <- as.POSIXct(dateTime)

## Generating Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
 with(power, {
    plot(Global_active_power~dateTime, type="l",  ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ dateTime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ dateTime, type = "l", ylab = "Energy sub metering",
          xlab = "")
     lines(Sub_metering_2 ~ dateTime, col = 'Red')
     lines(Sub_metering_3 ~ dateTime, col = 'Blue')
     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
             bty = "n",
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power ~ dateTime, type = "l", 
          ylab = "Global_rective_power", xlab = "datetime")
})

## Save file in png format and close device
  dev.copy(png,"plot4.png", width=480, height=480)
  dev.off()
