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


# figure 2
png(file = "plot2.png", width = W, height = H)
with(hpw, plot(DateTime, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)"))
dev.off()



