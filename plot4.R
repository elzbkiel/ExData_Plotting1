plot4 <- function() {
    ## This assignment uses data from the UC Irvine Machine Learning Repository
    ## Dataset: Electric power consumption [20Mb]
    ## Description: Measurements of electric power consumption in one household with a one-minute sampling 
    ## rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
    
    ## The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
    
    ## 1. Date: Date in format dd/mm/yyyy
    ## 2. Time: time in format hh:mm:ss
    ## 3. Global_active_power: household global minute-averaged active power (in kilowatt)
    ## 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
    ## 5. Voltage: minute-averaged voltage (in volt)
    ## 6. Global_intensity: household global minute-averaged current intensity (in ampere)
    ## 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
    ##    It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave 
    ##    (hot plates are not electric but gas powered).
    ## 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
    ##    It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
    ## 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
    ##    It corresponds to an electric water-heater and an air-conditioner.
    
    ## Download zip file
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./data/z.zip", method = "curl")
    unzip(zipfile = "./data/z.zip", exdir = "./data")
    myfile <- "./data/household_power_consumption.txt"
    
    ## Read only a subsdet of data from the file
    tb <- read.table(text = grep("^[1,2]/2/2007", readLines(myfile), value = TRUE),
                     col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                                   "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                     header = TRUE, sep = ";", na = "?")  ## dim tb 2879
    
    ## Combine Date and Time => POSIXlt format
    tb$DateTime <- strptime(paste(tb$Date, tb$Time), "%d/%m/%Y %H:%M:%S")
    
    ## Four plots in one file
    plot.new()   ## reset par()
    png("plot4.png", width = 480, height = 480)  ## px is the default unit
    
    ## Set par() to 2,2
    par(mfrow = c(2,2))
    
    ## First plot
    plot(tb$DateTime,
         tb$Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power")
    
    ## Second plot
    plot(tb$DateTime,
         tb$Voltage,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    
    ## Third plot
    plot(tb$DateTime,
         tb$Sub_metering_1,
         type = "l",
         xlab = "",
         ylab = "Energy sub metering",
         col = "black")
    
    lines(tb$DateTime,
          tb$Sub_metering_2,
          col = "red")
    
    lines(tb$DateTime,
          tb$Sub_metering_3,
          col = "blue")
    
    legend("topright",
           col = c("black", "red", "blue"),
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = 1)
    
    ## Fourth plot
    plot(tb$DateTime,
         tb$Global_reactive_power,
         type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")
    
    dev.off()
    return(paste("See plot4.png in ", getwd()))
    
}