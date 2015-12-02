library(rCharts)
library(lubridate)

##average age
UniqueBusiness <- unique(db$BusinessName)
testing <- c()
for(i in seq(length(UniqueBusiness))){
  temp <- filter(db, BusinessName == UniqueBusiness[i])
  EarliestIssue <- min(temp$IssuedDate, na.rm=TRUE)
  LastestExp <- max(temp$ExpiredDate, na.rm=TRUE)
  temp <- data.frame(BusinessName=UniqueBusiness[i], EarlyIssue=EarliestIssue, LastExpire=LastestExp)
  testing <- rbind(testing, temp)
}
saveRDS(testing, "testing.RDS")

##Data for Sankey
db$YearSt <- year(db$Year)
UniqueYear <- unique(db$YearSt)
for(i in seq(length(UniqueYear-1))){
  ExistingIssue <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]) %in% unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Issued",]))
  ExistingGone <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]) %in% unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Gone Out of Business",]))
  ExistingInactive <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]) %in% unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Inactive",]))
  ExistingCancel <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]) %in% unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Cancelled",]))
  
  NewIssue <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Issued",]) %notin% unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]))
  NewGone <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Gone Out of Business",]) %notin% unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]))
  NewInactive <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Inactive",]) %notin% unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]))
  NewCancel <- sum(unique(db$BusinessName[db$YearSt==UniqueYear[i+1] & db$Status=="Cancelled",]) %notin% unique(db$BusinessName[db$YearSt==UniqueYear[i] & db$Status=="Issued",]))
  
  PopFlow <- c(ExistingIssue, ExistingGone, ExistingInactive, ExistingCancel, NewIssue, NewGone, NewInacive, NewCancel)
  From <- c("Existing", "Existing", "Existing", "New", "New", "New")
  To <- c("")



