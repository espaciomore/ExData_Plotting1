require(sqldf)
require(reshape2)

# Read dataset from file
hpc_df <- read.csv.sql("household_power_consumption.txt", sep = ";", "select * from file where Date in('1/2/2007','2/2/2007')")
# Combine Date an Time
hpc_df["DateTime"] <- paste(hpc_df$Date, hpc_df$Time)
hpc_df <- hpc_df[,!(colnames(hpc_df) %in% c("Date","Time"))]
hpc_df <- transform(hpc_df, DateTime=strptime(hpc_df$DateTime,format="%d/%m/%Y %H:%M:%S"))

# Create Plot
png(file="plot3.png",width=480,height=480)
plot(hpc_df$DateTime, hpc_df$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering (watt-hour)")
 lines(hpc_df$DateTime, hpc_df$Sub_metering_2, col = "red")
 lines(hpc_df$DateTime, hpc_df$Sub_metering_3, col = "blue")
 sub_meterings <- colnames(hpc_df)[grepl("Sub_metering_[0-9]", colnames(hpc_df))]
 legend(x = "topright", legend = sub_meterings, lty = 1, col = c("black", "red", "blue"))
dev.off()
