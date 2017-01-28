# set the locale to english in order to get the weekdays in the right language
Sys.setlocale("LC_TIME", "English")

# read data from file
econ <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?",
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"))

# filter for first two days in February
econFeb <- subset(econ, Date == "1/2/2007" | Date == "2/2/2007" )

# create a column in POSIXlt format
econFeb <- within(econFeb, 
                  Day <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# create PNG device with a size of 480 by 480
png("plot4.png", width=480, height=480, units="px")

par(mfcol = c(2,2))

# plot at c(1,1)
plot(econFeb$Day, econFeb$Global_active_power, 
     type = "l",
     ylab = "Global Active Power", xlab = NA)
axis(2, at=seq(0, 6, by=2))

# plot at c(1,2)
plot(econFeb$Day, econFeb$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering", xlab = NA)
lines(econFeb$Day, econFeb$Sub_metering_2, col="red")
lines(econFeb$Day, econFeb$Sub_metering_3, col="blue")

legend("topright", bty = "n",
       lty = c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

# plot ad c(1, 2)
plot(econFeb$Day, econFeb$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")

# plot ad c(2, 2)
plot(econFeb$Day, econFeb$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")
axis(2, at=seq(0, 0.5, by=0.1))

# close device
dev.off()
