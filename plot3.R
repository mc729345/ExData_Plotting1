library("data.table")
setwd("~/Dropbox/coursera/data science/ExData_Plotting1")

# read in data
# subset for dates in question
power <- data.table::fread(input = "household_power_consumption.txt"
                           , na.strings="?"
)

# Drop scientific notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert to POSIXct date for easy filtering/graphing
power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter desired dates
power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Plot 3
png("plot3.png", width = 480, height = 480)
plot(power[, dateTime], 
     power[, Sub_metering_1], 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(power[, dateTime], power[, Sub_metering_2], col = "red")
lines(power[, dateTime], power[, Sub_metering_3], col = "blue")
legend("topright", 
       col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty = c(1,1), 
       bty = "n", 
       cex = 1) 
dev.off()
