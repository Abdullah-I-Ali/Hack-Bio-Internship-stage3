data1<-read.csv("data.csv")
data2<-read.csv("data (2).csv")
data3<-read.csv("data (3).csv")
mergedata1<-merge(data1,data2,by =c("Countries..territories.and.areas","Year"),all=TRUE)
cholera_data<-merge(mergedata1,data3,by =c("Countries..territories.and.areas","Year"),all=TRUE)
# load nessesary library
library(dplyr)
library(tidyr)

library(ggplot2)
library(viridis) 
library(scales)  # For formatting the y-axis
library(plotly)
library(ggplotlyExtra)
#  libraries for map
library(leaflet)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
#### library for report
library(knitr)
library(rmarkdown)


# Sort by 'Countries, territories and areas' and 'Year'
sorted_df <- cholera_data %>%
  arrange(Countries..territories.and.areas, Year)

# remove na(zero instead )
# 0
cholera_data[is.na(cholera_data)] <- 0
colSums(is.na(cholera_data))
 # fix data type
cholera_data$Number.of.reported.cases.of.cholera <- as.numeric(as.character(cholera_data$Number.of.reported.cases.of.cholera))
cholera_data$Number.of.reported.deaths.from.cholera <- as.numeric(as.character(cholera_data$Number.of.reported.deaths.from.cholera))
cholera_data$Cholera.case.fatality.rate <- as.numeric(as.character(cholera_data$Cholera.case.fatality.rate))

# View the sorted data
summary(cholera_data)
head(sorted_df)
# Write the sorted data to a new CSV file
write.csv(cholera_data, "sorted_merged_cholera_data.csv", row.names = FALSE)
## plots to report the data 

# Country to continent mapping (this is a simplified version, you can expand it)

# Check lengths of Countries and Continents vectors
# Define the vectors

