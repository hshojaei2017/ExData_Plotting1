rm(list=ls())     #clear workspace
# setwd("/Users/hshojaei/Documents/data/ElectricPowerConsumption")   # set working directory

# read the data
electricity_data <- read.table("household_power_consumption.txt", sep = ';',header = TRUE, stringsAsFactors=FALSE)

# convert Date and Time to proper formats
electricity_data$Time <- paste(electricity_data$Date, electricity_data$Time)
electricity_data$Date <- as.Date(electricity_data$Date, "%d/%m/%Y")
electricity_data$Time <- as.POSIXlt(electricity_data$Time,format="%d/%m/%Y %H:%M:%S")

# convert data to numeric values
electricity_data$Global_active_power <- as.numeric(electricity_data$Global_active_power)
electricity_data$Global_reactive_power <- as.numeric(electricity_data$Global_reactive_power)
electricity_data$Voltage <- as.numeric(electricity_data$Voltage)
electricity_data$Global_intensity <- as.numeric(electricity_data$Global_intensity)
electricity_data$Sub_metering_1 <- as.numeric(electricity_data$Sub_metering_1)
electricity_data$Sub_metering_2 <- as.numeric(electricity_data$Sub_metering_2)
electricity_data$Sub_metering_3 <- as.numeric(electricity_data$Sub_metering_3)

# extract the desired subset of the data (dates 2007-02-01 and 2007-02-02)
subset_data <- subset(electricity_data, (electricity_data$Date=="2007-02-01")|(electricity_data$Date=="2007-02-02"))

# construct the plot and save to file
par(mfrow = c(1, 1), mar = c(5.1, 4.1, 4.1, 2.1), oma = c(2, 2, 2, 2))
with(subset_data, {
  plot(Time, Sub_metering_1,type="l", ylab = "Energy sub metering", xlab = "") 
  lines(Time, Sub_metering_2,col="red")
  lines(Time, Sub_metering_3,col="blue")
})

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty="solid")
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px") 
dev.off() 


