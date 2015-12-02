#makeDataSense Competition Entry - 2015

In this repository, you will find our data application which was submitted as an entry for the makeDataSense Data Science Competition. The competition was overall a great learning opportunity. Rather than going with Tableau, I decided to focus on utilizing R and Shiny for this competition in creating an interactive dashboard for the audience to better understand the given dataset.

[Dashboard Link](https://rockchi.shinyapps.io/draft)

[makeDataSense Competition Link](http://makedatasense.ca/data-science-competition/#vandata)

###City of Vancouver Business Licences Dataset

In this challenge, we were assigned to develop 5 figures using the City of Vancouver's Business Licences dataset. You could find this dataset under City of Vancouver's Open Data Catalogue. The data is split into seperate CSV files each containing business licences issued within the year. Going from year to year, rather than using a consistent ID, Business Names is used to track year-to-year changes. Businesses can be of Statuses including, Issued, Cancelled or Gone out of Business. In addition, along with these information, Geographical variables were also included identifying where the business is located. Records can also be segmented by business type and size of business (number of employees employed).

[Business Licences Dataset](http://data.vancouver.ca/datacatalogue/businessLicence.htm)

[Canadian Industry Statistics](https://www.ic.gc.ca/eic/site/cis-sic.nsf/eng/home)

###Major Learning and Challenges

One aspect which I spent a lot of time on during this challenge was binning together Business Types, containing 244 unique indicators. As our motivation during this project was to visualise business trends within Vancouver over time, answering the relevant question of industry required aggregration of those variables. To determine business industry, I utilized the Canadian Industry Statistics website, containing definition for each industry. Beyond data cleaning, much of the learning was in adapting to the new set of tools I was using for the competition. 

#####1. NVD3 and Shiny
First of all, I wanted interactive graphics in the dashboard. On top of that, I hoped to create stacked area plots to visualise change in industry. At first, plotly + ggplot was used; however, the combination was encountering a bug where one layer would cover all the other layers. 
I decided on using NVD3, a D3.js package, that can be access via rCharts. However, something learnt was that the package had formatting conflicts with Shiny (ie. box() function) and was having errors when I tried to port the graphics to self-contained HTML-Markdown. 

[StackOverflow Discussion on the Problem](http://stackoverflow.com/questions/28120267/rchart-in-r-markdown-doesnt-render)

#####2. plotly and Plotting Speed
When integrating ggplot + plotly, I realized that the conversion was lagging the entire application. Especially since interactivity is a core aspect for intuitive data exploration, the delayed load time was less than ideal. This is aspect where I realized D3.js graphics is great at. Graphics from D3.js was fairly responsive to data input changes via dashboard toggles.

#####3. App Memory Management
Something that I forgot during the competition was the limit on RStudio+Shiny hosting. Applications are limited to 1GB RAM. To quicken the load time, I decided to pre-process much of the data into summary tables rather than loadin the full cleaned CSV. Additionally, taking out plotly decreased RAM usage immensely. 

 

###Summary
Overall lots of lessons learned, especially in the techinical and dev aspect!  