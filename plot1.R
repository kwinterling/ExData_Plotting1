
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

gap <- as.numeric(data[,3])
gap <- gap[!is.na(gap)]

## Plotting

png("plot1.png", width = 480, height = 480)
hist(gap,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red")
dev.off()

## Create date time vector

## pdt <- paste(data[,1], data[,2])
## pdt <- strptime(pdt, format = "%Y-%m-%d %H:%M:%S")


