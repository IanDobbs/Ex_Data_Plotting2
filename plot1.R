## plot1.R

## locate and download the dataset
fileurl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl, destfile = "NEI.zip")
unzip("NEI.zip")