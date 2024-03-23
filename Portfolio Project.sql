
select*
from PortfolioProject..covidDeath

select*
From CovidDeath
Where continent is not null

select*
from PortfolioProject..CovidVaccination
Where continent is not null
Order by 3,4

--Looking at the datas we will be working with

select continent, location, date, population, total_cases, new_cases, total_deaths, new_deaths
From CovidDeath
Where continent is not null
Order by 2 Asc,3 asc

--Looking at the total cases vs total death
--Shows the likelihood of dying if you contacted covid

select location, date, population, total_cases,(Cast(total_deaths as int)) Totaldeath, ((Cast(total_deaths as int)) / total_cases)*100 AS DeathPercentage
From CovidDeath
Where continent is not null
--And location Like '%Nigeria%'
Order by 1,3 desc


--Looking at the total cases vs the Population

select location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulation
From CovidDeath
--Where location Like '%Nigeria%'
Order by 1,2

--Looking at countries with highest infection rate compared to population

select location, population, max(total_cases) Highestinfectioncount, Max((total_cases/population))*100 AS PercentPopulation
From CovidDeath
--Where location Like '%Nigeria%'
Group by location, population
Order by PercentPopulation desc

--Showing countries with highest death count per population

select location, max(Cast(total_deaths as int)) Totaldeathcount
From CovidDeath
--Where location Like '%Nigeria%'
Where continent is not null
Group by location
Order by Totaldeathcount desc

--Let's break things down by continent

select continent, max(Cast(total_deaths as int)) Totaldeathcount
From CovidDeath
--Where location Like '%Nigeria%'
Where continent is not null
Group by continent
Order by Totaldeathcount desc

--Showing the continent with the highest death count per population

select continent, max(Cast(total_deaths as int)) Totaldeathcount
From CovidDeath
--Where location Like '%Nigeria%'
Where continent is not null
Group by continent
Order by Totaldeathcount desc


--Global Numbers

select date, Sum(new_cases) As Sumnewcases, Sum(new_Deaths) Sumnewdeaths--(Cast(total_deaths as int)) Totaldeath, ((Cast(total_deaths as int)) / total_cases)*100 AS DeathPercentage
From CovidDeath
Where continent is not null
--And location Like '%Nigeria%'
Group by Date
Order by 1 desc

--Looking at total population vs vaccination

Select CV.continent, CV.location, CV.date, CD.population, CD.new_cases, CV.new_vaccinations
, SUM(Convert(Int,new_vaccinations)) OVER (Partition by CD.Location order by CD.Location, CD.Date) as RollingPeopleVaccinated
From CovidVaccination CV
Join CovidDeath CD
On CV.location = CD.location
And CV.date = CD.date
Where CV.Continent is not null
Order by 2,3


--using CTE

With PopvsVac (CV.continent, CV.location, CV.date, CD.population, CD.new_cases, CV.new_vaccinations)
as
(Select CV.continent, CV.location, CV.date, CD.population, CD.new_cases, CV.new_vaccinations
, SUM(Convert(Int,new_vaccinations)) OVER (Partition by CD.Location order by CD.Location, CD.Date) as RollingPeopleVaccinated
From CovidVaccination CV
Join CovidDeath CD
On CV.location = CD.location
And CV.date = CD.date
Where CV.Continent is not null
Order by 2,3
)

--Creating View to store datas for leter visualizations

Create View MYVIEW AS
select continent, max(Cast(total_deaths as int)) Totaldeathcount
From CovidDeath
--Where location Like '%Nigeria%'
Where continent is not null
Group by continent



