# set locale
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# get subset of data
library(lubridate)
library(dplyr)
subset <- tbl_df(read.csv("household_power_consumption.txt", sep=";")) %>%
  mutate(DateTime = dmy_hms(paste(Date, Time))
         ,Global_active_power = as.numeric(as.character(Global_active_power))) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") & DateTime < ymd_hms("2007-02-03 00:00:00")) %>%
  select(Global_active_power, DateTime)

# make a plot
png(filename = "new figure/plot2.png", width = 480, height = 480)
plot(subset$DateTime
     ,subset$Global_active_power
     ,xlab=NA
     ,ylab="Global Active Power (kilowatts)"
     ,type="l")
dev.off()