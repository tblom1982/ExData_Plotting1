library(data.table)

powerconsumption <- as.data.table(read.csv2("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/household_power_consumption.csv"))

options(scipen = 999)

powerconsumption[, date := as.Date(Date)]

temp <- powerconsumption[Date %in% c("1/2/2007", "2/2/2007")]




temp[, Global_active_power := as.numeric(Global_active_power)]


# Convert Sub_metering_1, Sub_metering_2, and Sub_metering_3 to numeric
temp[, `:=`(Sub_metering_1 = as.numeric(Sub_metering_1), 
            Sub_metering_2 = as.numeric(Sub_metering_2), 
            Sub_metering_3 = as.numeric(Sub_metering_3))]


# Convert the Date column to the correct format (dd/mm/yyyy)
temp$Date <- as.Date(temp$Date, format="%d/%m/%Y")

# Combine 'Date' and 'Time' into a POSIXct datetime
temp$Datetime <- as.POSIXct(paste(temp$Date, temp$Time), format="%Y-%m-%d %H:%M:%S")

#open png device
png("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/plot4.png", width = 480, height = 480)  # Open PNG-device


# Set up the 2x2 grid layout
par(mfrow = c(2, 2))  # 2 rows, 2 columns

# Plot the line in black color
plot(temp$Datetime, temp$Global_active_power, 
     type = "l", col = "black", 
     xlab = "", ylab = "Global Active Power (kilowatts)", 
     xaxt = "n")  # Remove default x-axis labels

# Add custom x-axis labels for 00:00 on Thursday, Friday, and Saturday
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", 
                          "2007-02-02 00:00:00", 
                          "2007-02-03 00:00:00")), 
     labels = c("Thu", "Fri", "Sat"))





# Plot the line in black color
plot(temp$Datetime, temp$Voltage, 
     type = "l", col = "black", 
     xlab = "datetime", ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # Remove default x-axis labels

# Add custom x-axis labels for 00:00 on Thursday, Friday, and Saturday
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", 
                          "2007-02-02 00:00:00", 
                          "2007-02-03 00:00:00")), 
     labels = c("Thu", "Fri", "Sat"))








# Plot sub_metering_1, sub_metering_2, and sub_metering_3 with different colors
plot(temp$Datetime, temp$Sub_metering_1, 
     type = "l", col = "black", 
     xlab = "", ylab = "Energy Sub Metering", 
     xaxt = "n")  # Remove default x-axis labels

# Add sub_metering_2 and sub_metering_3 to the same plot
lines(temp$Datetime, temp$Sub_metering_2, col = "red")
lines(temp$Datetime, temp$Sub_metering_3, col = "blue")

# Add custom x-axis labels for 00:00 on Thursday, Friday, and Saturday
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", 
                          "2007-02-02 00:00:00", 
                          "2007-02-03 00:00:00")), 
     labels = c("Thu", "Fri", "Sat"))

# Add a legend to the plot
legend("topright", legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"), 
       col = c("black", "red", "blue"), lty = 1)







# Plot the line in black color
plot(temp$Datetime, temp$Global_reactive_power, 
     type = "l", col = "black", 
     xlab = "datetime", ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # Remove default x-axis labels

# Add custom x-axis labels for 00:00 on Thursday, Friday, and Saturday
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", 
                          "2007-02-02 00:00:00", 
                          "2007-02-03 00:00:00")), 
     labels = c("Thu", "Fri", "Sat"))


dev.off()