# Define the vector with countries and continents separated by ":"
country_continent <- c(
  "Afghanistan: Asia",  "Albania: Europe",  "Algeria: Africa",
  "Andorra: Europe",  "Angola: Africa",
  "Argentina: South America",  "Armenia: Asia",
  "Australia: Oceania",  "Austria: Europe",  "Azerbaijan: Asia",  "Bahamas: North America",  "Bahrain: Asia",  "Bangladesh: Asia",
  "Belarus: Europe",  "Belgium: Europe",  "Belize: North America",
  "Benin: Africa",
  "Bhutan: Asia",  "Bolivia (Plurinational State of): South America",
  "Botswana: Africa",  "Brazil: South America",
  "Brunei Darussalam: Asia",  "Burkina Faso: Africa",  "Burundi: Africa",  "Cabo Verde: Africa",  "Cambodia: Asia",
  "Cameroon: Africa",  "Canada: North America",
  "Central African Republic: Africa",  "Chad: Africa",  "Chile: South America",  "China: Asia",  "Colombia: South America",  "Comoros: Africa",  "Congo: Africa",  "Costa Rica: North America",  "Cote d'Ivoire: Africa",  "Cuba: North America",  "Czechia: Europe",  "Democratic People's Republic of Korea: Asia",
  "Democratic Republic of the Congo: Africa",  "Denmark: Europe",  "Djibouti: Africa",  "Dominican Republic: North America",  "Ecuador: South America",  "El Salvador: North America",  "Equatorial Guinea: Africa",  "Eritrea: Africa",  "Estonia: Europe",  "Eswatini: Africa",  "Ethiopia: Africa",  "Finland: Europe",  "France: Europe",  "Gabon: Africa",  "Gambia: Africa",  "Georgia: Asia/Europe (transcontinental)",
  "Germany: Europe",  "Ghana: Africa",  "Greece: Europe",  "Guatemala: North America",
  "Guinea: Africa",
  "Guinea-Bissau: Africa",  "Guyana: South America",
  "Haiti: North America",  "Honduras: North America",
  "Hungary: Europe",  "India: Asia",  "Indonesia: Asia",
  "Iran (Islamic Republic of): Asia",  "Iraq: Asia",  "Ireland: Europe",  "Israel: Asia",  "Italy: Europe",  "Japan: Asia",  "Jordan: Asia",  "Kazakhstan: Asia/Europe (transcontinental)",
  "Kenya: Africa",  "Kiribati: Oceania",  "Kuwait: Asia",  "Kyrgyzstan: Asia",  "Lao People's Democratic Republic: Asia",
  "Lebanon: Asia",  "Lesotho: Africa",  "Liberia: Africa",
  "Libya: Africa",
  "Madagascar: Africa",  "Malawi: Africa",  "Malaysia: Asia",
  "Maldives: Asia",  "Mali: Africa",
  "Marshall Islands: Oceania",  "Mauritania: Africa",  "Mauritius: Africa",  "Mexico: North America",
  "Micronesia (Federated States of): Oceania",  "Mongolia: Asia",  "Morocco: Africa",  "Mozambique: Africa",  "Myanmar: Asia",
  "Namibia: Africa",  "Nauru: Oceania",  "Nepal: Asia",
  "Netherlands (Kingdom of the): Europe",  "New Zealand: Oceania",
  "Nicaragua: North America",  "Niger: Africa",  "Nigeria: Africa",  "Norway: Europe",
  "Oman: Asia",
  "Pakistan: Asia",  "Panama: North America",  "Papua New Guinea: Oceania",  "Paraguay: South America",
  "Peru: South America",  "Philippines: Asia",  "Poland: Europe",
  "Portugal: Europe",  "Qatar: Asia",  "Republic of Korea: Asia",  "Republic of Moldova: Europe",  "Romania: Europe",
  "Russian Federation: Asia",  "Rwanda: Africa",  "Samoa: Oceania",
  "Sao Tome and Principe: Africa",  "Saudi Arabia: Asia",  "Senegal: Africa",  "Seychelles: Africa",  "Sierra Leone: Africa",  "Singapore: Asia",  "Slovenia: Europe",  "Somalia: Africa",  "South Africa: Africa",  "South Sudan: Africa",  "Spain: Europe",
  "Sri Lanka: Asia",  "Sudan: Africa",  "Suriname: South America",
  "Sweden: Europe",  "Switzerland: Europe",  "Syrian Arab Republic: Asia",
  "Tajikistan: Asia",  "Thailand: Asia",  "The former state union Serbia and Montenegro: Europe",
  "Togo: Africa",  "Tonga: Oceania",  "Tunisia: Africa",  "Turkiye: Asia/Europe (transcontinental)",
  "Turkmenistan: Asia",  "Tuvalu: Oceania",  "Uganda: Africa",
  "Ukraine: Europe",  "United Arab Emirates: Asia",  "United Kingdom of Great Britain and Northern Ireland: Europe",
  "United Republic of Tanzania: Africa",  "United States of America: North America",  "Uzbekistan: Asia",  "Venezuela (Bolivarian Republic of): South America",
  "Viet Nam: Asia",  "Yemen: Asia",  "Zambia: Africa",  "Zimbabwe: Africa"
)


# Split the vector into two columns based on ":"
split_data <- do.call(rbind, strsplit(country_continent, ": "))

# Create the data frame
continent_mapping<- data.frame(Country = split_data[,1], Continent = split_data[,2], stringsAsFactors = FALSE)

# Join the continent information to the cholera data
cholera_data <- cholera_data %>%
  left_join(continent_mapping, by = c("Countries..territories.and.areas" = "Country"))

# Summarize the number of cases by continent and year
continent_data <- cholera_data %>%
  group_by(Continent, Countries..territories.and.areas,Year) %>%
  summarise(total_cases = sum(Number.of.reported.cases.of.cholera))

# Create a plot to compare cholera cases between continents

plt_continent <- ggplot(continent_data, aes(x = as.numeric(Year), y = total_cases, color = Continent)) +
  geom_line(size = 1.5, alpha = 0.7) +
  geom_point(size = 3, pch = 21, color = "white", stroke = 1) +
  scale_color_brewer(palette = "Set1") +
  scale_x_continuous(breaks = seq(1960, 2020, by = 10)) +
  scale_y_continuous(labels = label_number(scale = 1e-3, suffix = "K")) +
  labs(
    title = "Cholera Cases Over Time by Continent",
    x = "Year",
    y = "Total Reported Cases of Cholera"
  ) +
  facet_wrap(~ Continent) +  # Create individual plots per continent
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    strip.text = element_text(face = "bold"),
    legend.position = "none"
  )


