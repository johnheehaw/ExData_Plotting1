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

# graph 4 - 2x2 
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

#1 upper left
plot(hpc$DateTime,hpc_new$Global_active_power,type="l",ylab="Global Active Power",xlab="")

#2 upper right
with(hpc,plot(DateTime,Voltage,type="l",ylab="Voltage",xlab="datetime")) 

#3 lower left
with(hpc,{
        plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
        points(DateTime,Sub_metering_2,col="red",type="l")
        points(DateTime,Sub_metering_3,col="blue",type="l")
        legend("topright",bty="n",col=c("black","red","blue"),lwd=.5,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

#4 lower right
with(hpc,plot(DateTime,Global_reactive_power,type="l",xlab="datetime")) 

dev.off()