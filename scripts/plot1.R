# set locale
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# get subset of data
library(lubridate)
library(dplyr)
subset <- tbl_df(read.csv("household_power_consumption.txt", sep=";")) %>%
  mutate(Date = dmy(Date)
         ,Global_active_power = as.numeric(as.character(Global_active_power))) %>%
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>%
  select(Global_active_power)

# make a plot
png(filename = "new figure/plot1.png", width = 480, height = 480)
hist(subset$Global_active_power
     ,xlab="Global Active Power (kilowatts)"
     ,col="red"
     ,main="Global Active Power")
dev.off()