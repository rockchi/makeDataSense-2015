library(dplyr)
library(lubridate)
library(rCharts)
#CIS Type Merge
CIS <- read.csv("CISType.csv")
CIS$Var1 <- as.character(CIS$Var1)
db <- left_join(db, CIS, by=c("CIS.Type" = "Var1"))

#Binned (used for visualizing Binned Graphic)
bin <- db %>% group_by(YearST, CIS.Type) %>% summarise(Freq = n())
saveRDS(bin, "Bin.RDS")

##Pre-Processing Data into GrowthSummary (used for GrowthTotal/GrowthPercent Graphic)
Total <- filter(db, Status=="Issued") %>% group_by(Year) %>% summarise(CIS.Type="Total", UNQBusiness=length(unique(BusinessName)))
Total$PriorCount <- lag(Total$UNQBusiness, 1)
Total$CountChange <- Total$UNQBusiness-Total$PriorCount
Total$PercentChange <- round(Total$CountChange/Total$PriorCount,4)*100

UniqueType <- unique(db$CIS.Type)
for(i in seq(length(UniqueType))){
  SelectType <- filter(db, Status=="Issued" & CIS.Type == UniqueType[i]) %>% group_by(Year, CIS.Type) %>% summarise(UNQBusiness=length(unique(BusinessName)))
  SelectType$PriorCount <- lag(SelectType$UNQBusiness, 1)
  SelectType$CountChange <- SelectType$UNQBusiness-SelectType$PriorCount
  SelectType$PercentChange <- round(SelectType$CountChange/SelectType$PriorCount,4)*100
  Total <- rbind(Total, SelectType)
}
saveRDS(Total, "GrowthSummary.RDS")

##Pre-Processing Data into InactiveSummary
Total <- filter(db, Status=="Gone Out of Business" | Status=="Inactive" | Status=="Cancelled") %>% group_by(Year) %>% summarise(CIS.Type= "Total", UNQBusiness=length(unique(BusinessName)))
Total$PriorCount <- lag(Total$UNQBusiness, 1)
Total$CountChange <- Total$UNQBusiness-Total$PriorCount
Total$PercentChange <- round(Total$CountChange/Total$PriorCount,4)*100

UniqueType <- unique(db$CIS.Type)
for(i in seq(length(UniqueType))){
  SelectType <- filter(db, Status=="Gone Out of Business" | Status=="Inactive" | Status=="Cancelled")
  SelectType <- filter(SelectType, CIS.Type == UniqueType[i]) %>% group_by(Year, CIS.Type) %>% summarise(UNQBusiness=length(unique(BusinessName)))
  SelectType$PriorCount <- lag(SelectType$UNQBusiness, 1)
  SelectType$CountChange <- SelectType$UNQBusiness-SelectType$PriorCount
  SelectType$PercentChange <- round(SelectType$CountChange/SelectType$PriorCount,4)*100
  Total <- rbind(Total, SelectType)
}
saveRDS(Total, "InactiveSummary.RDS")

#
LA <- unique(db$LocalArea)
Other <- c()
for(i in seq(length(LA))){
  SelectType <- filter(db, Status=="Issued" & LocalArea == LA[i]) %>% group_by(Year, LocalArea) %>% summarise(UNQBusiness=length(unique(BusinessName)))
  SelectType$PriorCount <- lag(SelectType$UNQBusiness, 1)
  SelectType$CountChange <- SelectType$UNQBusiness-SelectType$PriorCount
  SelectType$PercentChange <- round(SelectType$CountChange/SelectType$PriorCount,4)*100
  Other <- rbind(Other, SelectType)
}
saveRDS(SelectType, "LocalArea.RDS")

#From Time CSV file
testing2 <- subset(testing, DayDiff != "-Inf")
testing2$DayDiff <- as.numeric(testing2$DayDiff, units="days")
db <- left_join(db, testing2, by.x=BusinessName, by.y=BusinessName)
