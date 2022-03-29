Select *
From [Portfolio project]..coviddeaths
Where continent is not null
order by 3,4

--Select *
--From [Portfolio project]..covidvaccines
--order by 3,4

-- Select data that is going to be used

Select Location, date, Total_cases, new_cases, total_deaths, population
From [Portfolio project]..coviddeaths
Order by 1,2

-- Looking at total cases vs total deaths
-- Shows likelihood of dying if you are to catch Covid-19 in your country

Select location, date, Total_cases,total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
From [Portfolio project]..coviddeaths
Where location like '%states%'
Order by 1,2

-- Looking at total cases vs population
-- Shows how much of the population has gotten Covid

Select location, date, Total_cases,population, (total_cases/population)*100 as PercentPopulationInfected
From [Portfolio project]..coviddeaths
--Where location like '%states%'
Order by 1,2

-- Looking at countries with Highest infection rates compared to population

Select location, population, MAX(Total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio project]..coviddeaths
--Where location like '%states%'
GROUP BY location, population
Order by PercentPopulationInfected desc

-- Showing countries with highest death count per population

Select location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From [Portfolio project]..coviddeaths
--Where location like '%states%'
Where continent is not null
GROUP BY location
Order by TotalDeathCount desc


-- breaking things down by continent


-- Showing continetns with the highest death count

Select location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From [Portfolio project]..coviddeaths
--Where location like '%states%'
Where continent is null
GROUP BY location
Order by TotalDeathCount desc


-- Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as Deathpercentage
From [Portfolio project]..coviddeaths
--Where location like '%states%'
Where continent is not null
--Group by date
Order by 1,2

--Looking at total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(bigint,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
From [Portfolio project]..coviddeaths dea
Join [portfolio project]..covidvaccines vac
	on dea.location = vac.location
	and dea.date = vac.date
	Where dea.continent is not null
Order by 2,3

--Using CTE

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(bigint,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
From [Portfolio project]..coviddeaths dea
Join [portfolio project]..covidvaccines vac
	on dea.location = vac.location
	and dea.date = vac.date
	Where dea.continent is not null
--Order by 2,3
)
Select *, (rollingpeoplevaccinated/population)*100
From PopvsVac

-- Temp table

Drop table if exists #Percentpopulationvaccinated
Create table #Percentpopulationvaccinated
(
continent nvarchar(255),
Location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric,
)

Insert into #Percentpopulationvaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(bigint,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
From [Portfolio project]..coviddeaths dea
Join [portfolio project]..covidvaccines vac
	on dea.location = vac.location
	and dea.date = vac.date
	Where dea.continent is not null
--Order by 2,3

Select *, (rollingpeoplevaccinated/population)*100
From #Percentpopulationvaccinated

-- Creating view to store data for visualizations

Create view Percentpopulationvaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(bigint,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
From [Portfolio project]..coviddeaths dea
Join [portfolio project]..covidvaccines vac
	on dea.location = vac.location
	and dea.date = vac.date
	Where dea.continent is not null
--Order by 2,3

Select * 
From Percentpopulationvaccinated