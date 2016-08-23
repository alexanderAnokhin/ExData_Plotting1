# set locale
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# get subset of data
library(lubridate)
library(dplyr)
subset <- tbl_df(read.csv("household_power_consumption.txt", sep=";")) %>%
  mutate(DateTime = dmy_hms(paste(Date, Time))
         ,Sub_metering_1 = as.numeric(as.character(Sub_metering_1))
         ,Sub_metering_2 = as.numeric(as.character(Sub_metering_2))
         ,Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") & DateTime < ymd_hms("2007-02-03 00:00:00")) %>%
  select(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# make a plot
png(filename = "new figure/plot3.png", width = 480, height = 480)
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
legend("topright", paste("Sub_metering_", 1:3), lty=1, col = c("black", "red", "blue"))
dev.off()