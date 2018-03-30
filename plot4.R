library(data.table)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")[
        , Date := as.Date(Date, "%d/%m/%Y")][
        Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")][
        , "DateTime" := as.POSIXct(paste(Date, Time), 
        format = "%Y-%m-%d %H:%M:%S", 
        tz = "UTC")][
        , c("Date", "Time") := NULL]

par(mfrow = c(2, 2))
with(data, {
        plot(DateTime, Global_active_power, type = "l")
        plot(DateTime, Voltage, type = "l")
        plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_1, type = "l", col = "black")
        lines(DateTime, Sub_metering_2, type = "l", col = "red")
        lines(DateTime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1", 
                                      "Sub_metering_2", 
                                      "Sub_metering_3"), 
                col = c("black", "red", "blue"), lty = 1, 
                cex = 0.5, box.lwd = 0)
        plot(DateTime, Global_reactive_power, type = "l")
})

dev.copy(png, file = "plot4.png")
dev.off()