# Print the plot
print(plt_continent)



# Loop through each unique country and generate a plot
unique_countries <- unique(cholera_data$Countries..territories.and.areas)

for (country in unique_countries) {
  # Filter data for the current country
  country_data <- cholera_data %>%
    filter(Countries..territories.and.areas == country)
  
  # Create the time series plot
  time_series_plot <- ggplot(country_data, aes(x = Year, y = Number.of.reported.cases.of.cholera)) +
    geom_line(color = "blue", size = 1) +
    geom_point(color = "darkblue", size = 2) +  # Add points to highlight values
    geom_smooth(method = "loess", color = "red", linetype = "dashed", se = FALSE) +  # Smooth trend line
    scale_y_continuous(labels = scales::comma) +  # Format y-axis with commas
    scale_x_continuous(breaks = pretty(country_data$Year, n = 10)) +  # Ensure readable year intervals
    labs(title = paste("Cholera Cases Over Time in", country),
         x = "Year", y = "Reported Cases of Cholera") +
    theme_minimal(base_size = 14) +  # Adjust base font size for better readability
    theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Tilt x-axis labels for better reading
          panel.background = element_rect(fill = "#f0f4f7", color = "#f0f4f7"),  # Set background color
          plot.background = element_rect(fill = "#e9eef1", color = NA),  # Plot background color
          panel.grid.major = element_line(color = "#dfe3e6"),  # Change gridline colors
          panel.grid.minor = element_line(color = "#dfe3e6"))  # Minor gridline colors
  # Save the plot with the country name in the filename
  filename <- paste0("H:/plots/", gsub(" ", "_", country), ".png")
  ggsave(filename, time_series_plot, width = 10, height = 6)
}
#-----------------------------------------------------------------
cholera_data$Number.of.reported.deaths.from.cholera <- as.numeric(as.character(cholera_data$Number.of.reported.deaths.from.cholera))

#number of death and rate of death 
for (country in unique_countries) {
  # Filter data for the current country
  country_data <- cholera_data %>%
    filter(Countries..territories.and.areas == country)
  # Create the time series plot
  time_series_plot <- ggplot() +
    geom_line(data = country_data, aes(x = Year, y = Number.of.reported.cases.of.cholera, color = "Reported Cases"), size = 1) +
    geom_point(data = country_data, aes(x = Year, y = Number.of.reported.cases.of.cholera, color = "Reported Cases"), size = 2) +
    geom_line(data = country_data, aes(x = Year, y = Number.of.reported.deaths.from.cholera, color = "Number of Deaths"), size = 1, linetype = "dashed") +
    geom_point(data = country_data, aes(x = Year, y = Number.of.reported.deaths.from.cholera, color = "Number of Deaths"), size = 2, shape = 17) +
    geom_line(data = country_data, aes(x = Year, y =as.numeric( Cholera.case.fatality.rate) * 1000, color = "Rate of Death"), size = 1, linetype = "dotted") +  # Scaling for visibility
    scale_y_continuous(sec.axis = sec_axis(~./100, name = "Rate of Death (per 1000 cases)")) +  # Add secondary y-axis
    scale_x_continuous(breaks = pretty(country_data$Year, n = 10)) +  # Ensure readable year intervals
    labs(title = paste("Cholera Cases and Deaths Over Time in", country),
         x = "Year", y = "Number of Cases / Deaths") +
    scale_color_manual(name = "Metrics", values = c("Reported Cases" = "blue", "Number of Deaths" = "red", "Rate of Death" = "green")) +
    theme_minimal(base_size = 14) +  # Adjust base font size for better readability
    theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Tilt x-axis labels for better reading
          panel.background = element_rect(fill = "#f0f4f7", color = "#f0f4f7"),  # Set background color
          plot.background = element_rect(fill = "#e9eef1", color = NA),  # Plot background color
          panel.grid.major = element_line(color = "#dfe3e6"),  # Change gridline colors
          panel.grid.minor = element_line(color = "#dfe3e6"))  # Minor gridline colors
  
  # Save the plot with the country name in the filename
  filename <- paste0("H:/plots2/_", gsub(" ", "_", country), ".png")
  ggsave(filename, time_series_plot, width = 12, height = 7)
}

