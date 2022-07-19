--- CLEANING THE DATA
------------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- CLEANING CANADA INCOME DATASET

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

-- REPLACING Québec, Quebec TO Québec City, Quebec
SELECT *  FROM income_table
WHERE Province  LIKE '%Alberta%';

UPDATE income_table
SET GEO = REPLACE(GEO,'Québec, Quebec','Québec City, Quebec')

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























-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- cleaning the population dataset 

DROP TABLE IF EXISTS Income_table


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

-- joining two tables on UID 

SELECT * FROM income_table
WHERE Province = 'Nunavut';

SELECT * FROM population_table

-- Joins 


SELECT i.UID,p.Province_ID,i.REF_DATE,i.Age_group,i.Province,i.City,i.Total_Income,i.Income_source, p.POPULATION
FROM income_table as i
FULL OUTER JOIN population_table as p
ON i.UID = p.Province_ID

-- creating the new table from joins 

SELECT i.UID,p.Province_ID,i.REF_DATE,i.Age_group,i.Province,i.City,i.Total_Income,i.Income_source, p.POPULATION
INTO 
	final_table
FROM income_table as i
FULL OUTER JOIN population_table as p
ON i.UID = p.Province_ID


-- checking the nw table 
SELECT * FROM final_table
WHERE UID LIKE 'S0504450'

-- creating city-ID and Province ID 




















-- case statement to generate UID for the joins 

-- get population from 2016 to 2020, join the population and income according to year and city

-- for census data cleaning, High chance to drop this table 



-- use GCP bigquery and connect to S3
-- clean the data from GCP 
SELECT COUNT(*) FROM census_table
SELECT * FROM census_table

SELECT * FROM census_table
WHERE GEO_NAME = 'Nunavut';

-- income 
-- population 
-- education level (how many educated people in an area X, degree, diploma, how many graduated), get categorized level by education level













-------------------------------------------
-- use Median total income of household in 2020 ($)
SELECT DISTINCT * 
FROM census_table
WHERE CHARACTERISTIC_NAME  LIKE '%Median total income of household in 2020 ($)%' AND GEO_NAME  LIKE 'Ottawa'

---checking the provinces from census table,  GE0_NAME 
SELECT DISTINCT * 
FROM census_table
WHERE GEO_NAME  LIKE 'Newfoundland and Labrador'
