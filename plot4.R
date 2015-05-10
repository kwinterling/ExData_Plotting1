
## Read the data - assumes household_power_consumption.txt is
## in the current working directory

data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   colClasses = "character")

## Normalize dates

data[,1] <- as.Date(data[,1], format = "%d/%m/%Y")

## Do we have the right dates?

date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")
data <- data[(data[,1] == date1) | (data[,1] == date2),]

## Create date time vector

pdt <- paste(data[,1], data[,2])
pdt <- strptime(pdt, format = "%Y-%m-%d %H:%M:%S")

gap <- as.numeric(data[,3])
notnagap <- !is.na(gap)
grp <- as.numeric(data[,4])
notnagrp <- !is.na(grp)
voltage <- as.numeric(data[,5])
notnavoltage <- !is.na(voltage)

Sub_metering_1 <- as.numeric(data[,7])
notnasm1 <- !is.na(Sub_metering_1)
Sub_metering_2 <- as.numeric(data[,8])
notnasm2 <- !is.na(Sub_metering_2)
Sub_metering_3 <- as.numeric(data[,9])
notnasm3 <- !is.na(Sub_metering_3)


## Plotting

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
plot(pdt[notnagap],
     gap[notnagap],
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

plot(pdt[notnavoltage],
     voltage[notnavoltage],
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

plot(pdt[notnasm1],
     Sub_metering_1[notnasm1],
     xlab = "",
     ylab = "Energy sub metering",
     type = "l",
     col = "black")
lines(pdt[notnasm2],
      Sub_metering_2[notnasm2],
      col = "red")
lines(pdt[notnasm3],
      Sub_metering_3[notnasm3],
      col = "blue")
legend("topright",
       bty = "n",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))

plot(pdt[notnagrp],
     grp[notnagrp],
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l",
     lwd = 0.2)
dev.off()
