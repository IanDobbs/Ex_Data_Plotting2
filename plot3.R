## plot3.R

## locate and download the dataset
fileurl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl, destfile = "NEI.zip")
unzip("NEI.zip")

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## run str() to understand the structure and classes of the data
str(NEI)
##'data.frame':	6497651 obs. of  6 variables:
##$ fips     : chr  "09001" "09001" "09001" "09001" ...
##$ SCC      : chr  "10100401" "10100404" "10100501" "10200401" ...
##$ Pollutant: chr  "PM25-PRI" "PM25-PRI" "PM25-PRI" "PM25-PRI" ...
##$ Emissions: num  15.714 234.178 0.128 2.036 0.388 ...
##$ type     : chr  "POINT" "POINT" "POINT" "POINT" ...
##$ year     : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...

library(dplyr)
library(ggplot2)

##Question 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, which of these four sources have seen decreases in emissions from 1999–2008
#for Baltimore City? Which have seen increases in emissions from 1999–2008?
#Use the ggplot2 plotting system to make a plot answer this question.

baltimore <- filter(NEI, fips == "24510")
total_emi <- group_by(baltimore, year, type)
sum_emi <- summarise(total_emi, Emissions = sum(Emissions, na.rm = TRUE))

png("plot3.png", width = 480, height = 480, units = "px")
ggplot(sum_emi, aes(year, Emissions)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ type, scales = "free_y", nrow = 2) +
  ylab("Total PM2.5 Emissions (tons)") +
  xlab("Year")
dev.off() 