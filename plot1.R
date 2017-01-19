# read in source file (.txt) and save as "powerdf"
powerdf <- read.table("household_power_consumption.txt",sep = ";", na.strings = "?", header=TRUE)
# change format of Dates 
powerdf$Date <- as.Date(powerdf$Date,format = "%d/%m/%Y")
# subset table to two dates as requested
limiteddf <- subset(powerdf, Date >= "2007-02-01" & Date <= "2007-02-02")
# change "Time" column values to POSIXct using the "Date" values
limiteddf$Time <- as.POSIXct(paste(limiteddf$Date, limiteddf$Time), format="%Y-%m-%d %H:%M:%S")

# create png file using png device
png(file = "plot1.png", height = 480, width = 480, units = "px")
par(mfrow = c(1,1))
# create histogram of global active power 
hist(limiteddf$Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
