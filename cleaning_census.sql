--checking the imported data
SELECT * FROM census_table

-- checking the datatypes
exec sp_help census_table

-- count of data 
SELECT COUNT(*) FROM census_table

-- CHECKING CITY NAMES
SELECT GEO_NAME FROM census_table
WHERE GEO_NAME LIKE "TORONTO"


-- checking DUID
SELECT * FROM census_table
WHERE DGUID = '2011S0503933'