##top 50 country in  number of cases 

  top_countries <- cholera_data %>%
  group_by(Countries..territories.and.areas) %>%
  summarise(TotalCases = sum(Number.of.reported.cases.of.cholera, na.rm = TRUE)) %>%
  arrange(desc(TotalCases)) %>%
  top_n(50, TotalCases)


# Load world map data using rnaturalearth
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge cholera data with the world map data
map_data <- world %>%
  left_join(top_countries, by = c("name" = "Countries..territories.and.areas"))

# Check for any missing countries and correct the names if necessary
missing_countries <- setdiff(top_countries$Countries..territories.and.areas, map_data$name)
print(missing_countries)  # List of countries that were not matched, if any
# add missing
country_corrections <- c(
  "Bolivia (Plurinational State of)" = "Bolivia",
  "Brunei Darussalam" = "Brunei",
  "Central African Republic" = "Central African Republic",
  "Cote d'Ivoire" = "Ivory Coast",
  "Democratic People's Republic of Korea" = "North Korea",
  "Democratic Republic of the Congo" = "Democratic Republic of the Congo",
  "Dominican Republic" = "Dominican Republic",
  "Equatorial Guinea" = "Equatorial Guinea",
  "Eswatini" = "Eswatini",
  "Iran (Islamic Republic of)" = "Iran",
  "Lao People's Democratic Republic" = "Laos",
  "Marshall Islands" = "Marshall Islands",
  "Micronesia (Federated States of)" = "Micronesia",
  "Netherlands (Kingdom of the)" = "Netherlands",
  "Republic of Korea" = "South Korea",
  "Republic of Moldova" = "Moldova",
  "Russian Federation" = "Russia",
  "Sao Tome and Principe" = "Sao Tome and Principe",
  "South Sudan" = "South Sudan",
  "Syrian Arab Republic" = "Syria",
  "The former state union Serbia and Montenegro" = "Serbia and Montenegro",
  "Turkiye" = "Turkey",
  "United Kingdom of Great Britain and Northern Ireland" = "United Kingdom",
  "United Republic of Tanzania" = "Tanzania",
  "Venezuela (Bolivarian Republic of)" = "Venezuela",
  "Viet Nam" = "Vietnam"
)

# Apply corrections to the cholera data
top_countries$Countries..territories.and.areas <- recode(top_countries$Countries..territories.and.areas, !!!country_corrections)
# Create an interactive map with Leaflet
leaflet(data = map_data) %>%
  addTiles() %>%
  addPolygons(
    fillColor = ~colorQuantile("YlOrRd", TotalCases)(TotalCases), 
    weight = 1, 
    opacity = 1, 
    color = "white", 
    dashArray = "3", 
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE
    ),
    label = ~paste(name, "<br>", "Cholera Cases:", TotalCases),
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"
    )
  ) %>%
  addLegend(
    pal = colorQuantile("YlOrRd", NULL), 
    values = ~TotalCases, 
    opacity = 0.7, 
    title = "Cholera Cases",
    position = "bottomright"
  )

top_10countries <- cholera_data %>%
  group_by(Countries..territories.and.areas) %>%
  summarise(TotalCases = sum(Number.of.reported.cases.of.cholera, na.rm = TRUE)) %>%
  arrange(desc(TotalCases)) %>%
  top_n(10, TotalCases)

# ggplot
top_10countries_plot <- ggplot(top_10countries, aes(x = Countries..territories.and.areas, y = TotalCases)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Countries with the Highest Cholera Cases",
       x = "Country",
       y = "Total Cases of Cholera") +
  scale_y_continuous(labels =comma) +  # 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# الخطوة 3: تحويل الرسم الثابت إلى رسم تفاعلي باستخدام plotly
interactive_plot1 <- ggplotly(top_10countries_plot)

# عرض الرسم التفاعلي
interactive_plot1
# Assuming the column for deaths is named Number.of.reported.deaths.of.cholera

top_10countries_deaths <- cholera_data %>%
  group_by(Countries..territories.and.areas) %>%
  summarise(TotalDeaths = sum(as.numeric( Number.of.reported.deaths.from.cholera), na.rm = TRUE)) %>%
  arrange(desc(TotalDeaths)) %>%
  top_n(10, TotalDeaths)

