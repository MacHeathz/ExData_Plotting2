# Load the data, but only if the dataframes are not loaded yet (I don't like
# waiting unnecessarily).
if ( !(exists("SCC") && exists("NEI")) ) {
    SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")

    SCC <- as.tbl(SCC)
    NEI <- as.tbl(NEI)
}

plotAll <- function (save = TRUE) {
    source('plot1.R')
    plot1(save)
    source('plot2.R')
    plot2(save)
    source('plot3.R')
    plot3(save)
    source('plot4.R')
    plot4(save)
    source('plot5.R')
    plot5(save)
    source('plot6.R')
    plot6(save)
}

### Questions
# 
# You must address the following questions and tasks in your exploratory
# analysis. For each question/task you will need to make a single plot. Unless
# specified, you can use any plotting system in R to make your plot.
# 
# (see plot files)
#

### Making and Submitting Plots
# 
# For each plot you should
# 
#  1. Construct the plot and save it to a PNG file.
# 
#  2. Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the
#     corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your
#     code file should include code for reading the data so that the plot can be
#     fully reproduced. You must also include the code that creates the PNG file.
#     Only include the code for a single plot (i.e. plot1.R should only include
#     code for producing plot1.png)
# 
#  3. Upload the PNG file on the Assignment submission page
# 
#  4. Copy and paste the R code from the corresponding R file into the text box at
#     the appropriate point in the peer assessment.
#