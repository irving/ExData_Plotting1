# Project 1 for Coursera Exploratory Data Analysis course
# June 2015 section. 
#
# This program reads a data file, selects the small portion of it to be used
# And generates an exploratory plot from it.

library(data.table)
library(dplyr)
library(lubridate)
library(sqldf)

# Check for file before reading. It should be in the same folder
if (!file.exists("household_power_consumption.txt")){
    stop("Unable to find data file. Please place \"household_power_consumption.txt\" in the same folder as this script to run.")
}

# open the output channel
png(file="plot2.png", width=480, height=480)

# read the data
# NOTE: Assumes data are in same folder.
# NOTE: I found info about a method to read just some rows of a file
# using sqldf here: http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
# So my reading code is adapted from that.
pow <- file("household_power_consumption.txt")
attr(pow, "file.format") <- list(sep = ";", header = TRUE) 
p2 <- data.table(sqldf("select * from pow where Date == \"1/2/2007\" OR Date == \"2/2/2007\""))

# never forget to close a file when you're done with it
close(pow)
p2[,When:= dmy_hms(paste(Date, Time))]
plot(p2$When, p2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()
