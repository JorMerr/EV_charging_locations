--- CLEANING THE DATA


------------------------------------------------------------------------------
-----------------------------------------------------------------------------

			-- CLEANING CANADA INCOME DATASET

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS Income_table

-- show all columns 
SELECT * FROM income_table;
SELECT COUNT(*) FROM income_table


-- drop un-necessary columns(UOM,SYMBOL,TERMINATED,DECIMALS,STATS)

ALTER TABLE income_table
DROP COLUMN UOM, UOM_ID,
VECTOR, COORDINATE, STATUS, SYMBOL, TERMINATED, DECIMALS;

-- DELETE ALL Geographic locations where GEO COLUMN = TO CANADA

DELETE  FROM income_table
WHERE GEO = 'Canada';

-- checking the columns with all provinces 
-- dataset does not include provinces like Yukon,Northwest Territories,Nunavut
-- show all columns 
SELECT * FROM income_table
WHERE GEO = 'Atlantic provinces';

-- DELETE ALL Geographic locations where GEO COLUMN = TO Atlantic provinces
DELETE  FROM Income_table
WHERE GEO = 'Atlantic provinces';

-- DELETE ALL Geographic locations where GEO COLUMN = TO Prairie provinces
DELETE  FROM Income_table
WHERE GEO = 'Prairie provinces';

-- renaming VALUE columns to Total 

sp_RENAME 'income_table.VALUE' , 'TOTAL', 'COLUMN';

sp_RENAME 'income_table.TOTAL' , 'Total_Income', 'COLUMN';


-- renaming the statistics column to Median Income
sp_RENAME 'income_table.Statistics' , 'Median_Income', 'COLUMN';

-- selecting only Median income 

SELECT DISTINCT * 
FROM income_table
WHERE Median_Income  NOT LIKE 'Median income (excluding zeros)'
ORDER BY Total_Income desc

-- delete the rest of information other than median income 
DELETE
FROM income_table
WHERE Median_Income  NOT LIKE 'Median income (excluding zeros)'

-- drop scalar_id column 

ALTER TABLE income_table
DROP COLUMN SCALAR_ID

ALTER TABLE income_table
DROP COLUMN SCALAR_FACTOR

-- DROP NULL VALUES FROM TOTAL INCOME

DELETE
FROM income_table
WHERE Total_Income  IS NULL

-- dropping Median_Income

ALTER TABLE income_table
DROP COLUMN Median_Income

-- separating city and provinces
-- update table with the new columns 
-- replace empty space with city names


SELECT *  FROM income_table;

-- CHANGE GEO COLUMNS 
-- renaming GEO columns field 

-- REPLACING Qu�bec, Quebec TO Qu�bec City, Quebec
SELECT *  FROM income_table
WHERE Province  LIKE '%Alberta%';

UPDATE income_table
SET GEO = REPLACE(GEO,'Qu�bec, Quebec','Qu�bec City, Quebec')

-- REPLACING Ottawa-Gatineau, Ontario/Quebec TO Ottawa, Ontario
UPDATE income_table
SET GEO = REPLACE(GEO,'Ottawa-Gatineau, Ontario/Quebec','Ottawa-Gatineau, Ontario')

-- changing the names of all GEO locations 
-- REPLACING Newfoundland and Labrador TO Newfoundland and Labrador,Newfoundland and Labrador
-- Prince Edward Island to Prince Edward Island,Prince Edward Island
-- Nova Scotia to Nova Scotia,Nova Scotia
-- New Brunswick to New Brunswick,New Brunswick
-- Quebec to Quebec,Quebec
-- Ontario to Ontario,Ontario
-- Manitoba to Manitoba,Manitoba
-- Saskatchewan to Saskatchewan,Saskatchewan
-- Alberta to Alberta,Alberta
-- British Columbia to British Columbia
UPDATE income_table
SET GEO = REPLACE(GEO,'Newfoundland and Labrador','Newfoundland and Labrador,Newfoundland and Labrador')

UPDATE income_table
SET GEO = REPLACE(GEO,'Prince Edward Island','Prince Edward Island,Prince Edward Island')

