# Project 1 for Coursera Exploratory Data Analysis course
# June 2015 section. 
#
# This program reads a data file, selects the small portion of it to be used
# And generates an exploratory plot from it.

library(data.table)
library(dplyr)
library(sqldf)
library(lubridate)

# Check for file before reading. It should be in the same folder
if (!file.exists("household_power_consumption.txt")){
    stop("Unable to find data file. Please place \"household_power_consumption.txt\" in the same folder as this script to run.")
}

# open the output device
png(file="plot3.png", width=480, height=480)

# NOTE: I found info about a method to read just some rows of a file
# using sqldf here: http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
# So my reading code is adapted from that.
# ASSUMPTION: The file to be read is in the same folder
pow <- file("household_power_consumption.txt")
attr(pow, "file.format") <- list(sep = ";", header = TRUE) 
p2 <- data.table(sqldf("select * from pow where Date == \"1/2/2007\" OR Date == \"2/2/2007\""))

# never forget to close a file when you're done with it
close(pow)

# combine date and time columns
p2[,When:= dmy_hms(paste(Date, Time))]

# set up blank plot and add as we go
plot(p2$When, p2$Global_active_power, type="n", yaxt="n",
        ylab="Energy sub metering", xlab="", ylim=c(0,40))
axis(2, at=c(0, 10, 20, 30))
lines(p2$When, p2$Sub_metering_1)
lines(p2$When, p2$Sub_metering_2, col="red")
lines(p2$When, p2$Sub_metering_3, col="blue")

# And now all that's left is the legend
# "Hither came Conan the Cimmerian, 
# black-haired, sullen-eyed, sword in hand ..."
#                               -- Robert E. Howard
# And now back to our regularly scheduled homework.
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"))

# and close the output
dev.off()
