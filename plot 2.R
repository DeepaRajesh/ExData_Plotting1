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

## Generating Plot 2
plot(power$Global_active_power~power$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file in png format and close device
  dev.copy(png,"plot2.png", width=480, height=480)
  dev.off()