UPDATE income_table
SET GEO =  REPLACE(GEO,'Nova Scotia','Nova Scotia, Nova Scotia')

UPDATE income_table
SET GEO = REPLACE(GEO,'Quebec','Quebec, Quebec')
 
 UPDATE income_table
SET GEO = REPLACE(GEO,'Ontario','Ontario, Ontario')

 UPDATE income_table
SET GEO = REPLACE(GEO,'Manitoba','Manitoba,Manitoba')

UPDATE income_table
SET GEO = REPLACE(GEO,'Saskatchewan','Saskatchewan,Saskatchewan')

UPDATE income_table
SET GEO = REPLACE(GEO,'Alberta','Alberta,Alberta')

UPDATE income_table
SET GEO = REPLACE(GEO,'British Columbia','British Columbia,British Columbia')

UPDATE income_table
SET GEO = REPLACE(GEO,'New Brunswick','New Brunswick,New Brunswick');



SELECT *
,RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO)) AS Province
FROM income_table;

-- ,LEFT(GEO,CHARINDEX(',',GEO)) AS City

ALTER TABLE Income_table 
ADD Province NVARCHAR(255)

UPDATE Income_table 
-- SET City = LEFT(GEO,CHARINDEX(',',GEO)),
SET Province = RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO))

SELECT DISTINCT Province FROM income_table;

-- changing the province column 
SELECT *
,RIGHT(Province,LEN(Province) - CHARINDEX(',',Province)) AS Province2
FROM income_table;

-- Creating Province2 column
ALTER TABLE Income_table 
ADD Province2 NVARCHAR(255)

UPDATE Income_table 

SET Province2 = RIGHT(Province,LEN(Province) - CHARINDEX(',',Province))


UPDATE Income_table 

SET Province = Province2

-- drop provinces columns 

ALTER TABLE income_table
DROP COLUMN Province2

-- show all columns 
SELECT * FROM income_table;

SELECT DISTINCT * 
FROM income_table

-- Extracting Cities  from GEO 
ALTER TABLE Income_table 
ADD City NVARCHAR(255)

SELECT *,
LEFT(GEO,CHARINDEX(',',GEO) -1) AS City
FROM income_table;

UPDATE Income_table 
SET City = LEFT(GEO,CHARINDEX(',',GEO) -1) 

-- drop GEO column
ALTER TABLE income_table
DROP COLUMN GEO

-- trim DGUID to keep the last 6 digits
SELECT Province,DGUID, 
LEFT(DGUID,4) as tobe_dropped,
RIGHT(DGUID,LEN(DGUID)-4) AS to_keep
FROM income_table;

-- Extracting UID  from TABLE
ALTER TABLE Income_table 
ADD UID NVARCHAR(255)


UPDATE Income_table 
SET UID = RIGHT(DGUID,LEN(DGUID)-4)

-- Drop DGUID COLUMN 
ALTER TABLE Income_table
DROP COLUMN  DGUID

-- checking the cleaned dataset
SELECT * 
FROM Income_table


-----------------------------End of Cleaning Income_Data set------------






-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

				-- cleaning the population dataset 

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS population_table


-- show all columns 
SELECT * FROM population_table;

SELECT COUNT(*) FROM population_table

-- renaming columns 
sp_RENAME 'population_table.Population_and_dwelling_counts_11' , 'Population', 'COLUMN';
sp_RENAME 'population_table.UID' , 'Province_ID', 'COLUMN';
-- KEPP ONLY population column 

DELETE  FROM population_table
WHERE Population NOT LIKE 'Population, 2021'

-- drop un-necessary columns(UOM,SYMBOL,TERMINATED,DECIMALS,STATS)
ALTER TABLE population_table
DROP COLUMN  UOM_ID,
VECTOR, COORDINATE, STATUS, SYMBOL, TERMINATED, DECIMALS;

ALTER TABLE population_table
DROP COLUMN  SCALAR_FACTOR;

ALTER TABLE population_table
DROP COLUMN  SCALAR_ID;

ALTER TABLE population_table
DROP COLUMN  Population;

-- DELETE ALL Geographic locations where GEO COLUMN = TO CANADA

