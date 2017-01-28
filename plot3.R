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
png("plot3.png", width=480, height=480, units="px")

plot(econFeb$Day, econFeb$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering", xlab = NA)
lines(econFeb$Day, econFeb$Sub_metering_2, col="red")
lines(econFeb$Day, econFeb$Sub_metering_3, col="blue")

legend("topright",
       lty = c(1,1,1),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

# close device
dev.off() 