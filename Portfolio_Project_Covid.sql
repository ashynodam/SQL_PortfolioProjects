Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2


-- Looking for Total Cases Vs Deaths

Select Location, date, total_cases, total_deaths, 
(total_deaths/total_cases)*100as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%Nigeria%'
and continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, 
(total_deaths/total_cases)*100as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

-- Looking at total  cases vs population

Select Location, date, total_cases, population, 
(total_cases/population)*100as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%Nigeria%'
order by 1,2

--Countries with the highest infection rate compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount, 
MAX((total_cases/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
group by location, population
order by PercentagePopulationInfected desc


-- Showing the countries with the Highest Death COunts per Population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
group by location
order by TotalDeathCount desc

--Let's Break things down by continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
group by continent
order by TotalDeathCount desc



--Showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentages
--(total_deaths/total_cases)*100as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%Nigeria%'
Where continent is not null
group by date
order by 1,2

--Global Percentatge Cases

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentages
--(total_deaths/total_cases)*100as DeathPercentage
From PortfolioProject..CovidDeaths
--where location like '%Nigeria%'
Where continent is not null
--group by date
order by 1,2


--JOINING
Select *
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

--Looking at total population vs Population

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.location like '%Nigeria%'
And dea.continent is not null
order by 2,3

--Doing a partition

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.location like '%Nigeria%'
Where dea.continent is not null
order by 2,3

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.location like '%Nigeria%'
Where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



--Temp Table

DROP Table if exists #PPV
Create Table #PPV (
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PPV
Select dea.Continent, dea.Location, dea.date, dea.Population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.Location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.location like '%Nigeria%'
Where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PPV




--Creating View to store data for later Visualizations

Create View PPV as
Select dea.Continent, dea.Location, dea.date, dea.Population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.Location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.location like '%Nigeria%'
Where dea.continent is not null
--order by 2,3

Select *
From PPV
