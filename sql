/*
COVID 19 DATA EXPLORATION
Skills used: Joins,Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT *
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


-- TOTAL CASES VS POPULATION
-- SHOWS WHATS PERCENTAGE OF POPULATION INFECTED WITH COVID

SELECT
    Location,
    date,
    Population,
    total_cases,
    (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

SELECT
    location,
    Population,
    MAX(total_cases) as HighestInfectionCount,
    Max((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC


-- COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT
    location,
    MAX(cast(Total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- BREAKING THINGS DOWN BY CONTINENT

-- SHOWING CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT
    continent,
    MAX(cast(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY totalDeathCount DESC

-- GLOBAL NUMBERS

SELECT
    SUM(new_cases) AS total_cases,
    SUM(cast(new_deaths AS INT)) AS total_deaths,
    SUM(cast(new_deaths AS INT))/SUM(New_Cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
WHERE continent IS NOT NULL
--Group By date
ORDER BY 1,2

-- TOTAL POPULATION VS VACCINATIONS
-- SHOWS PERCENTAGE OF POPULATION THAT HAS RECEIVED AT LEAST ONE COVID VACCINE

SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations
    ,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3
