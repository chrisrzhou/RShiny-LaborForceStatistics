# Labor Force Statistics Explorer
AWS EC2 Project <a href="http://shiny.vis.datanaut.io/LaborForceStatistics/" target="_blank">here</a>


------

## About
The <a href="http://www.bls.gov/cps/" target="_blank">Current Population Survey (CPS)</a> is an online resource for labor force statistics produced by the Bureau of Labor Statistics (BLS).

The data is parsed using `readHTMLTable` from the `XML` package and reshaped using the amazing R package `dplyr`.  For more information on this data collection and cleaning implementation, please refer to the `parser.R` file for more details.

Throughout the application, the user is empowered with selection widgets to zoom in on data exploration of the dataset.  This site is designed with analysts in mind, and provides a layer of visualization that is otherwise masked behind tabular display of datasets in the original website.  Some examples of data insights with this application:
    
- *Compare the employment and other labor statistics by gender or by race.*
- *Compare the employment and other labor statistics over time (starting from the 1970s)*
- *Identify areas of improvements for equal opportunity for all genders and races.*
- *Observe in the `TREND` tab that the economic recession can be observed in the years 2009-2011 (i.e. "% Labor Force (Unemployed)").*
- *Observe in the `TREND` tab that the US population is still continually growing over the years (i.e. "Total Population").*
- *And many more that you can analyze!*


**DISCLAIMER:** I have decided to use the term "Black" to denote the "Black or African American" population, as well as assigning cliched color mappings to genders.  This is simply chosen **solely** as a concise way to help organize the visuals, and no offense is made to anyone.  In fact, it is my strong belief that the idea of a "race" should **not exist at all**, and it is somewhat unfortunate that a lot of labor statistics is being analyzed with this dimension.  Similarly, equal gender rights should be the goal of mankind's social evolution and I hope that in the future, these analysis would become a trivial topic in the United States labor statistics.

------

## Visualizations:
- **Trend:** This section visualizes the labor force population landscape by gender over time with the help of a bar chart.
- **Occupation:** This section visualizes employment by occupation. The facet plot provides a deep dive into race, age group, and gender breakdowns of employment by occupation.
- **Education:** This section displays visualizations of labor force statistics by education level attainment with the help of a bar chart. 

------

## Other notes:
- Use the selection widgets to help highlight specific data subsets of interest, and to view a different visualization based on the selected metric report.

- Download the "cleaned" and filtered dataset for each tab from the `Data` section using the download button found next to the `Data` section header.

- This project is done with `ggplot`.  This is a rich library for data visualization and works tremendously well with organized data living in dataframes.

- This project/application is not affiliated with the Burea of Labor Statistics.  The work is intended as a showcase of R Shiny data visualization capabilities.  All information courtesy of BLS/CPS. Used with permission.

------

## Resources
- <a href="http://chrisrzhou.datanaut.io/" target="_blank">Homepage</a>
- <a href="http://shiny.vis.datanaut.io/" target="_blank">R Shiny Projects</a>
- <a href="https://github.com/chrisrzhou/RShiny-LaborForceStatistics" target="_blank">Github Project</a>
- <a href="http://www.bls.gov/cps/" target="_blank">Burea of Labor Statistics (Current Population Survey)</a>