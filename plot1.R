# read data from file
econ <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?",
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"))

# filter for first two days in February
econFeb <- subset(econ, Date == "1/2/2007" | Date == "2/2/2007" )

# create PNG device with a size of 480 by 480
png("plot1.png", width=480, height=480, units="px")

# print histogram with axis scale
hist(econFeb$Global_active_power, col="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
axis(1, at=seq(0, 6, by=2))

# close device
dev.off()