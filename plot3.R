#Data Source
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<-"household_power_consumption.txt"

#Download the data files and extract the dataset files
download.file(url,"temp.zip",method="curl")
unzip("temp.zip",exdir = "./")
file.remove("temp.zip")

#Load the raw dataset and subset only for desired dates.
rawDataset<-read.table(filename,header = TRUE, sep = ";", na.strings = "?")
desiredDataset<-subset(rawDataset, Date=="1/2/2007" | Date=="2/2/2007")
rm(rawDataset)

#Create only one colum for timestamp.
desiredDataset<- within(desiredDataset, { Timestamp=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S") })

#Delete the Date and Time Column and reorder the Timestamp to be the first column.
desiredDataset<-subset(desiredDataset, select=-c(Date,Time))
desiredDataset <- desiredDataset[colnames(desiredDataset)[c(8,1:7)]]

#plot line graph for Energy submetering 1
plot(desiredDataset$Timestamp,desiredDataset$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering", 
     type = "l")

#plot line graph for Energy submetering 2
points(desiredDataset$Timestamp,desiredDataset$Sub_metering_2, 
       col="red", 
       type = "l")

#plot line graph for Energy submetering 2
points(desiredDataset$Timestamp,desiredDataset$Sub_metering_3, 
       col="blue", 
       type = "l")
#define plot legend
legend("topright", legend=c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "), 
       lwd=1, 
       col=c("black", "red", "blue"))

#Save the plot to a png file
dev.copy(png,file="plot3.png", width=480,height=480)
dev.off()