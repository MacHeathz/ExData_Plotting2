# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

library(plyr)
library(dplyr)
library(ggplot2)

# Function to create the sixth plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot6 <- function (save = FALSE) {
    if ( !(exists("SCC") && exists("NEI")) ) {
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        
        SCC <- as.tbl(SCC)
        NEI <- as.tbl(NEI)
    }
    
    mv_related <- SCC %>%
        filter(grepl('Vehicle', EI.Sector))
    
    city_sums <- NEI %>%
        filter(fips == "24510" | fips == "06037") %>%
        filter(SCC %in% mv_related$SCC) %>%
        mutate(fips = ifelse(fips == "24510", "Baltimore City, MA", "Los Angeles County, CA")) %>%
        mutate(Year = factor(year)) %>%
        group_by(fips, Year) %>%
        summarise(Sums = sum(Emissions))

    plot <- ggplot(city_sums, aes(x=Year, y=Sums, group=fips, colour=fips)) +
         geom_line() +
         labs(title = expression(PM[2.5] * " emissions from MV-sources in Baltimore and LA")) +
         labs(x = "Year", y = expression(Total~emissions~of~PM[2.5]))

    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot6.png", bg = "transparent")
    print(plot)
    if (save) dev.off()
}
