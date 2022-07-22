--- CLEANING THE DATA---------

SELECT * FROM lfs_table;
--SELECT * FROM income_table;
SELECT * FROM province_population_table;
SELECT * FROM EV_registrations_provinces_table;
SELECT * FROM EV_registrations_cities_table;
SELECT * FROM EV_stations_locations;
SELECT * FROM incentives_table;
SELECT * FROM provincial_unemployment_table;
SELECT * FROM provincial_income
SELECT * FROM final_table
SELECT * FROM merged_dataset_table

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

				-- cleaning the province_population_table dataset 

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS province_population_table


-- show all columns 
SELECT * FROM province_population_table;

SELECT COUNT(*) FROM province_population_table

-- renaming columns 
sp_RENAME 'province_population_table_table.Population_and_dwelling_counts_11' , 'Population', 'COLUMN';
sp_RENAME 'province_population_table_table.UID' , 'Province_ID', 'COLUMN';
-- KEPP ONLY population column 

DELETE  FROM province_population_table
WHERE Population NOT LIKE 'Population, 2021'

-- drop un-necessary columns(UOM,SYMBOL,TERMINATED,DECIMALS,STATS)
ALTER TABLE province_population_table
DROP COLUMN  UOM_ID,
VECTOR, COORDINATE, STATUS, SYMBOL, TERMINATED, DECIMALS;

ALTER TABLE province_population_table
DROP COLUMN  SCALAR_FACTOR;

ALTER TABLE province_population_table
DROP COLUMN  SCALAR_ID;

ALTER TABLE province_population_table
DROP COLUMN  Population;

-- DELETE ALL Geographic locations where GEO COLUMN = TO CANADA

DELETE  FROM province_population_table
WHERE GEO = 'Canada';

-- renaming VALUE columns to Total 

sp_RENAME 'province_population_table.VALUE' , 'TOTAL', 'COLUMN';
sp_RENAME 'province_population_table.TOTAL' , 'POPULATION', 'COLUMN';
sp_RENAME 'province_population_table.GEO' , 'Province', 'COLUMN';

-- trim DGUID to keep the last 6 digits

SELECT DGUID, 
LEFT(DGUID,4) as tobe_dropped,
RIGHT(DGUID,LEN(DGUID)-4) AS to_keep
FROM province_population_table;

-- Extracting UID  from TABLE

ALTER TABLE province_population_table
ADD UID NVARCHAR(255)


UPDATE province_population_table 
SET UID = RIGHT(DGUID,LEN(DGUID)-4)

-- Drop DGUID COLUMN 
ALTER TABLE province_population_table
DROP COLUMN  DGUID




SELECT * 
FROM province_population_table


------------------------------------END OF CLEANING POPULATION TABLE --------------
-----------------------------------------------------------------------------------





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

-- trim province 
UPDATE lfs_table
SET Province = TRIM(Province)

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

-----------------------------------------------------------------------------

----- END OF CLEANING LABOUR FORCE-------------------------------------------

-----------------------------------------------------------------------------



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

					-- cleaning  EV_stations_locations

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

-- changing Quebec city name 

UPDATE  EV_stations_locations
SET City =  'Quebec City'
WHERE City like 'Ville de Québec'

UPDATE  EV_stations_locations
SET City =  'Saint-Jerome'
WHERE City like 'St-Jérôme'

UPDATE  EV_stations_locations
SET City =  'Montreal'
WHERE Stations_ID = 150515

--150503
--150515


-- cleaning the rest of double names from QC

UPDATE  EV_stations_locations
SET City =  'Saint‐Bruno'
WHERE City like 'St‐Bruno'


-- setting the city_ID will be done when i Join tables
-- replace the null values to City code

-- checking the number of stations in each city 

SELECT  City,Count(City) as Total_stations_Per_City
FROM EV_stations_locations
GROUP BY City

-- INSERTING COUNT OF CITY To  newly created column
--ALTER TABLE EV_stations_locations
--ADD Total_stations_Per_City INT

-- number of ev stations  in each city

SELECT * FROM EV_stations_locations

WHERE CITY LIKE 'Rivière%'

-- CREATE A COLUMN TO HOLD TOTAL STATIONS 

ALTER TABLE EV_stations_locations 
ADD Total_stations INT