# ggplot
top_10countries_deaths_plot <- ggplot(top_10countries_deaths, aes(x = Countries..territories.and.areas, y = TotalDeaths)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Countries with the Highest Cholera Deaths",
       x = "Country",
       y = "Total Deaths of Cholera") +
  scale_y_continuous(labels = scales::comma) +  # Adding commas in y-axis labels
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Convert the static plot to an interactive plot using plotly
interactive_plot_deaths <- ggplotly(top_10countries_deaths_plot)

# Display the interactive plot
interactive_plot_deaths
########################################################
#report for lST 

#  most year has cases and deaths
current_year <- as.numeric(format(Sys.Date(), "%Y"))
start_year <- current_year - 75

filtered_data <- cholera_data %>%
  filter(Year >= start_year)  # Assuming there is a 'Year' column

# Summarize total cases and total deaths by year
summary_data <- filtered_data %>%
  group_by(Year) %>%
  summarise(TotalCases = sum(Number.of.reported.cases.of.cholera, na.rm = TRUE),
            TotalDeaths =  sum(as.numeric(Number.of.reported.deaths.from.cholera), na.rm = TRUE))

# Reshape the data for plotting
summary_data_long <- summary_data %>%
  pivot_longer(cols = c(TotalCases, TotalDeaths), names_to = "Metric", values_to = "Count")

# ggplot
summary_plot <- ggplot(summary_data_long, aes(x = Year, y = Count, color = Metric, group = Metric)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  labs(title = "Cholera Cases and Deaths Over  Years",
       x = "Year",
       y = "Count",
       color = "Metric") +
  scale_y_continuous(labels = scales::comma) +  # Adding commas in y-axis labels
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Convert the static plot to an interactive plot using plotly
interactive_summary_plot <- ggplotly(summary_plot)


install.packages("ggplotlyExtra")
# Display the interactive plot
interactive_summary_plot
#@!==============---0000000---------------0---------------0000-----------------
# Half page report


library(rmarkdown)
library(cli)

# Default cholera dataset
#cholera data
#``````````````````````````

# Function to generate report

generate_report <- function() {
  # Prompt the user to enter a country name
  country_name <- readline(prompt = "Enter the country name: ")
  
  # Filter the data for the entered country
  country_data <- cholera_data %>% filter(Countries..territories.and.areas == country_name)
  
  # Check if any data is available for the country
  if (nrow(country_data) == 0) {
    cli::cli_alert_danger(paste("No data available for the specified country:", country_name))
    return(NULL)
  }
  
  # Summarize key metrics
  total_cases <- sum(country_data$Number.of.reported.cases.of.cholera, na.rm = TRUE)
  total_deaths <- sum(as.numeric(country_data$Number.of.reported.deaths.from.cholera), na.rm = TRUE)
  cfr <- (total_deaths / total_cases) * 100
  num_outbreaks <- nrow(country_data)
  
  # Create a new R Markdown file for the report
  #rmarkdown::draft("cholera_summary.Rmd", template = "html_document", package = "rmarkdown", edit = FALSE)
  
  # Content for the R Markdown report
  report_content <- paste0("
---
title: \"Cholera Outbreak Report for ", country_name, "\"
author: \"AMR Epidemiology Team \"
output: html_document
---

## Country: ", country_name, "

### Cholera Outbreak Overview
- *Total Cases Reported*: ", total_cases, "
- *Total Deaths*: ", total_deaths, "
- *Case Fatality Rate (CFR)*: ", round(cfr, 2), "%
- *Number of Outbreaks*: ", num_outbreaks, "

### Key Trends
- Significant outbreaks in the following years: ", paste(unique(country_data$Year), collapse = ", "), ".

### Recent Trends
- The most recent outbreak in ", max(country_data$Year), " had ", sum(country_data$Number.of.reported.cases.of.cholera[country_data$Year == max(country_data$Year)]), " cases.
")
  
  # Write the content to the R Markdown file
  cat(report_content, file = "cholera_summary.Rmd")
  
  # Render the report to HTML
  rmarkdown::render("cholera_summary.Rmd")
  cli::cli_alert_success(paste("Report generated successfully for", country_name, "!"))
}

# Main program loop
generate_report()
