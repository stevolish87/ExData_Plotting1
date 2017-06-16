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
smalldata$Global_active_power <- unfactor(smalldata$Global_active_power)

## Setting up the plot
png("./plot1.png", width = 480, height = 480)

## Generating the histogram
hist(smalldata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()

