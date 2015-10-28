# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot to
# answer this question.

library(dplyr)
library(ggplot2)

# Function to create the third plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot3 <- function (save = FALSE) {
    if ( !(exists("SCC") && exists("NEI")) ) {
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        
        SCC <- as.tbl(SCC)
        NEI <- as.tbl(NEI)
    }
    
    type_sums <- NEI %>%
        filter(fips == "24510") %>% # Baltimore City
        mutate(Year = factor(year)) %>%
        group_by(type, Year) %>%
        summarise(Sums = sum(Emissions))
    
    # Use ggplot to create one plot for each type showing a line with
    # the increase/decrease per year
    plot <- ggplot(type_sums, aes(x=Year, y=Sums, group=1)) +
            geom_line() +
            facet_grid(type ~ .) +
            labs(y = expression(Total~emissions~of~PM[2.5]), x = "Year") +
            labs(title = expression(Total~emissions~of~PM[2.5]~per~source~type~per~year))
    
    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot3.png", bg = "transparent")
    print(plot)
    if (save) dev.off()
}
