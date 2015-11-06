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

df <- read.delim2(data_file_name, header=TRUE, sep=";", stringsAsFactors=FALSE,dec=".")

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

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(df$Time, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off();

