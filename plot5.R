##read in the .rds files as a dataframes
NEI <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")
#bind the two dfs on the variable name SCC which is a factor in both dfs
library(plyr)
df <- join(NEI, SCCdata, by = "SCC")
#pull out columns of interest
library(dplyr)
df1 <- select(df, year, fips, EI.Sector, Emissions)
#remove levels not relating to motor vehicle sources 
#keep levels starting with "Mobile" in EI.Sector
df2 <- droplevels(df1[grep("Mobile", df1[ , "EI.Sector"], invert=FALSE), ]) 
#pull the rows containing Baltimore
df3 <- filter(df2, fips == "24510")
#plot the sources without certain outliers showing
png(file = "plot5.png")
with(df3, plot(year, Emissions, xlab = "Year", ylab = "PM2.5 Emitted (tons)", ylim = c(0, 15)))
title(main = "Baltimore Ambient Air Pollution from Motor Vehicles")
model <- lm(Emissions ~ year, df3)
abline(model, lwd = 4, col = "red")
dev.off()
