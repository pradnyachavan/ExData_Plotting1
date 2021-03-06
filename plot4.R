library("lubridate")
house<- read.table("./data/household_power_consumption.txt",header = TRUE,stringsAsFactors = FALSE,sep=";")
house_frame<-data.frame(house)
house_frame2<-subset(house_frame,  house_frame$Date =="2/2/2007" | house_frame$Date == "1/2/2007") 
nrow(house_frame2)

house_frame3<-transform(house_frame2, Global_active_power=as.numeric(Global_active_power),
                        Global_reactive_power=as.numeric(Global_reactive_power),
                        Voltage =as.numeric(Voltage),
                        Global_intensity =as.numeric(Global_intensity),
                        Sub_metering_1 =as.numeric(Sub_metering_1),
                        Sub_metering_2 =as.numeric(Sub_metering_2),
                        Sub_metering_3 =as.numeric(Sub_metering_3))
house_frame3$date_time<-paste(house_frame3$Date, house_frame3$Time)
house_frame3[order(house_frame3$date_time),]
house_frame3$date_time2<-dmy_hms(house_frame3$date_time)
house_frame3[order(house_frame3$date_time2),]
##Plot4
par(mfrow=c(2,2),mar=c(5, 4, 0.7, 2),cex.lab=0.5, cex.axis=0.7)
plot(house_frame3$date_time2,house_frame3$Global_active_power,type="n", 
     ylab = "Global Active Power (kilowatts)",xlab=" ")
lines(house_frame3$date_time2,house_frame3$Global_active_power)

plot(house_frame3$date_time2,house_frame3$Voltage,type="n", 
     ylab = "Voltage",xlab="datetime")
lines(house_frame3$date_time2,house_frame3$Voltage)


plot(house_frame3$date_time2,house_frame3$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(house_frame3$date_time2,house_frame3$Sub_metering_2,col="red")
lines(house_frame3$date_time2,house_frame3$Sub_metering_3,col="blue")
lines(house_frame3$date_time2,house_frame3$Sub_metering_1,col="black")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1), col=c("black","red","blue"), cex = 0.5,  bty = "n")

plot(house_frame3$date_time2,house_frame3$Global_reactive_power,type="n",
     ylab = "Global_reactive_power",xlab="datetime")
lines(house_frame3$date_time2,house_frame3$Global_reactive_power)

dev.copy(png, file="./data/plot4.png", width = 480, height = 480)
dev.off()
##Plot4