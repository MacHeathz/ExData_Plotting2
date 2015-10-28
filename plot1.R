# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(data.table)
library(dplyr)

# Function to create the first plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot1 <- function (save = FALSE) {
    if (!exists("NEI")) {
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        NEI <- as.tbl(as.data.table(NEI, key = "year"))
    }

    # total_sums <- NEI[ ,Year:=factor(year) ][ ,Sums:=(sum(Emissions)/1e+06),by=Year ][, c(Year,Sums)]
        
    total_sums <- NEI %>%
            mutate(Year = factor(year)) %>%
            group_by(Year) %>%
            summarise(Sums = (sum(Emissions) / 1e+06))
#                   (To make the values more readable, we divide by 1 mln)

    
    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot1.png", bg = "transparent")
    with(total_sums, barplot(Sums,
                         xlab = "Year",
                         ylab = expression(Total~emissions~of~PM[2.5] * " (x 1 Mln)"),
                         main = "Total emissions in the US"))
    
    # Put the labels on the X axis
    axis(1, at = c(1:4), labels = c("1999", "2002", "2005", "2008"))
    
    if (save) dev.off()
}
