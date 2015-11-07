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
png("./ExData_Plotting1/plot4.png", width = 480, height = 480)

## Setting the graphic devices to have a matrix of plots of 2 by 2
par(mfrow = c(2,2))

yrange <- range(c(mdata$Sub_metering_1, mdata$Sub_metering_2, mdata$Sub_metering_3))
with(mdata, {
      ## Position 1,1
      plot( DateTime, Global_active_power, type = "l",
            xlab = "",
            ylab = "Global Active Power (killowatts)",
            cex.axis = 0.75
          )
      
      ## Position 1,2
      plot( DateTime, Voltage, type = "l",
            xlab = "datetime",
            ylab = "Voltage",
            cex.axis = 0.75
          )
      
      ## Position 2,1
      plot(DateTime, Sub_metering_1, type = "l",
           xlab = "", ylab = "Energy sub metering", ylim = yrange, col = "red",
           cex.axis = 0.75
      )
      par(new = TRUE)
      ## Add next line to the plot
      plot(DateTime, Sub_metering_2, type = "l",
          xlab = "", ylab = "", ylim = yrange, col = "red",
          cex.axis = 0.75
          )
      ## Add next line to the plot
      par(new = TRUE)
      plot(DateTime, Sub_metering_3, type = "l",
          xlab = "", ylab = "", ylim = yrange, col = "blue",
          cex.axis = 0.75
          )
      ## Add legend to the plot
      legend("topright",
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
              lty = c(1,1,1),
              col = c("black", "red", "blue")
            )
      
      ## Position 2,2
      plot( DateTime, Global_reactive_power, type = "l",
            xlab = "datetime",
            ylab = "Global_reactive_power",
            cex.axis = 0.75
      )
  }
)
dev.off()