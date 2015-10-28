# Code to select data omitted to comply with the requirement to not post a full 
# solution in the forums.

# sum by year by fips
byYear <- aggregate(Emissions ~ Year + fips, data = vehicle, sum)
# replace fips with label and rename it
byYear = transform(byYear, fips = as.character(factor(
    fips, levels = c("24510", "06037"), labels = c("Baltimore City", "Los Angeles County")
)))
names(byYear)[2] <- "County"
byYear <- transform(byYear, Emissions = round(Emissions)) # to be able to show rounded values in graph

# create a column of 1999 reference values
byYear$Reference <- byYear$Emissions
byYear$Reference[byYear$County == "Los Angeles County"] <-
    byYear[byYear$Year == 1999 & byYear$County == "Los Angeles County", "Emissions"]
byYear$Reference[byYear$County == "Baltimore City"] <-
    byYear[byYear$Year == 1999 & byYear$County == "Baltimore City", "Emissions"]

# I answer the question by comparing the length of the vertical line from the 
# 1999 reference to the 2008 value. I also compare the area of the respective 
# polygons bounded by the reference line and the emission values.
# Baltimore has seen more change in absolute amounts of PM2.5 emissions between 
# 1999 and 2008, but the values for Los Angeles county have been more variable 
# as shown by the larger area bounded by its polygon.
require(ggplot2)
png(filename = "plot6.png", width=1200, height=800, res=120)
print(
    ggplot(data = byYear, aes(x = Year, y = Emissions, group = County, color = County))  +
        ylab("Tons of PM2.5")  +
        ggtitle("PM2.5 Emissions From Motor Vehicle Related Sources\nBaltimore City vs Los Angeles County")  +
        geom_point(size = 3)  +
        geom_line(linetype = "solid")  +
        geom_line(aes(y = Reference), linetype = "dashed")  +
        geom_text(aes(y = Reference, label = Emissions - Reference, color = County), 
                  hjust = -0.2, vjust = -0.5, angle = 0, size = 3)  +
        geom_linerange(aes(ymin = pmin(Emissions, Reference), ymax = pmax(Emissions, Reference)),
                       linetype = "dashed", stat = "identity")  +
        scale_x_continuous(breaks = seq(1999, 2008, 3), "Year")
)
dev.off()

# Note: If you do not see the complete png, right-click on the image and select
# View Image.