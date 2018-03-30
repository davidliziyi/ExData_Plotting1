library(data.table)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")[
        , Date := as.Date(Date, "%d/%m/%Y")][
        Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")][
        , "DateTime" := as.POSIXct(paste(Date, Time), 
        format = "%Y-%m-%d %H:%M:%S", 
        tz = "UTC")][
        , c("Date", "Time") := NULL]

with(data, plot(DateTime, Sub_metering_1, type = "n", 
                ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, type = "l", col = "black"))
with(data, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
with(data, legend("topright", legend = c("Sub_metering_1", 
                                         "Sub_metering_2", 
                                         "Sub_metering_3"), 
                  col = c("black", "red", "blue"), lty = 1, cex = 0.5))

dev.copy(png, file = "plot3.png")
dev.off()

