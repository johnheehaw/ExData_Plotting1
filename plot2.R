# have already downloaded to local dir and limit to dates 2007-02-01 and 2007-02-02
# filtering is done via sqldf package
setwd("~/Google Drive/School/coursera/SigTrac4 - EDA/Assignment1")
library(sqldf)
hpc_raw <- read.csv.sql("~/Google Drive/School/coursera/SigTrac4 - EDA/Assignment1/household_power_consumption.txt", sep=";", header = TRUE, sql = "select * from file where Date in('1/2/2007','2/2/2007')")

# process date and time into single DateTime field, cbind it to dataset
newDate <- as.character(hpc_raw$Date)
newTime <- as.character(hpc_raw$Time)
newDateTime <- paste(newDate,newTime)
DateTime <- strptime(newDateTime, "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc_raw,DateTime)

# graph 2 - Global_active_power by date/time
png(filename = "plot2.png",width = 480, height = 480)
plot(hpc$DateTime,hpc_new$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()