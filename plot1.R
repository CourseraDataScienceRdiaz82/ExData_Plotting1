#Data Source
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Download the data files and extract the dataset files
download.file(url,"temp.zip",method="curl")
unzip("temp.zip",exdir = "./")
file.remove("temp.zip")