library(data.table)

data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")[
        , Date := as.Date(Date, "%d/%m/%Y")][
        Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")][
        , "DateTime" := as.POSIXct(paste(Date, Time), 
        format = "%Y-%m-%d %H:%M:%S", 
        tz = "UTC")][
        , c("Date", "Time") := NULL]

with(data, plot(DateTime, Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()

