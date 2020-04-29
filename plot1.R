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

# Plot 1
png("plot1.png", width = 480, height = 480)
hist(power$Global_active_power, 
     main = "Global active power", 
     xlab = "Global active power (kilowatts)", 
     col = "red")
dev.off()