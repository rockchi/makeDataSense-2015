library(shiny)
library(shinydashboard)
library(plotly)
library(rCharts)


ui <- dashboardPage(
  dashboardHeader(title="makeDataSense Competition"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("ANALYZE", tabName="tabAnalyze"),
      menuItem("EXPLORE", tabName="tabExplore")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName="tabAnalyze",
              fluidRow(
                h2("makeDataSense Competition Project Introduction"),
                h6("By: Rock Chi and Stanislaw Nowak"),
                p("This application was created for the makeDataSense competition. In the challegne, our team was given the task to analyze an open set of data provided by the City of Vancouver. The data set contains data ranging from 1997-2015, with records about business licence applications. In our project, we were curious how business in each sector has change through time (ie. post-financial crisis and 2010 Olympics)."),
                a(href="makedatasense.ca/data-science-competition/#vandata", "Link to makeDataSense Competition Page"),
                br(),
                a(href="http://data.vancouver.ca/datacatalogue/businessLicence.htm", "Link to Business Licence Data"),
                br(),
                p("The application is split into two parts. The first part contains our brief analysis limited to 5 figures. For the audience to further dive into the dataset, we have also provided a dashboard that is under the Explore tab. Due to the size of the data and also our current experience with shiny/R, the graphics may take a few minutes to load in the Analyze section."),
                hr()),
              fluidRow(
                h3("Business Type Grouped into Segments"),
                p("A motivation in our analysis is to understand growth in in issued business licences. To further attribute growth and change to certain types of businesses, we have binned together similar categories of business types. For better accuracy, we have utilized definitions from Industry Canada's industry database."),
                a(href="https://www.ic.gc.ca/eic/site/cis-sic.nsf/eng/home", "Canada Industry Statistics (CIS)"),
                hr()),
              fluidRow(
                h3("Business Licences Issued Over Time (Segment by Industry Sector)"),
                p("In the following graphic, we see the total number of Unique Businesses over time. The summation of all the layers can be interpreted as the total number of Business Licences issued during the year. Each individual layer represent the total number of licences issued for that specific business sector."),
                showOutput("StackedTotalANALYSIS", "nvd3")),
              fluidRow(
                h3("Total Number of Licences Issued Over Time (Segment by Location)"),
                p("In the following graphic, we analyze the total number of issued business licences over time. Each segment can be identified by a Local Area. From the graphic, we can interpret that most businesses are located in Central Downtown area, followed by Fairview and Kitsilano."),
                showOutput("AreaANALYSIS", "nvd3")),
              fluidRow(
                h3("Percentage Change in Total Number Issued Over Time"),
                p("Business sectors such as Construction innate has higher counts of business records as each individual contractor would submit a business licence application. Thus, to visualise business growth trend, in the following graphic, we see the percentage change in number of businesses in the following graphic."),
                showOutput("PercentNewANALYSIS", "nvd3")),
              fluidRow(
                h3("Percentage Change in Total Number Inactive/Out of Business Over Time"),
                p("In analyzing how business has changed over time, we would also like to see which sector of business has seen the largest change in number of businesses going out of business or inactive from year to year. To do so, the following graphic displays Percent Change in Businesses Inactive or Gone out of Business over Time."),
                showOutput("PercentInactiveANALYSIS", "nvd3")),
              fluidRow(
                h3("Median Age by Sector"),
                p("We would also like to dive into better understanding the average life-span of businesses. Below show a boxplot of median lifespan of businesses measured in Days. Outliers could be observed in the graphic. Most of the outliers are public facilities (ie. long-standing healthcare services). By observation evaluating median values, 'Arts, Entertainment and Recreation' and 'Transportation and Warehousing' tend to how the shortest median lifespan. Note that within the dataset, business that go out of business or cancel their application within one year will have NA values. The following analysis only shows businesses that survive past 1 year."),
                plotOutput("AgeANALYSIS")
              )
      ),
      
      
      tabItem(tabName="tabExplore",
              fluidRow(
                h3("Quick Dashboard to Exploring Business Licence Data"),
                p("As the competition is limited to 5 figures, there may be trends of interest from the public and audience that are not covered. This dashboard was created with the intention to allow the public to explore the data for themselves."),
                hr(),
                h3("How does it work?"),
                p("In the left are toggles, when checked, graphic will be generated. Total is included in the list of sectors to allow individual to benchmark change within a certain sector to the overall change within the city."),
                hr()),
              fluidRow(
                column(3,
                         checkboxGroupInput("GrowthCheck", "Breaking down by:",
                                              c("Total" = "Total",
                                                "Accomodation and Food Services" = "Accomodation and Food Services",
                                                "Administrative and Support, Waste Management and Remediation Services " = "Administrative and Support, Waste Management and Remediation Services",
                                                "Arts, Entertainment and Recreation" = "Arts, Entertainment and Recreation",
                                                "Construction" = "Construction", 
                                                "Educational Services" = "Educational Services",
                                                "Finance and Insurance" = "Finance and Insurance",
                                                "Health Care and Social Assistance" = "Health Care and Social Assistance",
                                                "Manufacturing" = "Manufacturing",
                                                "Not-for-Profit" = "Not-for-Profit",
                                                "Professional, Scientific and Technical Services" = "Professional, Scientific and Technical Services",
                                                "Real Estate, Rental and Leasing" = "Real Estate, Rental and Leasing",
                                                "Transportation and Warehousing" = "Transportation and Warehousing", 
                                                "Wholesale Trade" = "Wholesale Trade"))),
                column(9,
                       h3("Total Issued Over Time (by Industry Sector)"),
                       
                       selectizeInput("ChartType", "Select Chart Type",
                                      c("Line Chart" = "lineChart",
                                        "Area Chart" = "stackedAreaChart")),
                       showOutput("GrowthTotal", "nvd3"))
                ),
             fluidRow(
               column(9, offset=3, 
                      h3("Percent Change in Total Issued from Prior Year"),
                        showOutput("PercentNew", "nvd3"))
               ),
             fluidRow(
               column(9, offset=3, 
                      h3("Percent Change in Total Inactive/Gone from Prior Year"),
                      showOutput("PercentInactive", "nvd3"))),
             fluidRow(
               column(3,
                      checkboxGroupInput("AreaCheck", "Breaking down by:",
                                         c("01-West End" = "01-West End",
                                           "02-Central Business/Downtown" = "02-Central Business/Downtown",
                                           "03-Strathcona" = "03-Strathcona",
                                           "04-Grandview-Woodland" = "04-Grandview-Woodland",
                                           "05-Hastings-Sunrise" = "05-Hastings-Sunrise", 
                                           "06-West Point Grey" = "06-West Point Grey",
                                           "07-Kitsilano" = "07-Kitsilano",
                                           "08-Fairview" = "08-Fairview",
                                           "09-Mount Pleasant" = "09-Mount Pleasant",
                                           "10-Dunbar-Southlands" = "10-Dunbar-Southlands",
                                           "11-Arbutus Ridge" = "11-Arbutus Ridge",
                                           "12-Shaughnessy" = "12-Shaughnessy",
                                           "13-South Cambie" = "13-South Cambie", 
                                           "14-Riley Park" = "14-Riley Park",
                                           "15-Kensington-Cedar Cottage" = "15-Kensington-Cedar Cottage",
                                           "16-Renfrew-Collingwood" = "16-Renfrew-Collingwood",
                                           "17-Kerrisdale" = "17-Kerrisdale" ,
                                           "18-Oakridge" = "18-Oakridge",
                                           "19-Sunset" = "19-Sunset",
                                           "20-Victoria-Fraserview" = "20-Victoria-Fraserview",
                                           "21-Killarney" = "21-Killarney",
                                           "22-Marpole" = "22-Marpole"
                                         ))),
               column(9,
                      h3("Total Issued Over Time (by Local Area"),
                      
                      selectizeInput("ChartTypeAREA", "Select Chart Type",
                                     c("Line Chart" = "lineChart",
                                       "Area Chart" = "stackedAreaChart")),
                      showOutput("AreaEXPLORE", "nvd3"))))
      ))
)