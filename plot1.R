require(sqldf)
require(reshape2)

# Read dataset from file
hpc_df <- read.csv.sql("household_power_consumption.txt", sep = ";", "select * from file where Date in('1/2/2007','2/2/2007')")
# Combine Date an Time
hpc_df["DateTime"] <- paste(hpc_df$Date, hpc_df$Time)
hpc_df <- hpc_df[,!(colnames(hpc_df) %in% c("Date","Time"))]
hpc_df <- transform(hpc_df, DateTime=strptime(hpc_df$DateTime,format="%d/%m/%Y %H:%M:%S"))

# Create Plot
png(file="plot1.png",width=480,height=480)
hist(hpc_df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
