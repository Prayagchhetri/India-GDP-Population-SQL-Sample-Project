
--  : Create The Table1

create table india
( State varchar(50)  , "1990" float null,"1991" float null,
"1992" float null,"1993" float null,
"1994" float null,"1995" float null,
"1996" float null,"1997" float null, 
"1998" float null,"1999" float null,
"2000" float null,"2001" float null,
"2002" float null,"2003" float null,"2004" float null,"2005" float null,
"2006" float null,"2007" float null,"2008" float null,"2009" float null,"2010" float null,
"2011" float null,"2012" float null,"2013" float null,"2014" float null,"2015" float null,
"2016" float null,"2017" float null,"2018" float null,"2019" float null,"2020" float null,
"2021" float null,"2022" float null, category varchar(50) null)


 -- Insert the data

bulk Insert india
from 'C:\Users\prayag\Desktop\India GDP, Population\india.csv'
with (format='csv')


Select * from india 


--  : Create The Table2

Create table Population
( State varchar(50) , "1951" float null,"1961" float null,
"1971" float null,"1981" float null,
"1991" float null,"2001" float null,
"2011" float null,"2021" float null, Data varchar(200) )


-- : Insert the data 

bulk Insert Population
from 'C:\Users\prayag\Desktop\India GDP, Population\population.csv'
with (format='csv')


Select * from Population


--Query 1 :  Fetch the top 5 states with the highest GSDP for the year 2018

Select top(5) State, "2018" as GSDP
from india
where category = 'Gross State Domestic Product'
order by GSDP  desc

--Query 2 : Show the state with the maximum Pension for the year of 2004.

Select top(1) State  ,  "2004" as max_pension_2004 
from india 
Where category = 'Pension' 
Group by state, "2004"
order by max_pension_2004 desc


--Query 3 : West Bengal difference in urban and rural population in percentages for the year of 2001

Select
(
Select "2001" as rural_p_wb 
from Population
where Data = 'Population in Rural Area' and state = 'West bengal'
) - 
(
Select "2001" as urban_p_wb 
from Population
where Data = 'Population in Urban Area' and state = 'West bengal'
) 
as Dif_urb_rur_wb 



--Query 4 : Fetch the 5 states with least VAC for the year 1999. Ignore Null values.

Select top(5) State, "2018" as VAC
from india
where category = 'Value Added by Construction'
order by VAC asc


--Query 5 : Which is the highest literacy rate in Gujarat?

Select state , 
( Select max(Population)
from (VALUES ([1951]),([1961]),([1971]),([1981]),([1991]),([2001]),([2011]),([2021]))
as littab(Population)) as lit_rate_max
 from population
 where state = 'Gujarat' and data = 'literacy rate'




--Query 6 : Fetch the state with the highest Per Capita Income from 1995 

Select top(1) State , max("1995")as PCI
from india 
Where category = 'Per Capita Income' 
Group by state
order by max("1995") desc


--Query 7 : Fetch the state with highest population and the highest Gross Fiscal Deficit for 2011.

Select 
( Select top(1) State 
From Population 
where data = 'Total Population' 
order by "2011" Desc)
as high_Popul, 
( Select top(1) State 
From india 
where category = 'Gross Fiscal Deficit' 
order by "2011" Desc)
as high_GFD


-- Query 8 : Write state names where the Sex ratio is more than 880 and order it by sex ratio descending for the year 2011.

Select state, "2011" as Sex_r
from Population
where data= 'Sex ratio' and "2011" > 880
order by Sex_r Desc


--Query 9 : Fetch the states with the Decadal Growth more than 50% for the year 1981.

Select state
from Population
where data= 'Decadal Growth' and "1981" > 50


