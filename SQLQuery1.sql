Select *
From [Portfolio project]..[.dbo covid deaths]
Order by 3,4


--Select *
--From [Portfolio project]..[.dbo covid vaccinations]
--Order by 3,4

-- Select data being used

Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio project]..[.dbo covid deaths]
Order by 1,2

--Looking at total cases vs. total deaths

Select Location, date, total_cases, (total_deaths/total_cases)
From [Portfolio project]..[.dbo covid deaths]
Order by 1,2