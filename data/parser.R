# load libraries
library(XML)
library(dplyr)
library(reshape2)
options(warn=-1)  # turn off unneccesary NON-EXISTING NA warnings in the code from XML library



# =========================================================================
# function get_data_labor_trend
#
# @description: get data from cps url.
# @return: reshaped dataframe of labor over time
# =========================================================================
get_labor_trend <- function() {
    url <- "http://www.bls.gov/cps/cpsaat02.htm"
    colnames <- c("year" = "integer",
                  "Total Population" = "FormattedInteger",
                  "Labor Force (Total)" = "FormattedInteger",
                  "% Labor Force (Total)" = "numeric",
                  "Labor Force (Employed)" = "FormattedInteger",
                  "% Labor Force (Employed)" = "numeric",
                  "Labor Force (Agriculture)" = "FormattedInteger",
                  "Labor Force (Non-agriculture)" = "FormattedInteger",
                  "Labor Force (Unemployed)" = "FormattedInteger",
                  "% Labor Force (Unemployed)" = "numeric",
                  "Non-Labor Force (Total)" = "FormattedInteger")
    
    # get data
    tables <- readHTMLTable(url, stringsAsFactors=FALSE, colClasses=unname(colnames))
    df <- tables[[2]]  # data is in second table in html
    
    # reshape data
    colnames(df) <- names(colnames)  # rename columns
    df <- df %>% na.omit()  # remove NAs
    genders <- rep(c("Men", "Women"), each=nrow(df)/2)  # create genders column to correct length
    
    df <- df %>% mutate(gender = genders)  # add gender column
    df <- melt(df, id=c("year", "gender")) %>%  # melt from wide to long
        rename(population = variable) %>%
        mutate(population = as.character(population)) %>%
        arrange(gender, population)
    return(df)
}



# =========================================================================
# function get_labor_occupation
#
# @description: get data from cps url.
# @return: reshaped dataframe of employed people by occupation, sex, ethnicity, age
# =========================================================================
get_labor_occupation <- function() {
    url <- "http://www.bls.gov/cps/cpsaat14.htm"
    colnames <- c("age_group" = "character",
                  "Mining/Extraction" = "FormattedInteger",
                  "Construction" = "FormattedInteger",
                  "Manufacturing" = "FormattedInteger",
                  "Wholesale/Retail" = "FormattedInteger",
                  "Transportation/Utilities" = "FormattedInteger",
                  "Information Services" = "FormattedInteger",
                  "Finance Services" = "FormattedInteger",
                  "Professional/Business Services" = "FormattedInteger",
                  "Education/Health Services" = "FormattedInteger",
                  "Leisure Services" = "FormattedInteger",
                  "Other Services" = "FormattedInteger",
                  "Public Administration" = "FormattedInteger")
    
    # get data
    tables <- readHTMLTable(url, stringsAsFactors=FALSE, colClasses=unname(colnames))
    df <- tables[[2]]  # data is in second table in html
    
    # reshape data
    colnames(df) <- names(colnames)  # rename columns
    df <- df %>%
        na.omit()  %>% # remove NAs
        filter(age_group %in% c("16 to 19 years",  # filter only certain rows
                                "20 to 24 years",
                                "25 to 54 years",
                                "55 years and over")) %>%
        slice((4*3+1):1000)  # skip the first few sections (total)
    races <- rep(c("White", "Black", "Asian", "Hispanic"), each=nrow(df)/4)  # create races column to correct length
    genders <- rep(rep(c("Men", "Women"), each=4), 4)  # create genders column to correct length - 4 (age) * 4 (race)
    df <- df %>%
        mutate(gender = genders,  # add gender and race columns
               race = races)
    df <- melt(df, id=c("age_group", "gender", "race")) %>%  # melt from wide to long
        rename(occupation = variable) %>%
        mutate(occupation = as.character(occupation)) %>%
        group_by(age_group, gender, race) %>%
        mutate(percentage = round(value / sum(value) * 100, 2))
    return(df)
}



# =========================================================================
# function get_labor_education
#
# @description: get data from cps url.
# @return: reshaped dataframe of employed people by education attainment
# =========================================================================
get_labor_education <- function() {
    url <- "http://www.bls.gov/cps/cpsaat07.htm"
    colnames <- c("metric" = "character",
                  "Less than High School (old)" = "FormattedNumber",
                  "Less than High School" = "FormattedNumber",
                  "High School (old)" = "FormattedNumber",
                  "High School" = "FormattedNumber",
                  "Some College Total (old)" = "FormattedNumber",
                  "Some College Total" = "FormattedNumber",
                  "Some College No Degree (old)" = "FormattedNumber",
                  "Some College No Degree" = "FormattedNumber",
                  "Some College Associate Degree (old)" = "FormattedNumber",
                  "Some College Associate Degree" = "FormattedNumber",
                  "Bachelors Degree (old)" = "FormattedNumber",
                  "Bachelors Degree" = "FormattedNumber")
    
    # get data
    tables <- readHTMLTable(url, stringsAsFactors=FALSE, colClasses=unname(colnames))
    df <- tables[[2]]  # data is in second table in html
    
    # reshape data
    keeps <- c("metric", "Less than High School", "High School", "Some College No Degree", "Some College Associate Degree", "Bachelors Degree")  # columns to keep
    colnames(df) <- names(colnames)  # rename columns
    df <- df[, keeps]  # keep only some columns
    df <- df %>% na.omit()  # remove NAs
    categories <- rep(c("Total", "Men", "Women", "White", "Black", "Asian", "Hispanic"), each=nrow(df)/7)  # create categories column to correct length
    df <- df %>% mutate(category = categories)  # add category column
    df <- melt(df, id=c("metric", "category")) %>%  # melt from wide to long
        rename(education = variable) %>%
        mutate(education = as.character(education))
    return(df)
}