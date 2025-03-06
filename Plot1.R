library(data.table)

powerconsumption <- as.data.table(read.csv2("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/household_power_consumption.csv"))

options(scipen = 999)

powerconsumption[, date := as.Date(Date)]

temp <- powerconsumption[Date %in% c("1/2/2007", "2/2/2007")]



temp[, Global_active_power := as.numeric(Global_active_power)]


#open png device
png("C:/Users/tblo/OneDrive - Gemeente 's-Hertogenbosch/R-kopieën/plot1111.png", width = 480, height = 480)  # Open PNG-device

#making the histogram
hist(temp$Global_active_power, 
     main = "Global Active Power", #adjusting the main title
     col = "red", #adjusting the color of the bars
     xlab = "Global Active Power (kilowatts)") #adjusting the title of the x-axis


#close png-device and save image
dev.off()  
