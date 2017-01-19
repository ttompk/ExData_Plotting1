# read in source file (.txt) and save as "powerdf"
powerdf <- read.table("household_power_consumption.txt",sep = ";", na.strings = "?", header=TRUE)
# change format of Dates 
powerdf$Date <- as.Date(powerdf$Date,format = "%d/%m/%Y")
# subset table to two dates as requested
limiteddf <- subset(powerdf, Date >= "2007-02-01" & Date <= "2007-02-02")
# change "Time" column values to POSIXct using the "Date" values
limiteddf$Time <- as.POSIXct(paste(limiteddf$Date, limiteddf$Time), format="%Y-%m-%d %H:%M:%S")

# create png file using png device
png(file = "plot4.png", height = 480, width = 480, units = "px")
# set quad display
par(mfrow = c(2,2))
# display 1: plot global active power by weekday w/o points
with(limiteddf,plot(Time,Global_active_power,xlab = "",ylab = "Global Active Power (killowatts)", type = "l"))
# display 2: plot voltage by weekday w/o points
with(limiteddf,plot(Time,Voltage,xlab = "datetime",ylab = "Voltage", type = "l"))
# display 3: plot sub metering data (n=3) by weekday w/o points
with(limiteddf,plot(Time,Sub_metering_1,xlab = "",ylab = "Energy sub metering", type = "l"))
with(limiteddf,lines(Time, Sub_metering_2, col = "red"))
with(limiteddf,lines(Time, Sub_metering_3, col = "blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"), bty = "n")
# display 4: plot global reactive power by weekday w/o points
with(limiteddf,plot(Time,Global_reactive_power,xlab = "datetime",ylab = "Global_reactive_power", type = "l"))

dev.off()
