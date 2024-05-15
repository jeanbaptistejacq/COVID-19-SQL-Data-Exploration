# COVID-19-SQL-Data-Exploration
![Center for diseases and prevention](https://github.com/jeanbaptistejacq/COVID-19-SQL-Data-Exploration/assets/80902643/28aaf8a7-bb0a-4d15-99cf-93e7153244bc)
This project focuses on analyzing data related to the COVID-19 pandemic using SQL queries. 
We will be working with a dataset that provides information about COVID-19 cases, deaths, population, and 
vaccinations across different locations and continents. The main objective is to gain valuable insights and answer important questions about the pandemic.
## Content

[1. Getting Started](#getting-started)  
&emsp;[1.1 Requirements](#requirements)  
[2. Download and Installation](#download-and-installation)  
[3. Data Source](#data-source)  
[4. Data Exploration Process](#data-exploration-process)  
[5. License](#license)  

## Getting Started

The following instructions will help you get a copy of this project and execute the queries to observe the result sets they generate.

### Requirements

You need to have any DBMS (Database Management System) installed on your system that supports the standard SQL syntax and functions, such as MySQL, PostgreSQL, Microsoft SQL Server **(the one I used)**, Oracle, or others.

## Download and Installation

1. You can clone this repository or simply download the .zip file by clicking on 'Code' -> 'Download ZIP' at <https://github.com/jeanbaptistejacq/COVID-19-SQL-Data-Exploration>.

2. Once you have all the files of this project, you can find the dataset in different tables in excel files in the 'tables' folder. They need to be imported into a new database or an existing one so the queries can be executed against them.

3. Open your SQL DB Manager, create a new database or use an existing one to import the excel files into tables. The steps may vary depending on the DB manager you are using. Here is a general approach: In your DB manager, locate the option to import data from a file or external source ->
Select the Excel files one by one and follow the prompts to specify the target table and mapping of columns ->
Verify that the data has been imported successfully by checking the table contents.

4. The queries I wrote for this project can be found in the 'queries' folder. You can open the file directly to run them or create new query windows to copy/paste them into the editor.  

5. Execute the query you want to retrieve the desired results.  

**Note:** Please ensure you have a valid database connection established in your DB manager before executing the queries. Adjust the queries if needed based on the structure of the imported tables.

## Data Source

The original dataset I used for this project can be found and downloaded from <https://ourworldindata.org/covid-deaths>.

For this project, I've altered the original dataset, condensing it into two tables located in the 'tables' folder. Additionally, I've restricted the data to entries between January 1 2020 and April 30 2021.

## Data Exploration Process

Here is a summary of the queries and the insights they provide:

1. Mortality Rate: This query calculates the percentage of deaths in relation to the total number of cases. It helps us understand how severe the virus is in different locations and continents.

2. Percentage of Population Infected: This query determines the percentage of the population that has contracted COVID-19. By comparing the total number of cases to the population size, we can evaluate the spread of the virus in various regions.

3. Highest Infection Rate: This query identifies the country with the highest infection rate in proportion to its population. It calculates the percentage of the population that has been infected and highlights the location with the highest value.

4. Highest Death Rate: This query identifies the country with the highest death rate per population. It calculates the percentage of the population that has died due to COVID-19 and highlights the location with the highest mortality rate.

5. Country with the Highest Death Count: This query determines the country that has experienced the highest total number of deaths. It provides insights into the countries most impacted by the virus.

6. Continent with the Highest Death Count: This query identifies the continent with the highest total number of deaths. It helps us understand the overall impact of the pandemic on a larger scale.

7. Global Cases per Day: This query presents the daily global COVID-19 cases, including the total number of new cases and new deaths. It also calculates the death rate as a percentage of new cases, giving us an indication of the severity of the virus over time.

8. Rolling Count of People Vaccinated: This query calculates the cumulative count of vaccinated individuals on each day. It tracks the total number of people vaccinated and presents it alongside the population size. Additionally, it shows the percentage of the population that has received the vaccine.

Some SQL techniques used in this project include joins, CTEs, temp tables, window functions, and aggregate functions to derive insights from the data. In addition to the SQL queries, this project involves creating views to store the results of our analyses. These views can be used for further exploration, data visualization, and reporting purposes.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
