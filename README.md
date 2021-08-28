# COVID dataset Exploration and Visualization


## Objective

This has been used continously to enure that the right data has been selected, transformed and used in the data visualization which is meant to be passed on the business users.

**"As a data analyst working at any company you are asked to visualize data that will help readers understand how countries are affected with the current COVID situation which has affected every one in the World and also a representation of the death rate of countries.**

## Prepare and Process

The necessary data was first downloaded from an open source website [World in Data](https://ourworldindata.org/covid-deaths). Then the dataset was transformed into two separate dataset for a better understanding. This two data then put into the SQL database for even more exploration.

**Following are the queries for data exploration:**

```SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

-- SELECT DATA THAT WE ARE GOING TO BE STARTING WITH

SELECT
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2


-- TOTAL CASES VS TOTAL DEATHS
-- SHOWS LIKELIHOOD OF DYING IF YOU CONTRACT COVID IN YOUR COUNTRY

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%'
    AND continent IS NOT NULL
ORDER BY 1,2
```

**Following queries where for the final dashboard in Tableau Desktop:**

```-- FIRST QUERY. 

SELECT 
    SUM(new_cases) AS total_cases, 
    SUM(cast(new_deaths AS int)) AS total_deaths, 
    SUM(cast(new_deaths AS int))/SUM(New_Cases)*100 AS DeathPercentage
FROM CovidDeaths
--Where location like '%states%'
WHERE continent IS NOT NULL 
--Group By date
ORDER BY 1,2

-- SECOND QUERY. 

-- WE TAKE THESE OUT AS THEY ARE NOT INCLUDED IN THE ABOVE QUERIES ADN WANT TO STAY CONSISTENT
-- EUROPEAN UNION IS A PART OF EUROPE

SELECT 
    location, 
    SUM(cast(new_deaths AS int)) AS TotalDeathCount
From CovidDeaths
```

## Analyze

As this is a view where dimensions and facts have been combined, the data model that is created in Tableau is one table. The query from previous step was loaded in and ran through the dataset to get the desirable dataset and that data is loaded into the Tableau directly.

**Calculation**

Number of Cases: COUNT(data)<br>
Number of Total Death = COUNT([death])

## Share

The finsished dashboard consist of visualization of COVID deaths and infection rates through out the world that gives an easy option for the end users to navigate the data and observe the condition.

#### **Click the picture to open the dashboard and try it out!**

<a href="https://public.tableau.com/views/CovidDashboard_16289650980760/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link">
  <img src="pic 1.png" alt="COVID data" width="800" height="500" />
</a>
