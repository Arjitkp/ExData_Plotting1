library(dplyr)
library(lubridate)
if(!file.exists("Exdata")){
  dir.create("Exdata")
}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./Exdata/dataset.zip")

file_list<-unzip("./Exdata/dataset.zip")
Hnames<-tbl_df(read.table(file_list,nrows = 1,sep = ';'))
dset<-tbl_df(read.table(file_list,sep = ';', skip = 1, na.strings = "?", stringsAsFactors = FALSE))
names(dset)<-as.character(unlist(Hnames))
dset$Date<-as.Date(dset$Date, "%d/%m/%Y")
k<-as.Date("01/02/2007","%d/%m/%Y")
d1<-subset(dset,(Date == c(k)))
d2<-subset(dset,(Date==c(k+1)))
d<-rbind(d1,d2)

datetime <- strptime(paste(d$Date,d$Time,sep = " "), "%Y-%m-%d %H:%M:%S")
par(mfrow=c(2,2))

png(filename="./Exdata/plot4.png", width = 480, height = 480)

plot(datetime,d$Global_active_power,type ="l",xlab="",ylab="Golabl Active Power",cex=0.2)
plot(datetime,d$Voltage,type ="l",xlab="datetime",ylab="Voltage")
plot(datetime,d$Sub_metering_1,type ="l",xlab="",ylab="Energy sub metering")
lines(datetime,d$Sub_metering_2,type ="l", col = "red")
lines(datetime,d$Sub_metering_3,type ="l", col = "blue")

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.5)
plot(datetime,d$Global_reactive_power,type="l",ylab="Gloabl_reative_power")

dev.off()