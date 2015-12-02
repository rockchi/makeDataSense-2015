library(dplyr)
library(lubridate)

#
bl1997 <- read.csv("csv/1997business_licences.csv", strip.white = TRUE)

#Factor Variables that needs to be converted to Character
#For loop also inputs NA for blanks
VarFactors <- c(1,2, 4,5,7, 8, 10,11,12,13,14,15,16,17,18,19, 24)
for(i in seq(length(VarFactors))){
  ColumnSelect <- VarFactors[i]
  bl1997[,ColumnSelect] <- as.character(bl1997[,ColumnSelect])
  bl1997[,ColumnSelect][bl1997[,ColumnSelect]==""] <- NA
}
rm(i)
rm(VarFactors)
rm(ColumnSelect)

#Date-Time Conversion
bl1997$IssuedDate <- as.POSIXct(bl1997$IssuedDate, format="%Y-%m-%d %H:%M:%S")
bl1997$ExpiredDate <- as.POSIXct(bl1997$ExpiredDate, format="%Y-%m-%d %H:%M:%S")
bl1997$ExtractDate <- as.POSIXct(bl1997$ExpiredDate, format="%Y-%m-%d")

#Year Variable Creation
bl1997$Year <- as.POSIXct("1997-01-01", format="%Y-%m-%d")

db <- rbind(db, bl1997)
rm(bl1997)