update EV_stations_locations 
SET Total_stations  = (SELECT Count(Stations_ID) as Total_stations
FROM  EV_stations_locations GROUP BY City)

-- total number of stations per city

SELECT  
 City, Count(Stations_ID) as Total_stations
FROM  EV_stations_locations 
GROUP BY City





SELECT * FROM EV_stations_locations 
WHERE City LIKE '%Rivière%'


---------------------------END OF CLEANING EV_Station_locations_Table-------------



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
-- drop the Geo_ID starts with As and keep the city(starts by S)

-- number of ev cars in this particular city
-- comparison of ev cars in city per available stations 

-- this table is about total_EV_Cars_per_city

-- drop those with value is zer0

DELETE 
FROM EV_registrations_cities_table
WHERE VALUE = 0


ALTER TABLE EV_registrations_cities_table
ADD to_drop nvarchar(250)

UPDATE EV_registrations_cities_table
SET to_drop = RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO))
FROM EV_registrations_cities_table;

ALTER TABLE EV_registrations_cities_table
DROP COLUMN to_drop 

-- cleaning the names, like french names 

UPDATE  EV_registrations_cities_table
SET GEO =  'Hamilton'
WHERE GEO like 'Hamilton, Ontario'

SELECT *
--,LEFT(GEO,CHARINDEX(',',GEO)) 
,LEFT (GEO,LEN(GEO) - CHARINDEX(',',GEO)) AS to_keep
FROM EV_registrations_cities_table;

SELECT * FROM EV_registrations_cities_table
WHERE GEO like 'Montr%'

-- number of EV Vehicle in each city

SELECT DISTINCT GEO , SUM(VALUE) FROM EV_registrations_cities_table
GROUP BY GEO



DROP TABLE IF EXISTS EV_registrations_cities_table

SELECT  
 GEO, Count(VALUE) as Total_stations
FROM  EV_registrations_cities_table
GROUP BY City


SELECT * FROM EV_registrations_cities_table


---------------------END OF CLEANING EV_registrations_cities---------------------





-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					-- cleaning  EV_registrations_provinces_table

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- STEPS
-- this table is bout total ev cars by province 
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

SELECT  *
FROM EV_registrations_provinces_table
GROUP BY Province

SELECT DISTINCT Province, 
FROM EV_registrations_provinces_table
GROUP BY Province
-- HAVE THE PROVINCES AND TOTAL PER YEAR, 


-------------------------------------End Of Cleaning EV_registrations_provinces_table---------------

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

					-- cleaning  Incentives table 
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------


sp_RENAME 'incentives_table.Electricity rate_per 1000kWh' , 'electricity_rate_per_1000kWh', 'COLUMN';
sp_RENAME 'incentives_table.Max# Rebate' , 'Total_Rebate', 'COLUMN';
sp_RENAME 'incentives_table.Provincial Incentives' , 'Provincial_Incentives', 'COLUMN';


---------------------End Of Cleaning Incentives Table----------------------------


-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------

					-- cleaning  province education rate

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
SELECT * FROM province_edu_rate




---------------------------------End of Cleaning Education data--------------------



-----------------------------------------------------------------------------------

					-- cleaning  final_table

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------


DROP TABLE IF EXISTS final_table

-- Insert Provice from lfs table to cities table 

--1- FROM INCOME TABLE 

UPDATE final_table 
	SET final_table.Province = (SELECT DISTINCT income_table.Province
FROM  income_table 
WHERE final_table.City_Name = income_table.City)

--2- FROM LFS TABLE 
UPDATE final_table 
	SET final_table.Province = (SELECT DISTINCT lfs_table.Province
FROM  lfs_table 
WHERE final_table.City_Name = lfs_table.City  AND final_table.Province IS NULL )




-- changing the column dtype size
ALTER TABLE final_table
ADD Province varchar(255);

ALTER TABLE final_table
DROP COLUMN Province;



SELECT * FROM final_table
WHERE  City_Electricity_Rate IS   NULL



SELECT * FROM final_table
WHERE city LIKE 'St-Jérôme%'


SELECT * 
FROM final_table c
INNER JOIN EV_registrations_cities_table e
ON c.City_Name = e.GEO


-- removing duplicates from city_table 
WITH cte as (
	SELECT 
	City,
	ROW_NUMBER () OVER (
	PARTITION BY 
	City
	ORDER BY City) row_num
	FROM final_table
	)
	DELETE FROM cte
	WHERE row_num > 1


