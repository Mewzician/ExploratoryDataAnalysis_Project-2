##read in the .rds file as a dataframe
NEI <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")
#bind the two dfs on the variable name SCC which is a factor in both dfs
library(plyr)
df <- join(NEI, SCCdata, by = "SCC")
#pull out the columns of interest
library(dplyr)
df1 <- select(df, year, EI.Sector, Emissions)
#pull coal combustion-related sources from the Emissions Inventory sector (EI.Sector) variable
df2 <- filter(df1, EI.Sector == 
             c("Fuel Comb - Comm/Institutional - Coal", 
               "Fuel Comb - Electric Generation - Coal", 
               "Fuel Comb - Industrial Boilers, ICEs - Coal"))
#plot the sources without certain outliers showing
png(file = "plot4.png")
library(ggplot2)
qplot(year, Emissions, data = df2, color = EI.Sector, 
      ylim = c(0, 7500),
      xlab = "Year", ylab = "PM2.5 Emitted (tons)",
      main = "US Ambient Air Pollution from Coal Combustion")
dev.off()
