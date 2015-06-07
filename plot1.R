
    ##import data set
    colNAMES<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
    col.cases<-c(rep("character",2),rep("numeric",7))
    nrows<-2075260
    data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                     col.names=colNAMES, na.strings=c("NA", "?"), nrows=nrows, colClasses=col.cases)
    ##convert dates and times
    ##cbind(data, c(data$Date, data$Time))
    data=cbind.data.frame(data, paste(data$Date, data$Time))
    data$Date<-as.Date(data$Date, "%d/%m/%Y")
    
    ##get required data subset
    res<-data[which (data$Date>="2007-02-01" &  data$Date<="2007-02-02"),]
        
    res$Time<-strptime(res$Time, format="%T")
    rm(data)
png(file="Plot1.png")    
hist(res$Global_active_power, freq=T, col="red", main="Global Active Power",
     xlab="Global Active Power (killowats)")
dev.off()
