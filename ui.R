shinyUI(fluidPage(
    tags$head(tags$link(rel="stylesheet", type="text/css", href="app.css")),
    
    titlePanel("Labor Force Statistics Explorer"),
    
    sidebarLayout(
        sidebarPanel(
            p(class="text-small",
              a(href="http://chrisrzhou.datanaut.io/", target="_blank", "by chrisrzhou"),
              a(href="https://github.com/chrisrzhou/RShiny-LaborForceStatistics", target="_blank", icon("github")), " | ",
              a(href="http://bl.ocks.org/chrisrzhou", target="_blank", icon("cubes")), " | ",
              a(href="https://www.linkedin.com/in/chrisrzhou", target="_blank", icon("linkedin"))),
            hr(),
            p(class="text-small", "Labor Force Statistics visualizations.  All data is derived from the Current Population Survey results by the Bureau of Labor Statistics website: ",
              a(href="http://www.bls.gov/cps/", target="_blank", "http://www.bls.gov/cps/")),
            hr(),
            
            conditionalPanel(
                condition="input.tabset == 'Trend'",
                selectInput(inputId="trend_population", label="Select Population", choices=choices$trend_population, selected=choices$trend_population[[3]]),
                hr(),
                sliderInput(inputId="trend_years", label="Filter Years", min=min(choices$trend_year), max=max(choices$trend_year),
                            value=c(min(choices$trend_year), max(choices$trend_year)), step=1, format="####")
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Occupation'",
                hr(),
                checkboxGroupInput(inputId="occupation_age_group", label="Choose Age Group:", choices=choices$occupation_age_group, selected=choices$occupation_age_group[3:4]),
                hr(),
                checkboxGroupInput(inputId="occupation_race", label="Choose Race:", choices=choices$occupation_race, selected=choices$occupation_race),
                hr(),
                checkboxGroupInput(inputId="occupation_occupation", label="Choose Occupation:", choices=choices$occupation_occupation, selected=choices$occupation_occupation)
            ),
            
            conditionalPanel(
                condition="input.tabset == 'Education'",
                selectInput(inputId="education_category", label="Select Category", choices=choices$category, selected=choices$category[[1]]),
                hr(),
                selectInput(inputId="education_metric", label="Select Metric", choices=choices$education_metric, selected=choices$education_metric[[1]]),
                hr(),
                checkboxGroupInput(inputId="education_education", label="Choose Education:", choices=choices$education_education, selected=choices$education_education)
            ),
            width=3
        ),
        
        mainPanel(
            tabsetPanel(id="tabset",
                        tabPanel("Trend",
                                 h2("Labor Force Trends"),
                                 p(class="text-small", "This section visualizes the labor force population landscape by gender over time.  
                                   Units are in thousands."),
                                 hr(),
                                 
                                 h3("Bar Chart"),
                                 p(class="text-small", "Visualization of employment populations over the past 40 years broken down by gender.  
                                   Select a population metric on the left to update the chart."),
                                 plotOutput("trend_barchart", height=400, width="auto"),
                                 hr(),
                                 
                                 h3("Data", downloadButton("trend_download", label="")),
                                 p(class="text-small", "Tabular searchable data display similar to that found in the original source ",
                                   a(href="http://www.bls.gov/cps/cpsaat02.htm", target="_blank", "http://www.bls.gov/cps/cpsaat02.htm")),
                                 p(class="text-small", "You can download the data with the download button above."),
                                 dataTableOutput("trend_datatable"),
                                 hr()
                        ),
                        
                        tabPanel("Occupation",
                                 h2("Employment by Occupation"),
                                 p(class="text-small", "This section visualizes employment by occupation. 
                                   The facet plot provides a deep dive into race, age group, and gender breakdowns of employment by occupation.  
                                   You can use the widgets on the left to subset the dataset.  Units are in thousands."),
                                 hr(),
                                 
                                 h3("Facet Plot"),
                                 p(class="text-small", "Facet plot of employment by race, age group, and gender and occupation.  
                                   Toggle the 'Display Percentage' checkbox to show percentages or actual counts."),
                                 checkboxInput(inputId="occupation_percentage", label="Display Percentage", value=TRUE),
                                 plotOutput("occupation_facetplot", height=600, width="auto"),
                                 hr(),
                                 
                                 h3("Data", downloadButton("occupation_download", label="")),
                                 p(class="text-small", "Tabular searchable data display similar to that found in the original source ",
                                   a(href="http://www.bls.gov/cps/cpsaat14.htm", target="_blank", "http://www.bls.gov/cps/cpsaat14.htm")),
                                 p(class="text-small", "You can download the data with the download button above."),
                                 dataTableOutput("occupation_datatable"),
                                 hr()
                        ),
                        
                        tabPanel("Education",
                                 h2("Labor Force by Education Level"),
                                 p(class="text-small", "This section displays visualizations of labor force statistics by education level attainment.  
                                   Please select a category to view the detailed breakdown by gender or race.  Units are in thousands."),
                                 hr(),
                                 
                                 h3("Bar Chart"),
                                 p(class="text-small", "Visualization of various labor metrics and statistics by education level."),
                                 plotOutput("education_barchart", height=400, width="auto"),
                                 hr(),
                                 
                                 h3("Data", downloadButton("education_download", label="")),
                                 p(class="text-small", "Tabular searchable data display similar to that found in the original source ",
                                   a(href="http://www.bls.gov/cps/cpsaat07.htm", target="_blank", "http://www.bls.gov/cps/cpsaat07.htm")),
                                 p(class="text-small", "You can download the data with the download button above."),
                                 dataTableOutput("education_datatable"),
                                 hr()
                        )
            ),
            width=9
        )
    )
))