DELETE  FROM population_table
WHERE GEO = 'Canada';

-- renaming VALUE columns to Total 

sp_RENAME 'population_table.VALUE' , 'TOTAL', 'COLUMN';
sp_RENAME 'population_table.TOTAL' , 'POPULATION', 'COLUMN';
sp_RENAME 'population_table.GEO' , 'Province', 'COLUMN';

-- trim DGUID to keep the last 6 digits

SELECT DGUID, 
LEFT(DGUID,4) as tobe_dropped,
RIGHT(DGUID,LEN(DGUID)-4) AS to_keep
FROM population_table;

-- Extracting UID  from TABLE

ALTER TABLE population_table 
ADD UID NVARCHAR(255)


UPDATE population_table 
SET UID = RIGHT(DGUID,LEN(DGUID)-4)

-- Drop DGUID COLUMN 
ALTER TABLE population_table 
DROP COLUMN  DGUID




SELECT * 
FROM population_table




-----------------------------End of Cleaning Income_Data set------------






-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					--**JOINS** 

					-- creating the new table(final_table) from joins

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
DROP TABLE IF EXISTS final_table

SELECT * FROM final_table

SELECT i.UID,p.Province_ID,i.REF_DATE,i.Age_group,i.Province,i.City,i.Total_Income,i.Income_source, p.POPULATION
INTO 
	final_table
FROM income_table as i
FULL OUTER JOIN population_table as p
ON i.UID = p.Province_ID

------------------------------------------------------------------------

------------- Cleaning the new table final_table------------------------

------------------------------------------------------------------------
-- checking the new table 
---- this information is only for the Province
-- creating city_ID and Province ID 

SELECT * FROM final_table f
WHERE f.Province IS NULL

UPDATE  final_table
SET UID = Province_ID 
WHERE UID IS NULL

UPDATE  final_table
SET REF_DATE = 2021
WHERE REF_DATE IS NULL

UPDATE  final_table
SET Province = 'Northwest Territories'
WHERE UID = 'A000261'

UPDATE  final_table
SET Province = 'Nunavut'
WHERE UID = 'A000262'

UPDATE  final_table
SET Province = 'Yukon'
WHERE UID = 'A000260'

SELECT * FROM final_table
WHERE REF_DATE = 2016 AND Province LIKE 'Newfoundland and Labrador'
SELECT DISTINCT  Income_source 
FROM final_table
WHERE UID LIKE 'A%'

-- keeping one UID, 
-- City IDs starts with S, Province ID starts with A
ALTER TABLE final_table
DROP COLUMN  Province_ID

SELECT * FROM final_table
WHERE City LIKE '%Toronto%'

-- set City name null where Province == to city
SELECT * 
FROM final_table
WHERE UID like 'S%'

UPDATE final_table
SET City = 'NULL' 
WHERE Province = City

UPDATE final_table
SET City = 'NULL' 
WHERE City like '%Nova Scotia%'

UPDATE final_table
SET City = 'NULL' 
WHERE City like '%Quebec%'

UPDATE final_table
SET City = 'NULL' 
WHERE City like '%Ontario%'

-- checking the cleaned data
SELECT *
FROM final_table
WHERE UID like '%A00053520005%'

---------------------- End of Cleaning final_table-------------------- 




-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					--cleaning  Labour Force table 

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

SELECT * FROM lfs_table

WHERE REF_DATE < 2016

-- REMOVING EVERYTHING BEFORE 2016
DELETE 
FROM lfs_table
WHERE REF_DATE < 2016


-- DROPPING UNNCESSARY COLUMNS
ALTER TABLE lfs_table
DROP COLUMN  UOM_ID,SCALAR_ID,VECTOR,COORDINATE,STATUS,SYMBOL,TERMINATED,DECIMALS

-- separating the provinces and cities 
SELECT GEO,DGUID, 
LEFT(DGUID,4) as tobe_dropped,
RIGHT(DGUID,LEN(DGUID)-4) AS to_keep
FROM lfs_table;

-- create a new column to hold City_ID
ALTER TABLE lfs_table
ADD City_ID NVARCHAR(255)


