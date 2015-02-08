# Name of the file
file = "household_power_consumption.txt"

# read header and the first line
DF.row1 <- read.table(file, header = TRUE, nrow = 1, sep = ";")
nc <- ncol(DF.row1)
DF.row1

# read the column with date
DF.Date <- read.table(file, header = TRUE, as.is = TRUE, colClasses = c(NA, rep("NULL", nc - 1)), sep = ";")
head(DF.Date)

# select wanted rows
d1<- which(DF.Date$Date == "1/2/2007" | DF.Date$Date == "2/2/2007")
length(d1)

# specify classes for columns
classes <- sapply(DF.row1, class)

# read the data frame with desired dates
hpw <- read.table(file, header = FALSE, as.is = TRUE, skip = min(d1), nrow = length(d1),
                  colClasses = classes, sep = ";", na.strings = "?")
colnames(hpw)<-names(DF.row1)
head(hpw)
tail(hpw)

# Change formats of Date and Time
hpw$Date<- as.Date(hpw$Date,format="%d/%m/%Y")
hpw$DateTime<- strptime(paste(hpw$Date,hpw$Time), format = "%Y-%m-%d %H:%M:%S")

# Change setting of date formats to english
Sys.setlocale("LC_TIME", "English")

# Create plots
W = 480; H = 480;
colors <- c("black", "red", "blue")

# figure 4
with(hpw, plot(DateTime, Voltage, type = "l", xlab = "datetime"))
with(hpw, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))


png(file = "plot4.png", width = W, height = H)
par(mfrow = c(2,2))
#f1
with(hpw, plot(DateTime, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)"))
#f2
with(hpw, plot(DateTime, Voltage, type = "l", xlab = "datetime"))
#f3
with(hpw, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", 
     xlab="", col = colors[1]))
with(hpw, lines(DateTime, Sub_metering_2, type = "l", col = colors[2]))
with(hpw, lines(DateTime, Sub_metering_3, type = "l", col = colors[3]))
legend("topright", legend = nSub_metering, lty = 1, col = colors, bty = "n")
#f4
with(hpw, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()