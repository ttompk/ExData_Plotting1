## Exploratory Data Analysis Week 1 assignment #2/4
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
png(file = "plot2.png", height = 480, width = 480, units = "px")
par(mfrow = c(1,1))

# create plot of global active power by weekday w/o points
with(limiteddf,plot(Time,Global_active_power,xlab = "",ylab = "Global Active Power (killowatts)", type = "l"))
dev.off()
