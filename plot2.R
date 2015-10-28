# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

library(dplyr)

# Function to create the second plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot2 <- function (save = FALSE) {
    if ( !(exists("SCC") && exists("NEI")) ) {
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        
        SCC <- as.tbl(SCC)
        NEI <- as.tbl(NEI)
    }
    
    Baltimore_sums <- NEI %>%
         filter(fips == "24510") %>%
         mutate(Year = factor(year)) %>%
         group_by(Year) %>%
         summarise(Sums = sum(Emissions))

    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot2.png", bg = "transparent")
    with(Baltimore_sums, plot(Year, Sums,
                         xlab = "Year",
                         ylab = expression(Total~emissions~of~PM[2.5]),
                         main = "Total emissions in Baltimore, MA"))
    if (save) dev.off()
}
