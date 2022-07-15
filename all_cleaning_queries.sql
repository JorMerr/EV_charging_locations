--- CLEANING THE DATA
------------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- CLEANING CANADA INCOME DATASET

DROP TABLE IF EXISTS Income_table

-- show all columns 
SELECT * FROM income_table;


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

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- cleaning the population dataset 

DROP TABLE IF EXISTS Income_table


-- show all columns 
SELECT * FROM population_table;

-- drop un-necessary columns(UOM,SYMBOL,TERMINATED,DECIMALS,STATS)
ALTER TABLE population_table
DROP COLUMN  UOM_ID,
VECTOR, COORDINATE, STATUS, SYMBOL, TERMINATED, DECIMALS;


-- DELETE ALL Geographic locations where GEO COLUMN = TO CANADA
DELETE  FROM population_table
WHERE GEO = 'Canada';

-- renaming VALUE columns to Total 

sp_RENAME 'population_table.VALUE' , 'TOTAL', 'COLUMN';


-- joining two tables on geographic location

