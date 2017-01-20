## Exploratory Data Analysis Week 1 assignment #3/4
#

# read in file
fUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download data and unzip it
download.file(fUrl, destfile = "./data.zip", method = "curl")
unzip("data.zip", exdir = ".")

# read in source file (.txt) and save as "powerdf"
powerdf <- read.table("household_power_consumption.txt",sep = ";", na.strings = "?", header=TRUE)

# change format of Dates 
powerdf$Date <- as.Date(powerdf$Date,format = "%d/%m/%Y")
# subset table to two dates as requested
limiteddf <- subset(powerdf, Date >= "2007-02-01" & Date <= "2007-02-02")
# change "Time" column values to POSIXct using the "Date" values
limiteddf$Time <- as.POSIXct(paste(limiteddf$Date, limiteddf$Time), format="%Y-%m-%d %H:%M:%S")

# create png file using png device
png(file = "plot3.png", height = 480, width = 480, units = "px")
par(mfrow = c(1,1))

# plot sub metering data (n=3) by weekday w/o points
with(limiteddf,plot(Time,Sub_metering_1,xlab = "",ylab = "Energy sub metering", type = "l"))
with(limiteddf,lines(Time, Sub_metering_2, col = "red"))
with(limiteddf,lines(Time, Sub_metering_3, col = "blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"))

dev.off()
