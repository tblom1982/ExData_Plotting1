library(data.table)

powerconsumption <- as.data.table(read.csv2("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/household_power_consumption.csv"))

options(scipen = 999)


temp <- powerconsumption[Date %in% c("1/2/2007", "2/2/2007")]



temp[, Global_active_power := as.numeric(Global_active_power)]



# Convert the Date column to the correct format (dd/mm/yyyy)
temp$Date <- as.Date(temp$Date, format="%d/%m/%Y")

# Combine 'Date' and 'Time' into a POSIXct datetime
temp$Datetime <- as.POSIXct(paste(temp$Date, temp$Time), format="%Y-%m-%d %H:%M:%S")

#open png device
png("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/plot2.png", width = 480, height = 480)  # Open PNG-device

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

#close png-device and save image
dev.off()  
