plot1 <- function() {
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
    
    ## Read all the data, use colClasses to make it faster but this is still very slow!
    ## tab10rows <- read.table(myfile, header = TRUE, sep = ";", nrows = 10)
    ## classes <- sapply(tab10rows, class)
    ## tabAll <- read.table(myfile, header = TRUE, sep = ";", colClasses = classes, na = "?")
    ## Convert Date factors using as.Date
    ## tabAll$Date <- as.Date(strptime(tabAll$Date, "%d/%m/%Y"),"%Y-%m-%d")
    ## Subset "2007-02-01", "2007-02-02"
    ## tab1 <- subset(tabAll, tabAll$Date %in% as.Date(c("2007-02-01", "2007-02-02")))
    
    ## Read only a subsdet of data from the file
    tb <- read.table(text = grep("^[1,2]/2/2007", readLines(myfile), value = TRUE),
                    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                                "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                    header = TRUE, sep = ";", na = "?")  ## dim tb 2879
    
    ## Plot histogram as png file
    plot.new()   ## reset par()
    png("plot1.png", width = 480, height = 480)  ## px is the default unit
    
    hist(tb$Global_active_power,
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)",
         ylab="Frequency",
         col="red")
    
    dev.off()
    
    return(paste("See plot1.png in ", getwd()))
    
}