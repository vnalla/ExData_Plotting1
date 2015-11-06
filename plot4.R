## File
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the file

download_file_name <- "exdata_data_household_power_consumption.zip"
download.file(file, download_file_name, "curl")

## Unzip the file
unzip(download_file_name, overwrite = TRUE)
data_file_name <- "household_power_consumption.txt"

## Memory requirement
## 2075259 * 48/2^20 = 95 MB (aproximately)

## Load every thing and use subset to filter
df <- read.delim2(data_file_name, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

df <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')

df$Time <- strptime(paste(df$Date, df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df$Global_active_power = as.numeric(df$Global_active_power)
df$Global_reactive_power = as.numeric(df$Global_reactive_power)
df$Voltage = as.numeric(df$Voltage)
df$Global_intensity = as.numeric(df$Global_intensity)
df$Sub_metering_1 = as.numeric(df$Sub_metering_1)
df$Sub_metering_2 = as.numeric(df$Sub_metering_2)
df$Sub_metering_3 = as.numeric(df$Sub_metering_3)


png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2))

plot(df$Time, df$Global_active_power, type="l",xlab="", ylab="Global Active Power")

plot(df$Time, df$Voltage, type="l",xlab="datetime", ylab="Voltage")

plot(df$Time, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(df$Time, df$Sub_metering_2, type="l", col="red")
points(df$Time, df$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(df$Time, df$Global_reactive_power, type="l",xlab="datetime", ylab="Global_reactive_power")

dev.off();