UPDATE lfs_table
SET City_ID = RIGHT(DGUID,LEN(DGUID)-4)


-- City and Province columns
SELECT *,
LEFT(GEO,CHARINDEX(',',GEO) -1) AS City
,RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO)) AS Province
FROM lfs_table;


-- create a new column to hold City and Province
ALTER TABLE lfs_table
ADD City NVARCHAR(255),
Province NVARCHAR(255)


UPDATE lfs_table
SET City = LEFT(GEO,CHARINDEX(',',GEO) -1),
Province=RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO))

-- drop un necessary column 
ALTER TABLE lfs_table
DROP COLUMN GEO, DGUID

-- drop un necessary column 
ALTER TABLE lfs_table
DROP COLUMN column1


-- remain only employment, unemployment, population
SELECT DISTINCT Labour_force_characteristics
FROM lfs_table 

DELETE 
FROM lfs_table 
WHERE Labour_force_characteristics Like '%Not in labour force%'

DELETE 
FROM lfs_table 
WHERE Labour_force_characteristics Like '%Participation rate%'

DELETE 
FROM lfs_table 
WHERE Labour_force_characteristics Like '%Unemployment rate%'

DELETE 
FROM lfs_table 
WHERE Labour_force_characteristics Like '%Employment rate%'

DELETE 
FROM lfs_table 
WHERE Labour_force_characteristics Like '%Labour force%'



UPDATE lfs_table
SET VALUE = VALUE*100
WHERE SCALAR_FACTOR LIKE '%thousands%'

ALTER TABLE lfs_table
DROP COLUMN SCALAR_FACTOR

ALTER TABLE lfs_table
DROP COLUMN UOM


SELECT REF_DATE,City_ID,Province,City,Labour_force_characteristics, VALUE
FROM lfs_table

-- delete cities without city_id(only one city deleted)
DELETE
FROM lfs_table 
WHERE City_ID IS NULL

-- replace null values with zero 

UPDATE lfs_table
SET VALUE = 0
WHERE VALUE IS NULL

SELECT REF_DATE,City_ID,Province,City,Labour_force_characteristics, VALUE
FROM lfs_table

-- checking the cleaned data set
SELECT * 
FROM lfs_table
WHERE City_ID like '%Toronto%'

--------------------------------------------

----- END OF CLEANING LABOUR FORCE----------

---------------------------------------------



---- DRAFT MESSAGE----


-- case statement to generate UID for the joins 

-- get population from 2016 to 2020, join the population and income according to year and city

-- for census data cleaning, High chance to drop this table 



-- use GCP bigquery and connect to S3
-- clean the data from GCP 
--SELECT COUNT(*) FROM census_table
--SELECT * FROM census_table

--SELECT * FROM census_table
--WHERE GEO_NAME = 'Nunavut';

-- income 
-- population 
-- education level (how many educated people in an area X, degree, diploma, how many graduated), get categorized level by education level
-- highest achieved education in the province or education rate by city

-- use Median total income of household in 2020 ($)
--SELECT DISTINCT * 
--FROM census_table
--WHERE CHARACTERISTIC_NAME  LIKE '%Median total income of household in 2020 ($)%' AND GEO_NAME  LIKE 'Ottawa'

---checking the provinces from census table,  GE0_NAME 
--SELECT DISTINCT * 
--FROM census_table
--WHERE GEO_NAME  LIKE 'Newfoundland and Labrador'






---- End of Draft message-------




-------------------------------------------





-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					-- cleaning  EV_stations_locations

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- count the number of stations by city 
-- create a new column to hold the count 
-- drop unnecessary columns
--  the city ID from Other Tables AND MATCH WITH CITIES IN THIS DATASET
-- Change name on ID to Stations_ID


-- change Province abbreviations to long names
UPDATE  EV_stations_locations
SET Province = 'Ontario'
WHERE Province = 'ON'

UPDATE  EV_stations_locations
SET Province = 'New Brunswick'
WHERE Province = 'NB'

UPDATE  EV_stations_locations
SET Province = 'Saskatchewan'
WHERE Province = 'SK'

UPDATE  EV_stations_locations
SET Province = 'Quebec'
WHERE Province = 'QC'