--- adding electricity rate to each city, assuming the rate of electricity is equal to the rate of province

UPDATE final_table 
	SET final_table.City_Electricity_Rate = (SELECT DISTINCT incentives_table.electricity_rate_per_1000kWh
FROM  incentives_table
WHERE final_table.province_name = incentives_table.Province)


-- INCENTIVE STATUS 
ALTER TABLE final_table
ADD incentives_status nvarchar(255)


UPDATE final_table 
	SET incentives_status = 'YES'
	FROM  final_table 
WHERE province_id != 'ON'

UPDATE final_table
	SET incentives_status = 'NO'
	FROM  final_table
WHERE province_id = 'ON'



-- dropping columns 

ALTER TABLE final_table
DROP COLUMN Social_assistance;

ALTER TABLE final_table
DROP COLUMN Employment_Rate;


-- use CTE to update final_table.City_EV_stations_locations


WITH stationsCTE(City,Total_stations)
AS
(
SELECT  
 City, Count(Stations_ID) as Total_stations
FROM  EV_stations_locations 
GROUP BY City
)

UPDATE final_table
SET final_table.City_EV_stations_locations = s.Total_stations
FROM final_table f, stationsCTE s
WHERE	f.City = s.City

-- updating french names 
UPDATE  final_table
SET City =  'Rivière-du-Loup'
WHERE City like 'Rivière du Loup'


-- adding unemployement rate to our table 
UPDATE final_table 
SET final_table.Unemployment_Rate = p.province_Unemp_rate
FROM provincial_unemployment_table p
WHERE final_table.province_name= p.Province


-- adding median income, this is from province median income
UPDATE final_table 
SET final_table.City_Median_Income =p.Median_Income
FROM provincial_income p
WHERE final_table.province_name= p.Province


-- adding total number of EV cars registration in a city
UPDATE final_table 
SET final_table.City_EV_registrations =m.Vehicles_sold_since_2017
FROM merged_dataset_table m
WHERE final_table.city= m.City

-- 13.0, rename column as electricity_rate_perKwh, USE CET 
SELECT *,
LEFT(City_Electricity_Rate,4) AS Electricity_Rate
FROM final_table 

WITH ev_rateCTE(City,Electricity_Rate)
AS
(
SELECT City,
LEFT(City_Electricity_Rate,4) AS Electricity_Rate
FROM final_table 

)

UPDATE final_table
SET final_table.City_Electricity_Rate = e.Electricity_Rate
FROM final_table f, ev_rateCTE e
WHERE	f.City = e.City

--- UPDATE electricity rate
UPDATE final_table
SET final_table.City_Electricity_Rate = 7.3
FROM final_table f
WHERE	f.City_Electricity_Rate = '7.3¢'

--- UPDATE electricity rate

UPDATE final_table
SET final_table.City_Electricity_Rate = 9.9
FROM final_table f
WHERE	f.City_Electricity_Rate = '9.9¢'

-- rename population as city_population
sp_RENAME 'final_table.population' , 'City_Population', 'COLUMN';
sp_RENAME 'final_table.City_Median_Income' , 'Median_Income', 'COLUMN';

-- creating new column to hold totl_ev_cars By Province

ALTER TABLE final_table
ADD  EV_Per_Province NVARCHAR (250)

-- adding total eve cars per province 
WITH ev_totalCTE(Province,Total_Ev_prov)
AS
(
SELECT DISTINCT Province,SUM(Total_Ev_Cars_Per_Province) AS Total_Ev_prov
FROM EV_registrations_provinces_table 
GROUP BY Province

)

UPDATE final_table
SET final_table.EV_Per_Province = e.Total_Ev_prov
FROM final_table f, ev_totalCTE e
WHERE	f.province_name = e.Province


-- replacing the Nulls with zero's
UPDATE final_table
SET City_EV_registrations = 0
where City_EV_registrations IS NULL


UPDATE final_table
SET City_EV_stations_locations = 0
where City_EV_stations_locations IS NULL


UPDATE final_table
SET EV_Per_Province = 0
where EV_Per_Province IS NULL




-- setting UNemployement rate to zero for Nunavut, Northwest Territories and Yukon
-- Search them and update in table, rerun the code for matching unemployment rate

