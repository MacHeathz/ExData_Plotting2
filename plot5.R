# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

library(dplyr)
library(ggplot2)

# Function to create the fifth plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot5 <- function (save = FALSE) {
    if ( !(exists("SCC") && exists("NEI")) ) {
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        
        SCC <- as.tbl(SCC)
        NEI <- as.tbl(NEI)
    }
    
    mv_related <- SCC %>%
        filter(grepl('Vehicle', EI.Sector))

    mv_sums <- NEI %>%
        filter(fips == "24510") %>%
        filter(SCC %in% mv_related$SCC) %>%
        mutate(Year = factor(year)) %>%
        group_by(Year) %>%
        summarise(Sums = sum(Emissions))
    
    plot <- ggplot(mv_sums, aes(x=Year, y=Sums, group=1)) +
        geom_line() +
        labs(title = expression(PM[2.5] * " emissions from motor vehicle sources in Baltimore City, MA")) +
        labs(x = "Year", y = expression(Total~emissions~of~PM[2.5]))
    
    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot5.png", bg = "transparent")
    print(plot)
    if (save) dev.off()
}
