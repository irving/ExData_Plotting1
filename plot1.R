# Project 1 for Coursera Exploratory Data Analysis course
# June 2015 section. 
#
# This program reads a data file, selects the small portion of it to be used
# And generates an exploratory plot from it.

library(data.table)
library(dplyr)
library(sqldf)

# Check for file before reading. It should be in the same folder
if (!file.exists("household_power_consumption.txt")){
    stop("Unable to find data file. Please place \"household_power_consumption.txt\" in the same folder as this script to run.")
}

# open the output channel
png(file="plot1.png", width=480, height=480)

# NOTE: I found info about a method to read just some rows of a file
# using sqldf here: http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
# So my reading code is adapted from that.
pow <- file("household_power_consumption.txt")
attr(pow, "file.format") <- list(sep = ";", header = TRUE) 
p2 <- data.table(sqldf("select * from pow where Date == \"1/2/2007\" OR Date == \"2/2/2007\""))

# never forget to close a file when you're done with it
close(pow)
# set font small so the labels will fit
par(ps=10)

# make the main plot without axes, which will be added after
hist(as.numeric(p2$Global_active_power), xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col="red", axes = FALSE)

# Add the axes
axis(1, at=c(0, 2, 4, 6), labels=c("0", "2", "4", "6"))
axis(2, at=c(0, 200, 400, 600, 800, 1000, 1200), 
     labels= c("0", "200", "400", "600", "800", "1000", "1200"))

# and finalize the export 
dev.off()
