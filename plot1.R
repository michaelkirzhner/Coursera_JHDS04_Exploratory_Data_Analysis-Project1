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
## mdata$Global_active_power <- as.numeric(mdata$Global_active_power)

## Plot histogram
dev.new()
png("./ExData_Plotting1/plot1.png", width = 480, height = 480, bg = "transparent")
hist(mdata$Global_active_power,
     xlab = "Global Active Power (killowatts)", ylab = "Frequency", main = "Global Active Power",
     col = "red", cex.axis = 0.75)
dev.off()
