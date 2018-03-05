householdFile <- "household_power_consumption.txt"

data <- read.table(householdFile, header = TRUE, sep = ";", na.strings = "?")

data$Date <- as.Date(data$Date, "%d/%m/%Y")

data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

data <- data[complete.cases(data), ]

dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")

data <- data[, !names(data) %in% c("Date", "Time")]

data <- cbind(dateTime, data)

data$dateTime <- as.POSIXct(dateTime)

plot(data$Global_active_power~data$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, "plot2.png", height=480, width=480)

dev.off()