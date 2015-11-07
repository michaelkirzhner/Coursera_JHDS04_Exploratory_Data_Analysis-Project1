## Initiate desired libraries
library(dplyr)
library(lubridate)

## Load data before plotting

rawdata <- read.table("./Data/household_power_consumption.txt", 
                      sep = ";", header = TRUE, na.strings = "?")

## Subset the data for the two needed dates Feb 1st and 2nd, 2007
mdata <- subset(rawdata, Date %in% c("1/2/2007", "2/2/2007"))

## Create DateTime column for and append to the dataset for analysis
mdata <- mutate(mdata, DateTime = dmy_hms(paste(mdata$Date, mdata$Time)))

## Convert Global_active_power to numeric
mdata$Global_active_power <- as.numeric(mdata$Global_active_power)

## Plot lines. To do this I add new lines as new parameters to the plot
dev.new()
png("./ExData_Plotting1/plot3.png", width = 480, height = 480)
yrange <- range(c(mdata$Sub_metering_1, mdata$Sub_metering_2, mdata$Sub_metering_3))
with(mdata, plot(DateTime, Sub_metering_1, type = "l",
                 xlab = "", ylab = "Energy sub metering", ylim = yrange, col = "black",
                 cex.axis = 0.75
                 )
    )
## Add next line to the plot
par(new = TRUE)
with(mdata, plot(DateTime, Sub_metering_2, type = "l",
                 xlab = "", ylab = "", ylim = yrange, col = "red",
                 cex.axis = 0.75
                )
    )

## Add next line to the plot
par(new = TRUE)
with(mdata, plot(DateTime, Sub_metering_3, type = "l",
                 xlab = "", ylab = "", ylim = yrange, col = "blue",
                 cex.axis = 0.75
                )
    )

## Add legend to the plot
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
dev.off()