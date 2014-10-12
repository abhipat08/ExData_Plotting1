#get data
library(data.table)
#geturl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(geturl, destfile = "exdata-data-household_power_consumption.zip")
#unzip("exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#clean the date and get its numeric value for subsetting
data[,"Date"] <- as.Date(data[,"Date"],"%d/%m/%Y")
data$nDate <- as.numeric(data$Date)

#subset only the required date range using data.table
data2 <- data.table(data)
a <- as.numeric(as.Date("2007-02-01"))
b <- as.numeric(as.Date("2007-02-02"))
data3 <- data2[nDate>=a & nDate<=b,]

#Create a date and time column & format into proper date
data3 <- data.frame(data3)
data3[,"Date3"] <- paste( data3[,"Date"], data3[,"Time"], sep = " ")
Date2 <- strptime(data3[,"Date3"], format = "%Y-%m-%d %H:%M:%S")
data4 <- cbind(data3,Date2)

#convert columns into proper numeric variable for graphing
data4$Global_active_power <- as.numeric(as.character(data4$Global_active_power))
data4$Voltage <- as.numeric(as.character(data4$Voltage))
data4$Global_reactive_power <- as.numeric(as.character(data4$Global_reactive_power))
data4$Sub_metering_1 <- as.numeric(as.character(data4$Sub_metering_1))
data4$Sub_metering_2 <- as.numeric(as.character(data4$Sub_metering_2))
data4$Sub_metering_3 <- as.numeric(as.character(data4$Sub_metering_3))




#Assign4
png(filename="plot4.png", height=480, width=480)
par(mfrow= c(2,2))

plot(data4$Date2,data4$Global_active_power, type = "n",xlab="", 
     ylab="Global Active Power")
lines(data4$Date2, data4$Global_active_power, col = "black")

plot(data4$Date2,data4$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(data4$Date2, data4$Voltage, col = "black")

plot(data4$Date2, data4$Sub_metering_1, type = "n", xlab="", 
     ylab="Energy sub metering")
lines(data4$Date2, data4$Sub_metering_1, col = "black")
lines(data4$Date2, data4$Sub_metering_2, col = "red")
lines(data4$Date2, data4$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")

plot(data4$Date2,data4$Global_reactive_power, type = "n", xlab = "datetime", 
     ylab = "Global_reactive_power")
lines(data4$Date2, data4$Global_reactive_power, col = "black")
dev.off()