UPDATE  EV_stations_locations
SET Province = 'Prince Edward Island'
WHERE Province = 'PE'

UPDATE  EV_stations_locations
SET Province = 'Newfoundland and Labradoro'
WHERE Province = 'NL'

UPDATE  EV_stations_locations
SET Province = 'Manitoba'
WHERE Province = 'MB'

UPDATE  EV_stations_locations
SET Province = 'Nova Scotia'
WHERE Province = 'NS'

UPDATE  EV_stations_locations
SET Province = 'Alberta'
WHERE Province = 'AB'

UPDATE  EV_stations_locations
SET Province = ' British Columbia'
WHERE Province = 'BC'

-- DROP UN NECESSARY COLUMNS 

ALTER TABLE EV_stations_locations
DROP COLUMN Country,Column1

-- Renaming ID column to station id
sp_RENAME 'EV_stations_locations.ID' , 'Stations_ID', 'COLUMN';

-- changing the status code to Available as all stations are considered available to public
UPDATE  EV_stations_locations
SET Status_Code =  'Available'
WHERE Status_Code like 'E' 

UPDATE  EV_stations_locations
SET Status_Code =  'Available'
WHERE Status_Code like 'T'

-- setting the city_ID will be done when i Join tables
-- replace the null values to City code

-- checking the number of stations in each city 

SELECT  City,Count(City) as Total_stations_Per_City
FROM EV_stations_locations
GROUP BY City

-- INSERTING COUNT OF CITY To  newly created column
--ALTER TABLE EV_stations_locations
--ADD Total_stations_Per_City INT

--ALTER TABLE EV_stations_locations
--DROP COLUMN Total_stations_Per_City 

--UPDATE EV_stations_locations 
--SET Total_stations_Per_City = Count(City)

-- checking the cleaned data

SELECT * FROM EV_stations_locations

WHERE CITY LIKE 'Calgary'




-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					-- cleaning  EV_registrations_cities_table


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

---- cleaning EV_registrations_cities_table
-- Table goes back t0 2017
-- drop REF_DATE
-- group by year and keep the total 
-- rename VALUE column to total ev cars


SELECT * FROM EV_registrations_cities_table
WHERE GEO LIKE '%Toronto%'


DROP TABLE IF EXISTS EV_registrations_cities_table




-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					-- cleaning  EV_registrations_provinces_table

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- STEPS 
-- Drop un necessary columns 
-- change Ref_date to Year only 
-- rename GEO column to Province
-- Join to final on Province


-- Renaming columns 

sp_RENAME 'EV_registrations_provinces_table.GEO' , 'Provinces', 'COLUMN';
sp_RENAME 'EV_registrations_provinces_table.VALUE' , 'Total_Ev_Cars_Per_Province', 'COLUMN';
sp_RENAME 'EV_registrations_provinces_table.Geo_ID' , 'Province_ID', 'COLUMN';
sp_RENAME 'EV_registrations_provinces_table.Provinces' , 'Province', 'COLUMN';

-- Drop Un Necessary columns 
ALTER TABLE EV_registrations_provinces_table
DROP COLUMN column1

-- changig the REF Date to Year 
--SELECT REF_DATE, 
--LEFT(REF_DATE,4) as tobe_KEPT,
--RIGHT(REF_DATE,LEN(DGUID)-4) AS to_DROP
--FROM EV_registrations_provinces_table;

-- CREATE A NEW COLUMN TO STORE YEAR

ALTER TABLE EV_registrations_provinces_table
ADD REF_DATE2 INT

ALTER TABLE EV_registrations_provinces_table
DROP COLUMN  YEAR 

UPDATE EV_registrations_provinces_table
SET REF_DATE2 = DATEPART(YEAR FROM REF_DATE)

ALTER TABLE EV_registrations_provinces_table
DROP COLUMN  REF_DATE


sp_RENAME 'EV_registrations_provinces_table.REF_DATE2' , 'REF_DATE', 'COLUMN';

SELECT  Province
FROM EV_registrations_provinces_table
GROUP BY Province

SELECT  *
FROM EV_registrations_provinces_table

