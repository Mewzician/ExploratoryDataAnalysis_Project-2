##read in the .rds files as a dataframes
NEI <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")
#bind the two dfs on the variable name SCC which is a factor in both dfs
library(plyr)
df <- join(NEI, SCCdata, by = "SCC")
#pull out the rows of Baltimore and Los Angeles
library(dplyr)
df1 <- select(df, year, fips, EI.Sector, Emissions)
#remove levels not relating to motor vehicle sources 
#keep levels starting with "Mobile" in EI.Sector
df2 <- droplevels(df1[grep("Mobile", df1[ , "EI.Sector"], invert=FALSE), ]) 
#pull the rows containing the two cities
df3 <- filter(df2, fips == c("24510", "06037"))
#'data.frame':	1950 obs. of  4 variables:

#create a subset df for each city
Baltimore <- subset(df3, fips=="24510")
LosAngeles <- subset(df3, fips=="06037")

png(file = "plot6.png")
#create blank plot for the sources without certain outliers showing
plot(df3$year, df3$Emissions, type = "n", ylim = c(0, 45),
     xlab = "Year", ylab = "PM2.5 Emitted (tons)",
     main = "Ambient Air Pollution from Motor Vehicles")
#create regression lines for each city and a legend
model <- lm(Emissions ~ year, Baltimore)
abline(model, lwd = 4, col = "blue")
model2 <- lm(Emissions ~ year, LosAngeles)
abline(model2, lwd = 4, col = "green")
legend("topright", lwd = 4, col = c("blue", "green"), legend = c("Baltimore", "Los Angeles"))
dev.off()
