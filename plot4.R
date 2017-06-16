library(dplyr)
library(tidyr)
library(lubridate)
library(varhandle)

## Downloading the data and turning it into a dataframe 
electricdata <- read.table("C:/Users/S0303025/Documents/R/household_power_consumption.txt", sep = ";", header = T)
electricdata <- tbl_df(electricdata)

## Setting up the date column in the large data set in order to subset it
electricdata$Date = unfactor(electricdata$Date)
electricdata$Date = dmy(electricdata$Date)

## Filtering the large dataset
smalldata <- filter(electricdata, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

## Making the time column a character column instead of a factor
smalldata$Time = unfactor(smalldata$Time)

## Creating a date time column in my data set
sm <- smalldata$Time
sm<- ymd(smalldata$Date) + hms(sm)
smalldata$DateTime <- sm

## Making all of the measurements numeric values instead of factors
smalldata$Sub_metering_1 = unfactor(smalldata$Sub_metering_1)
smalldata$Sub_metering_2 = unfactor(smalldata$Sub_metering_2)
smalldata$Global_reactive_power = unfactor(smalldata$Global_reactive_power)
smalldata$Voltage = unfactor(smalldata$Voltage)

## Setting up the plot
png("./plot4.png", width = 480, height = 480)

## Setting up the window to have 4 plots
par(mfrow=c(2,2))

## First plot
plot(smalldata$DateTime, smalldata$Global_active_power, type = "l", ann = FALSE)
title(xlab = NULL, ylab = "Global Active Power")

## Second plot
plot(smalldata$DateTime, smalldata$Voltage, type = "l", ann = FALSE)
title(xlab = "datetime", ylab = "Voltage")

## Third plot
plot(smalldata$DateTime, smalldata$Sub_metering_1, type="n", ann= FALSE)
title(ylab="Energy sub metering")
lines(smalldata$DateTime, smalldata$Sub_metering_1, col="black")
lines(smalldata$DateTime, smalldata$Sub_metering_2, col="blue")
lines(smalldata$DateTime, smalldata$Sub_metering_3, col="red")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), lwd=c(2.5, 2.5, 2.5), col=c("black", "blue", "red"))

## Fourth plot
plot(smalldata$DateTime, smalldata$Global_reactive_power, type = "l", ann = FALSE)
title(xlab = "datetime",  ylab = "Global_reactive_power")

dev.off()