UPDATE final_table
SET Unemployment_Rate = 0
where Unemployment_Rate IS NULL

-- CHECKING THE DATASET
SELECT * FROM final_table
where  Unemployment_Rate IS  NULL


-- New columns TO HOLD EDUCATION rates

ALTER TABLE final_table
ADD No_Certificate_perc FLOAT, 
Secondary_HS_perc FLOAT, 
Apprenticeship_perc FLOAT , 
College_CEGEP_perc FLOAT,
Univ_diploma_Below_Bachelor_perc FLOAT, 
Univ_diploma_Above_Bachelor_perc FLOAT


-- updating No_Certificate_perc
UPDATE  final_table 
SET final_table.No_Certificate_perc = p.No_certificate_diploma_or_degree
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name

-- updating NSecondary_HS_perc

UPDATE  final_table 
SET final_table.Secondary_HS_perc = p.Secondary_high_school_diploma_or_equivalency_certificate_2
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name

-- updating Apprenticeship_perc

UPDATE  final_table 
SET final_table.Apprenticeship_perc = p.Apprenticeship_or_trades_certificate_or_diploma_3_4
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name


-- updating College_CEGEP_perc

UPDATE  final_table 
SET final_table.College_CEGEP_perc = p.College_CEGEP_or_other_non_university_certificate_or_diploma
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name


-- updating Univ_diploma_Below_Bachelor_perc

UPDATE  final_table 
SET final_table.Univ_diploma_Below_Bachelor_perc = p.University_certificate_or_diploma_below_bachelor_level
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name

-- updating Univ_diploma_Above_Bachelor_perc

UPDATE  final_table 
SET final_table.Univ_diploma_Above_Bachelor_perc = p.University_certificate_diploma_or_degree_at_bachelor_level_or_above_5
FROM  province_edu_rate p
WHERE final_table.province_name = p.Geographic_name


SELECT * FROM final_table


--------------------------End of Cleaning Final Table---------------------------------------------------------
-----------------------------------------------------------------------------------


------------------------------------------------------------------------------
-----------------------------------------------------------------------------

			-- CLEANING CANADA INCOME DATASET

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

--DROP TABLE IF EXISTS Income_table

---- show all columns 
--SELECT * FROM income_table;
--SELECT COUNT(*) FROM income_table
--WHERE UID LIKE 'S%'


---- drop un-necessary columns(UOM,SYMBOL,TERMINATED,DECIMALS,STATS)

--ALTER TABLE income_table
--DROP COLUMN UOM, UOM_ID,
--VECTOR, COORDINATE, STATUS, SYMBOL, TERMINATED, DECIMALS;

---- DELETE ALL Geographic locations where GEO COLUMN = TO CANADA

--DELETE  FROM income_table
--WHERE GEO = 'Canada';

---- checking the columns with all provinces 
---- dataset does not include provinces like Yukon,Northwest Territories,Nunavut
---- show all columns 
--SELECT * FROM income_table
--WHERE GEO = 'Atlantic provinces';

---- DELETE ALL Geographic locations where GEO COLUMN = TO Atlantic provinces
--DELETE  FROM Income_table
--WHERE GEO = 'Atlantic provinces';

---- DELETE ALL Geographic locations where GEO COLUMN = TO Prairie provinces
--DELETE  FROM Income_table
--WHERE GEO = 'Prairie provinces';

---- renaming VALUE columns to Total 

--sp_RENAME 'income_table.VALUE' , 'TOTAL', 'COLUMN';

--sp_RENAME 'income_table.TOTAL' , 'Total_Income', 'COLUMN';


---- renaming the statistics column to Median Income
--sp_RENAME 'income_table.Statistics' , 'Median_Income', 'COLUMN';

---- selecting only Median income 

--SELECT DISTINCT * 
--FROM income_table
--WHERE Median_Income  NOT LIKE 'Median income (excluding zeros)'
--ORDER BY Total_Income desc

---- delete the rest of information other than median income 
--DELETE
--FROM income_table
--WHERE Median_Income  NOT LIKE 'Median income (excluding zeros)'

--DELETE
--FROM income_table
--WHERE Income_source   LIKE 'Employment Insurance (EI) benefits'

