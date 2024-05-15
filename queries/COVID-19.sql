/* 
COVID-19 Worldwide Data Exloration

Using - Joins, CTE, Temp Tables, Windows functions, Aggregate functions, creating views, Converting data types
*/

-- update the existing date values in the "date" column to an appropriate date format 

update PortofolioProject..CovidDeaths 
SET date = CONVERT(date, date, 103)

update PortofolioProject..CovidVaccinations
SET date = CONVERT(date, date, 103)

select * from PortofolioProject..CovidDeaths
where continent <> ''
order by 3,4


-- 1) What is the Mortality rate - total deaths divided by total cases 

Select location
		,date
		,total_cases
		,total_deaths
		,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS mortality_rate
from PortofolioProject..CovidDeaths
where continent <> ''
order by 1,2

-- 2) What percentage of the population got covid

Select location
		,date
		,population
		,total_cases
		,(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS percentPopulationInfected
from PortofolioProject..CovidDeaths
where continent <> ''
order by 1,2

-- 3) What country has the highest infection rate compared to population

Select location
		,population
		,max(total_cases) as HighestInfectionCount
		,MAX((CONVERT(float, total_cases)/NULLIF(CONVERT(float, population), 0)))*100 as
		PercentpopulationInfected
from PortofolioProject..CovidDeaths
where continent <> ''
group by location, population
order by 4 desc

-- 4) What country has the highest death rate per population

Select location
		,max(CONVERT(float, total_deaths)) as TotalDeathCount
		,MAX((CONVERT(float, total_deaths)/NULLIF(CONVERT(float, population), 0)))*100 as PercentPopulationDied
from PortofolioProject..CovidDeaths
where continent <> ''
group by location
order by 3 desc

-- 5) What country has the highest death count

Select location
		,max(CONVERT(float, total_deaths)) as TotalDeathCount
from PortofolioProject..CovidDeaths
where continent <> ''
group by location
order by 2 desc

-- 6) What continent has the highest death count

select continent
		,sum(CONVERT(float, new_deaths)) as TotalDeathCount
from PortofolioProject..CovidDeaths
where continent <> ''
group by continent
order by 2 desc


-- 7) What are the global cases for each day

Select  date 
		,sum(convert(float, new_cases)) as total_cases
		,sum(convert(float, new_deaths)) as total_deaths
		, sum(convert(float, new_deaths))/ sum(NULLIF(convert(float, new_cases),0))*100 as DeathPercentage
from PortofolioProject..CovidDeaths
where continent <> ''
group by date
order by 1


-- 8) What is the rolling count of people vaccinated, meaning after each day what is the total number of vaccinated people
-- using CTE

with popvsvac (continent, location, date, population, new_vaccinations, rollingpeoplevaccinated)
as
(Select dea.continent
		,dea.location
		,dea.date
		,dea.population
		,vac.new_vaccinations 
		,sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
join PortofolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> '')

select * , (rollingpeoplevaccinated/nullif(population,0))*100 as PercPopVacc
from popvsvac
order by 1,2,3


-- 9) What is the rolling count of people vaccinated, meaning after each day what is the total number of vaccinated people
-- using TempTable

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date nvarchar(255),
Population nvarchar(255),
new_vaccinations nvarchar(255),
rollingpeoplevaccinated numeric)

insert into #PercentPopulationVaccinated
Select  dea.continent
		,dea.location 
		,dea.date
		,dea.population
		,vac.new_vaccinations 
		,sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
join PortofolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ''

select * , (rollingpeoplevaccinated/nullif(convert(float,population),0))*100 as PercPopVacc
from #PercentPopulationVaccinated
order by continent, location, date


-- 10) Create views to store our results and later use for visualizations 

Create View PercentPopulationVaccinated as
Select dea.continent
		,dea.location
		,dea.date, dea.population
		,vac.new_vaccinations 
		, sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
join PortofolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent <> ''

Create View GlobalNumbers as
Select  date
		,sum(convert(float, new_cases)) as total_cases
		,sum(convert(float, new_deaths)) as total_deaths
		,sum(convert(float, new_deaths))/ sum(NULLIF(convert(float, new_cases),0))*100 as DeathPercentage
from PortofolioProject..CovidDeaths
where continent <> ''
group by date

