##import data set
colNAMES<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
            "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
col.cases<-c(rep("character",2),rep("numeric",7))
nrows<-2075260
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                 col.names=colNAMES, na.strings=c("NA", "?"), nrows=nrows, colClasses=col.cases)
##convert dates and times
data$datetime= paste(data$Date, data$Time)
data$Date<-as.Date(data$Date, "%d/%m/%Y")
##get required data subset
res<-data[which (data$Date>="2007-02-01" &  data$Date<="2007-02-02"),]
#clearning data
res<-res[complete.cases(res),]
##convert to OSIXlt format
res$datetime<-strptime(res$datetime, format="%d/%m/%Y %H:%M:%S")

##making plot
png(file="Plot4.png") 

par(mfrow = c(2, 2))
##plot1
plot (res$datetime,res$Global_active_power, type="l", xlab="", ylab="Global active power (killowats)", main="")
#plot2
plot (res$datetime,res$Voltage, type="l", xlab="datatime", ylab="Voltage", main="")
#plot3
##empty plot
plot (res$datetime, res$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
##adding lines
lines(res$datetime, res$Sub_metering_1, col="black")
lines(res$datetime, res$Sub_metering_2, col="red")
lines(res$datetime, res$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=1)
##plot 4
plot (res$datetime,res$Global_reactive_power, type="l", xlab="datatime", ylab="Global_reactive_power", main="")


dev.off()