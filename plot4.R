# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

library(dplyr)
library(ggplot2)

# Function to create the fourth plot. If argument `save` is set to TRUE, a png
# file 'plot6.png' is created containing the plot. Otherwise the plot is just
# shown on the screen device.
plot4 <- function (save = FALSE) {
    if ( !(exists("SCC") && exists("NEI")) ) {
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        
        SCC <- as.tbl(SCC)
        NEI <- as.tbl(NEI)
    }
    
    coal_related <- SCC %>%
        filter(grepl('Fuel Comb', EI.Sector)) %>%
        filter(grepl('Coal', EI.Sector))
        
    coal_sums <- NEI %>%
        filter(SCC %in% coal_related$SCC) %>%
        mutate(Year = factor(year)) %>%
        group_by(Year) %>%
        summarise(Sums = sum(Emissions)) %>%
    
        # To make the values more human readable, let's divide by 1,000
        mutate(Sums = Sums / 1e+03) 
        
    plot <- ggplot(coal_sums, aes(x=Year, y=Sums, group=1)) +
        geom_line() +
        labs(title = expression("Coal combustion-related " * PM[2.5] * " emissions in the US")) +
        labs(x = "Year", y = expression(Total~emissions~of~PM[2.5] * " (x 1,000)"))

    # PNG file creation, create a png file if argument save = TRUE
    if (save) png(file = "plot4.png", bg = "transparent")
    print(plot)
    if (save) dev.off()
}
