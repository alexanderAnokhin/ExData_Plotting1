# set locale
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# get subset of data
library(lubridate)
library(dplyr)
subset <- tbl_df(read.csv("household_power_consumption.txt", sep=";")) %>%
  mutate(DateTime = dmy_hms(paste(Date, Time))
         ,Global_active_power = as.numeric(as.character(Global_active_power))
         ,Global_reactive_power = as.numeric(as.character(Global_reactive_power))
         ,Voltage = as.numeric(as.character(Voltage))
         ,Sub_metering_1 = as.numeric(as.character(Sub_metering_1))
         ,Sub_metering_2 = as.numeric(as.character(Sub_metering_2))
         ,Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") & DateTime < ymd_hms("2007-02-03 00:00:00")) %>%
  select(-Global_intensity, -Date, -Time)

# make plots
png(filename = "new figure/plot4.png", width = 480, height = 480)
par(mfrow=c(2, 2))

# first plot
plot(subset$DateTime
     ,subset$Global_active_power
     ,xlab=NA
     ,ylab="Global Active Power"
     ,type="l")

# second plot
plot(subset$DateTime
     ,subset$Voltage
     ,xlab="datetime"
     ,ylab="Voltage"
     ,type="l")

# third plot
plot(subset$DateTime
     ,subset$Sub_metering_1
     ,xlab=NA
     ,ylab="Energy sub metering"
     ,type="l")
lines(subset$DateTime
      ,subset$Sub_metering_2
      ,type="l"
      ,col="red")
lines(subset$DateTime
      ,subset$Sub_metering_3
      ,type="l"
      ,col="blue")
legend("topright", paste("Sub_metering_", 1:3), lty=1, col = c("black", "red", "blue"), bty = "n")

# forth plot
plot(subset$DateTime
     ,subset$Global_reactive_power
     ,xlab="datetime"
     ,ylab="Global_reactive_power"
     ,type="l")
dev.off()