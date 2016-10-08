##read in the .rds file as a dataframe
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
#pull out columns of interest
df1 <- select(NEI, year, Emissions)
#plot data without certain outliers showing
png(file = "plot1.png")
plot(df1$year, df1$Emissions, ylim = c(0, 60000), 
     xlab = "Year",
     ylab = "PM2.5 Emitted (tons)",
     main = "Ambient Air Pollution in the USA")
model <- lm(Emissions ~ year, df1)
abline(model, lwd = 4, col = "red")
dev.off()
