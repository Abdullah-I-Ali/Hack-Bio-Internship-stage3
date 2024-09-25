# Cholera Outbreak Data

# Authors (@slack):

Abdullah Ibrahim Ali(@Abdullah108)

Kareem Elsayed Saad Abdell Gawad(@Kareem\_101)

Noran Morad(@NoranMorad)

Manar Tarek (@ManarTj)

Omar holayell sawy (@Holayell)

Amira Mahmoud Mohamed (amira\\mahmoud\\4463)

## Phase I ( Help Dr/Einstein)

Our Solution for Epidemiologist Team (Kareem\_101 \- Abdullah108)   
In this Docs  [Here](https://docs.google.com/document/d/12xfhlTNXpOy5s_Swy_hUO1zO5bSfjlZM7RiNZ1DarJA/edit?usp=sharing)

## Phase II
# Emportant Links

1. For Report The [link](https://rich-vacuum-738.notion.site/Overview-Data-Analysis-and-Findings-on-Cholera-Data-1066793b6a03802c969bd3b78aa3e1c6)

      2.For Shiny App The [link](https://choleradatainsights.shinyapps.io/solve/)
# Resourece

Data from World Health Organization(WHO) : "[https://apps.who.int/gho/data/node.main.174?lang=en](https://apps.who.int/gho/data/node.main.174?lang=en)"

# About Used DataSet
1. Description: This dataset contains historical records of cholera outbreaks across various countries and territories.

   The data includes information on the number of reported cases, deaths, and fatality rates for cholera over different years.



Files in the dataset:

data.csv: Contains the number of reported cholera cases.

data (2).csv: Contains the number of reported deaths from cholera.

data (3).csv: Contains the cholera case fatality rate.

2. Columns in the Dataset:

The dataset consists of the following columns:

Common Columns (in all files):

Countries, territories and areas: The name of the country or territory where the cholera outbreak occurred.

Year: The year when the data was recorded.

Specific Columns:

data.csv:

Number of reported cases of cholera: The number of reported cholera cases for the respective country and year.

data (2).csv:

Number of reported deaths from cholera: The number of reported deaths due to cholera for the respective country and year.

data (3).csv:

Cholera case fatality rate: The fatality rate (%) of cholera, calculated as the number of deaths divided by the number of reported cases, multiplied by 100\.

3. Data Processing:

Merging the Files:

The three files can be merged using the common columns Countries, territories and areas and Year. This will allow a more comprehensive view of the reported cases, deaths, and fatality rates for each country and year.

4. Missing Data:

Some columns may contain missing values (NA). These can be handled using various techniques, such as replacing missing values with the column mean or ignoring rows with missing data.

# AIMS (Goals)

1. Analyze the Data Review the downloaded data and come up with innovative ways to report and visualize cholera outbreaks since 1949\.  
     
2. Report and Design Visualization effectively communicate the severity, spread, and impact of cholera outbreaks. You can find this analysis and Visualization in our Report for each continent and country  
     
   [Here](https://rich-vacuum-738.notion.site/Overview-Data-Analysis-and-Findings-on-Cholera-Data-1066793b6a03802c969bd3b78aa3e1c6)  
     
3. Create a Summary Template IN this repo you can find this summary for one counrty and ,but in the code template can be created for any country  
     
4. Develop a Shiny App (For Bioinformaticians):  
    Build the Shiny App: The front-end bioinformaticians will use the R Shiny framework to create an interactive dashboard to visualize the cholera outbreak data provided by the epidemiologists. Key Features: The app should include: Interactive maps and charts. Filters to select specific countries and time periods. Calculations and summaries of key metrics like total cases, fatalities, and outbreak durations. Automatic Reports: Implement functionality to automatically generate country-specific reports based on the epidemiologists' summary template.4.  
   You can find App link   
   [Here](https://choleradatainsights.shinyapps.io/solve/)
## Used Programming language
1.For AMR Team 
   R - Bash
2. For Front-End Team
   R (100%)
