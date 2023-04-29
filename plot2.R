DataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(DataURL, destfile="Electric_Power_Consumption.zip")
unzip("Electric_Power_Consumption.zip")

library(data.table)
library(dplyr)
library(lubridate)
PowerConsumption<-fread("household_power_consumption.txt", header = TRUE, na.strings = "?")
#subset February 1 and 2, 2007 (coded as '1/2/2007' and '2/1/2007' characters)
Feb1_2<-PowerConsumption[(PowerConsumption$Date == "1/2/2007" | PowerConsumption$Date == "2/2/2007"),]
rm(PowerConsumption)

#Convert the Date and Time columns into one Datetime column and rearrange table
#Took column subsets and bound new Datetime column to the data.

#add a column called datetime
Feb1_2$datetime<-dmy_hms(apply(Feb1_2[,1:2], 1, paste, collapse=" "))
#extract columns 3-9 (the data)
Feb1_2data<-Feb1_2[,3:9]
#make a character vector of the "data" column names
column.names<-names(Feb1_2data)
#cbind the Datetime column with the data (these steps get rid of the Date column and Time column)
Data<-cbind(Feb1_2$datetime, Feb1_2data)
#rename columns
names(Data)<-paste(c("Datetime", column.names))
#remove other objects to eliminate confusion
rm(column.names); rm(Feb1_2); rm(Feb1_2data)

#Plot 2
plot(Data$Datetime, Data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", lines(Data$Datetime, Data$Global_active_power), type="l")
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()





