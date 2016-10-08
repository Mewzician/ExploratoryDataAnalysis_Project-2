##read in the .rds file as a dataframe
NEI <- readRDS("summarySCC_PM25.rds")
#pull out columns of interest
library(dplyr)
df1 <- select(NEI, year, Emissions, fips)
df2 <- filter(df1, fips == "24510")
#plot data without certain outliers showing
png(file = "plot2.png")
plot(df2$year, df2$Emissions, ylim = c(0, 400), 
     xlab = "Year",
     ylab = "PM2.5 Emitted (tons)", 
     main = "Ambient Air Pollution in Baltimore")
model <- lm(Emissions ~ year, df2)
abline(model, lwd = 4, col = "red")
dev.off()