--DELETE
--FROM income_table
--WHERE Income_source   LIKE 'Market income'

--DELETE
--FROM income_table
--WHERE Income_source   LIKE 'Employment income'

--DELETE
--FROM income_table
--WHERE Income_source   LIKE 'Investment income'

--DELETE
--FROM income_table
--WHERE Income_source   LIKE 'Retirement income'



--DELETE
--FROM income_table
--WHERE Sex  LIKE 'Females'

--SELECT * 
--FROM income_table
--WHERE REF_DATE = 2020
---- drop scalar_id column 

--ALTER TABLE income_table
--DROP COLUMN SCALAR_ID

--ALTER TABLE income_table
--DROP COLUMN SCALAR_FACTOR

---- DROP NULL VALUES FROM TOTAL INCOME

--DELETE
--FROM income_table
--WHERE Total_Income  IS NULL

---- dropping Median_Income

--ALTER TABLE income_table
--DROP COLUMN Median_Income

---- separating city and provinces
---- update table with the new columns 
---- replace empty space with city names


--SELECT *  FROM income_table;

---- CHANGE GEO COLUMNS 
---- renaming GEO columns field 

---- REPLACING Québec, Quebec TO Québec City, Quebec
--SELECT *  FROM income_table
--WHERE Province  LIKE '%Alberta%';

--UPDATE income_table
--SET GEO = REPLACE(GEO,'Québec, Quebec','Québec City, Quebec')

---- REPLACING Ottawa-Gatineau, Ontario/Quebec TO Ottawa, Ontario
--UPDATE income_table
--SET GEO = REPLACE(GEO,'Ottawa-Gatineau, Ontario/Quebec','Ottawa-Gatineau, Ontario')

---- changing the names of all GEO locations 
---- REPLACING Newfoundland and Labrador TO Newfoundland and Labrador,Newfoundland and Labrador
---- Prince Edward Island to Prince Edward Island,Prince Edward Island
---- Nova Scotia to Nova Scotia,Nova Scotia
---- New Brunswick to New Brunswick,New Brunswick
---- Quebec to Quebec,Quebec
---- Ontario to Ontario,Ontario
---- Manitoba to Manitoba,Manitoba
---- Saskatchewan to Saskatchewan,Saskatchewan
---- Alberta to Alberta,Alberta
---- British Columbia to British Columbia
--UPDATE income_table
--SET GEO = REPLACE(GEO,'Newfoundland and Labrador','Newfoundland and Labrador,Newfoundland and Labrador')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'Prince Edward Island','Prince Edward Island,Prince Edward Island')

--UPDATE income_table
--SET GEO =  REPLACE(GEO,'Nova Scotia','Nova Scotia, Nova Scotia')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'Quebec','Quebec, Quebec')
 
-- UPDATE income_table
--SET GEO = REPLACE(GEO,'Ontario','Ontario, Ontario')

-- UPDATE income_table
--SET GEO = REPLACE(GEO,'Manitoba','Manitoba,Manitoba')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'Saskatchewan','Saskatchewan,Saskatchewan')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'Alberta','Alberta,Alberta')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'British Columbia','British Columbia,British Columbia')

--UPDATE income_table
--SET GEO = REPLACE(GEO,'New Brunswick','New Brunswick,New Brunswick');

---- trim province, city  Column for income table

--UPDATE income_table
--SET City = TRIM(City)

--UPDATE income_table
--SET Province = TRIM(Province)

---- 

--SELECT *
--,RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO)) AS Province
--FROM income_table;

---- ,LEFT(GEO,CHARINDEX(',',GEO)) AS City

--ALTER TABLE Income_table 
--ADD Province NVARCHAR(255)

--UPDATE Income_table 
---- SET City = LEFT(GEO,CHARINDEX(',',GEO)),
--SET Province = RIGHT(GEO,LEN(GEO) - CHARINDEX(',',GEO))

--SELECT DISTINCT Province FROM income_table;

---- changing the province column 
--SELECT *
--,RIGHT(Province,LEN(Province) - CHARINDEX(',',Province)) AS Province2
--FROM income_table;

---- Creating Province2 column
--ALTER TABLE Income_table 
--ADD Province2 NVARCHAR(255)

--UPDATE Income_table 

--SET Province2 = RIGHT(Province,LEN(Province) - CHARINDEX(',',Province))


