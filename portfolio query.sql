select * from portfolio.coviddeaths
where continent is not null
order by 3 ,4
/*testing whether all info is there*/

select * from portfolio.covidvaccinations
where continent is not null
order by 3,4
/*testing whether all info is there*/

select location, date, total_cases, new_cases, total_deaths, population
from portfolio.coviddeaths
order by 1,2

/* analyzing total cases vs total deaths.
shows the chances of dying if infected Covid*/
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
from portfolio.coviddeaths
where location = 'Indonesia'
order by 1 ,2

/* total cases vs Population 
shows percentage of population in indonesia got covid*/
select location, date, total_cases, population, (total_cases/population)*100 as 'Infected Percentage'
from portfolio.coviddeaths
where location = 'Indonesia'
order by 1 ,2

/*countries with highest infection percentage rate compared to population*/
select location, population, Max(total_cases) as 'Highest Infection Number' , Max((total_cases/population))*100 as 'Percent population Infected'
from portfolio.coviddeaths
where continent is not null
group by location, population
order by 4 desc

/* countries with the highest Deathcount per population */
select location, MAX(cast(total_deaths as unsigned)) as 'Total Death Count' 
from portfolio.coviddeaths
group by location
order by 2 desc

/*continents with the highest deathcount */
select continent, MAX(cast(total_deaths as unsigned)) as 'Total Death Count'
from portfolio.coviddeaths
where continent is not null
group by continent
order by 2 desc

/*International statistic stuff*/

/*death percentage globally*/
select date, sum(new_cases) as 'total cases', sum(cast(new_deaths as unsigned)) as 'total deaths',
(sum(cast(new_deaths as unsigned))/sum(new_cases)*100) as 'Death Percentage'
from portfolio.coviddeaths
group by date

/* total cases & deaths overall and also percentage of death if infected */
select  sum(total_cases) as 'total cases', sum(cast(total_deaths as unsigned)) as 'total deaths',
(sum(cast(total_deaths as unsigned))/sum(total_cases)*100) as 'Death Percentage'
from portfolio.coviddeaths

/* joining covid.deaths and covid.vaccinations (two table) */
/* looking at total population vs vaccinated people */
select dth.continent, dth.location, dth.date, dth.population, vcc.new_vaccinations
from  portfolio.coviddeaths as dth
join portfolio.covidvaccinations as vcc
on dth.location = vcc.location
and dth.date = vcc.date
order by 2, 3




