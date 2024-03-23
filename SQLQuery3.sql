

Select*
from PortfolioProject..CovidDeath
Order by 3,4



--Select*
--from PortfolioProject..CovidDeath
--Order by 3,4

--Select the data that we are going to be using



Select Location, date, total_cases, new_cases,total_Deaths, Population
from PortfolioProject..CovidDeath
Order by 1,2


--Looking at the total cases vs total deaths

Select Location, date, total_cases,total_Deaths,population
from PortfolioProject..CovidDeath
where Location like '%Nigeria%'
Order by 1,2

--Looking at the total cases vs the population

Select Location, date, total_cases,population, (total_cases/Population)*100 as DeathPercentage
from PortfolioProject..CovidDeath
--where Location like '%state%'
Order by 1,2

--Looking at countries with highest infection rate compared to population

Select Location,population, Max(total_cases) as MTC, Max((total_cases/Population))*100 as Percentpopulation
from PortfolioProject..CovidDeath
--where Location like '%state%'
Order by 1,2
