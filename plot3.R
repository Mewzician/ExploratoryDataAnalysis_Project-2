##read in the .rds file as a dataframe
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
#convert the df to a dataframetable
df1 <- tbl_df(NEI)  #MAYBE THIS STEP ISN'T NECESSARY?
#pull out columns of interest
df2 <- select(df1, year, Emissions, fips, type)
#convert variable "type" to factor
df2 <- transform(df2, type = factor(type))
#pull out rows of interest
df3 <- filter(df2, fips == "24510")
#organize by type
df4 <- group_by(df3, type)
#plot 4 panels by type without certain outliers showing
png(file = "plot3.png")
library(ggplot2)
g <- ggplot(df4, aes(year, Emissions))
g + geom_point() + 
    geom_smooth(method = "lm") + 
    facet_grid(. ~ type) + 
    labs(x = "Year", y = "PM2.5 Emitted (tons)") +
    coord_cartesian(ylim = c(0, 400)) +
    ggtitle("Types of Ambient Air Pollution in Baltimore (1999-2008)")
dev.off()
