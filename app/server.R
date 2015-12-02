library(shiny)
library(shinydashboard)
library(rCharts)
library(plotly)
library(ggplot2)
library(dplyr)
library(lubridate)

load("./data/allObjects.RData")

shinyServer(function(input,output){
  #ANALYSIS
  output$StackedTotalANALYSIS <- renderChart({
    #Graphing Nominal Change over Time
    a3 <- nPlot(UNQBusiness ~ Year, group="CIS.Type", data=queryStacked, type="stackedAreaChart", id="GrowthTotal")
    a3$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    a3$chart(showLegend=FALSE)
    a3$set(dom="StackedTotalANALYSIS")
    return(a3)
  })
  output$PercentNewANALYSIS <- renderChart({
    #Graphing % Change of New over Time
    a4 <- nPlot(PercentChange ~ Year, group="CIS.Type", data=queryPercent, type="lineChart", id="GrowthTotal")
    a4$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    a4$set(dom="PercentNewANALYSIS")
    return(a4)
  })
  output$PercentInactiveANALYSIS <- renderChart({
    #How has total number of businesses changed through time?
    a5 <- nPlot(PercentChange ~ Year, group="CIS.Type", data=queryInactive, type="lineChart", id="GrowthTotal")
    a5$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    a5$set(dom="PercentInactiveANALYSIS")
    return(a5)
  })
  output$AreaANALYSIS <- renderChart({
    #Graphing Nominal Change over Time
    a6 <- nPlot(UNQBusiness ~ Year, group="LocalArea", data=AreaSummary, type="stackedAreaChart", id="GrowthTotal")
    a6$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    a6$chart(showLegend=FALSE)
    a6$set(dom="AreaANALYSIS")
    return(a6)
  })
  output$AgeANALYSIS <- renderPlot({
    #Graphing Nominal Change over Time
    ggplot(AgeSummary, aes(x=factor(CIS.Type), y=DayDiff)) + geom_boxplot() + 
      theme(axis.text.x = element_text(angle = 90)) + xlab("Business Sector") + ylab("Days with Valid Licence") +
      scale_x_discrete(labels=c("Accom/Food", "Admin/Waste Management", "Arts/Enter", "Construction", "Educational", "Heatlh Care", "Not-for-Profit", "Personal Service/Other", "Profressional/Technical", "Public Admin.", "Real Estate/Leasing", "Retail", "Transportation", "Wholesale", "NA"))
  })
  
  
  
  GrowthSubset <- reactive({
    queryResult1 <- filter(GrowthSummary, CIS.Type %in% input$GrowthCheck == TRUE)
    queryResult1
  })
  InactiveSubset <- reactive({
    queryResult2 <- filter(InactiveSummary, CIS.Type %in% input$GrowthCheck == TRUE)
    queryResult2
  })
  AreaSubset <- reactive({
    queryResult3 <- filter(AreaSummary, LocalArea %in% input$AreaCheck == TRUE)
    queryResult3
  })
  
  output$GrowthTotal <- renderChart({
    #How has total number of businesses changed through time?
    d1 <- nPlot(UNQBusiness ~ Year, group="CIS.Type", data=GrowthSubset(), type=input$ChartType, id="GrowthTotal")
    d1$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    d1$set(dom="GrowthTotal")
    return(d1)
  })
  
  output$PercentNew <- renderChart({
    #How has total number of businesses changed through time?
    d2 <- nPlot(PercentChange ~ Year, group="CIS.Type", data=GrowthSubset(), type="lineChart", id="PercentActive")
    d2$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    d2$set(dom="PercentNew")
    return(d2)
  })
  
  output$PercentInactive <- renderChart({
    #How has total number of businesses changed through time?
    d3 <- nPlot(PercentChange ~ Year, group="CIS.Type", data=InactiveSubset(), type="lineChart", id="PercentInactive")
    d3$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    d3$set(dom="PercentInactive")
    return(d3)
  })
  
  output$AreaEXPLORE <- renderChart({
    #Graphing Nominal Change over Time
    d4 <- nPlot(UNQBusiness ~ Year, group="LocalArea", data=AreaSubset(), type=input$ChartTypeAREA, id="AreaEXPLORE")
    d4$xAxis(tickFormat= "#!function(d){return d3.time.format('%Y')(new Date(d));}!#")
    d4$chart(showLegend=FALSE)
    d4$set(dom="AreaEXPLORE")
    return(d4)
  })
})
