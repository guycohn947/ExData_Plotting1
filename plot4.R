# Name: plot4.R
# Purpose: Part of project 1 in the "Exploratory Analysis" class at John Hopkins University,
#          which is a part of the John Hopkins Data Science Specialization track.
#          The script loads data from the household energy consumption dataset.
#          It constructs plot 4 according to the instructions in README.md and saves
#          it as plot4.png .
#          Notes: 1. Script assumes dataset is in the current working directory.
#                 2. Dataset URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
# Arguments: None
# Output: None

# Load and clean data

householdData <- read.table("household_power_consumption.txt", header = TRUE, 
                            sep = ";", na.strings = "?",
                            colClasses = c(rep("character", 2), rep("numeric", 7)))
householdData <- householdData[householdData$Date %in% c("1/2/2007", "2/2/2007"),]
householdData$Time <- paste(householdData$Date, householdData$Time, sep = " ")
householdData$Date <- as.Date(householdData$Date, "%d/%m/%Y")
householdData$Time <- strptime(householdData$Time, "%d/%m/%Y %H:%M:%S")

# Construct plot

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(householdData, plot(Time, Global_active_power, type = "l", xlab = "",
                         ylab = "Global Active Power"))
with(householdData, plot(Time, Voltage, type = "l", xlab = "datetime",
                         ylab = "Voltage"))
with(householdData, plot(Time, Sub_metering_1, type = "l", xlab = "",
                         ylab = "Energy sub metering", col = "black"))
with(householdData, lines(Time, Sub_metering_2, col = "red"))
with(householdData, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lwd = 1, bty = "n", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(householdData, plot(Time, Global_reactive_power, type = "l",
                         xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()