--UPDATE Income_table 

--SET Province = Province2

---- drop provinces columns 

--ALTER TABLE income_table
--DROP COLUMN Province2

---- show all columns 
--SELECT * FROM income_table;

--SELECT DISTINCT * 
--FROM income_table

---- Extracting Cities  from GEO 
--ALTER TABLE Income_table 
--ADD City NVARCHAR(255)

--SELECT *,
--LEFT(GEO,CHARINDEX(',',GEO) -1) AS City
--FROM income_table;

--UPDATE Income_table 
--SET City = LEFT(GEO,CHARINDEX(',',GEO) -1) 

---- drop GEO column
--ALTER TABLE income_table
--DROP COLUMN GEO

---- trim DGUID to keep the last 6 digits
--SELECT Province,DGUID, 
--LEFT(DGUID,4) as tobe_dropped,
--RIGHT(DGUID,LEN(DGUID)-4) AS to_keep
--FROM income_table;

---- Extracting UID  from TABLE
--ALTER TABLE Income_table 
--ADD UID NVARCHAR(255)


--UPDATE Income_table 
--SET UID = RIGHT(DGUID,LEN(DGUID)-4)

---- Drop DGUID COLUMN 
--ALTER TABLE Income_table
--DROP COLUMN  DGUID

---- KEEPING INCOME FOR 16 YEARS AND OVER

--DELETE 
--FROM Income_table 
--WHERE Age_group NOT like '%16 years and over%'

---- checking the cleaned dataset
--SELECT * 
--FROM Income_table
--WHERE Income_source like '%Total income%' and Sex like '%Both sexes%'

---- DROP ANYTHING ELSE KEEP ONLY CITIES
--DELETE
--FROM income_table
--WHERE UID LIKE 'A%'

--SELECT * FROM income_table

-- INCOME TABLE DROPPED
-----------------------------End of Cleaning Income_Data set----------------------



















------ DRAFT MESSAGE----


--SELECT * 
--FROM final_table f 
--FULL OUTER JOIN lfs_table l
--ON l.City_ID = f.UID

--SELECT * 
--FROM final_table f 
--LEFT JOIN lfs_table l
--ON l.City_ID = f.UID


--SELECT * 
--FROM lfs_table

--SELECT * 
--FROM final_table

--SELECT DISTINCT Income_source FROM final_table
--WHERE 

---- 
---- from final_table consider Total income, Social assistance and drop the rest
---- trim to remove space to lfs table 


---- case statement to generate UID for the joins 

---- get population from 2016 to 2020, join the population and income according to year and city

---- for census data cleaning, High chance to drop this table 



---- use GCP bigquery and connect to S3
---- clean the data from GCP 
--DROP TABLE IF EXISTS census_table

--SELECT COUNT(*) FROM census_table
--SELECT * FROM census_table
--WHERE GEO_LEVEL like '%Ottawa%'
----SELECT * FROM census_table
----WHERE GEO_NAME = 'Nunavut';

---- income 
---- population 
---- education level (how many educated people in an area X, degree, diploma, how many graduated), get categorized level by education level
---- highest achieved education in the province or education rate by city

---- use Median total income of household in 2020 ($)
----SELECT DISTINCT * 
----FROM census_table
----WHERE CHARACTERISTIC_NAME  LIKE '%Median total income of household in 2020 ($)%' AND GEO_NAME  LIKE 'Ottawa'

-----checking the provinces from census table,  GE0_NAME 
----SELECT DISTINCT * 
----FROM census_table
----WHERE GEO_NAME  LIKE 'Newfoundland and Labrador'


---- New Ideas ++++ NOTES ++++ TO-DO-LIST--------------------------------------------

---- cleaning new data --
---- columns to be considered below 

----Population
----Electricity rate (Provincial average)
----Provincial EV incentives (Yes or No)
----Employment Rate
----Unemployment Rate
----EV registrations
----Median Income (If we can get it)
---- Education level
---- add unemployment rate to the file 
---- add median income(median income is based on province)
---- ev_registration by city( after cleaning the file)
---- add ev_registration by province (create a new column)
---- add a column for province population
---- get province unemployment rate and add to the final table, this is because we do not have enough data of unemployement rate 


-------------------------------------------------------------------------------------------------------------------------------------------




------ End of Draft message-----