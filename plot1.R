## plot1.R

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

##Question 1
##Have total emissions from PM2.5 decreased in the United States from
##1999 to 2008? Using the base plotting system, make a plot showing the total
##PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

total_emi <- group_by(NEI, year)
sum_emi <- summarise(total_emi, Emissions = sum(Emissions, na.rm = TRUE)/1000)

# A tibble: 4 × 2
#year Emmissions
#   <int>      <dbl>
# 1  1999   7332.967
# 2  2002   5635.780
# 3  2005   5454.703
# 4  2008   3464.206

png("plot1.png", width = 480, height = 480, units = "px")
with(sum_emi, plot(year, Emissions, type = "b",
                   ylab = "Total PM2.5 Emissions from all sources (000 tons)"))
dev.off()