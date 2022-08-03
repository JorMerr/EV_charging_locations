-- creating Final table
CREATE TABLE final_table (
	id INTEGER,
	city VARCHAR(250),
	province_id VARCHAR(250),
	province_name VARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status VARCHAR (5),
	EV_Per_Province INTEGER
	);

-- creating province_population_table
CREATE TABLE province_population_table(
	REF_DATE date,
	province VARCHAR(250),
	POPULATION INTEGER,
	province_ID VARCHAR(250)
	);
-- creating EV_registrations_provinces_table
CREATE TABLE EV_registrations_provinces_table (
	REF_DATE date,
	province VARCHAR(250),
	province_ID VARCHAR(250),
	VALUE INTEGER
	);
-- creating	EV_registrations_cities_table
CREATE TABLE EV_registrations_cities_table (
	REF_DATE date,
	GEO VARCHAR(250),
	GEO_ID VARCHAR(250),
	VALUE INTEGER
	);
-- creating EV_stations_locations
CREATE TABLE EV_stations_locations (
	Stations_ID INTEGER,
	Fuel_Type_Code VARCHAR(250),
	City VARCHAR(250),
	Province VARCHAR(250),
	ZIP VARCHAR(250),
	Status_Code VARCHAR(250)
		);

-- creating incentives_table
CREATE TABLE incentives_table (
	Province VARCHAR(250),
	Total_Rebate INTEGER,
	Provincial_incentives VARCHAR(250),
	electricity_rate_per_1000kWh VARCHAR(250)
		);

-- creating provincial_unemployment_table
--DROP TABLE IF EXISTS provincial_unemployment_table
CREATE TABLE provincial_unemployment_table(
	Province VARCHAR(250),
	Province_ID VARCHAR(250),
	Provincial_Unemp_rate float
			);

-- creating provincial_income
CREATE TABLE provincial_income(
	Province VARCHAR(250),
	Province_ID VARCHAR(250),
	Median_Income INTEGER
			);
-- creating merged_dataset_table
CREATE TABLE merged_dataset_table (
	City VARCHAR(250),
	province VARCHAR(250),
	City_ID VARCHAR(250),
	Population_2021 INTEGER,
	Land_Area_sqKM FLOAT,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	Vehicles_sold_since_2017 INTEGER,
	Number_of_stations INTEGER
	);

-- creating Testing_Station_Predictions

CREATE TABLE Testing_Station_Predictions (
	id INTEGER,
	city VARCHAR(250),
	province_id VARCHAR(250),
	province_name VARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status VARCHAR (5),
	EV_Per_Province INTEGER,
	No_Certificate_perc FLOAT, 
	Secondary_HS_perc float,
	Apprenticeship_per float,
	College_CEGEP_perc float,
	Univ_Diploma_Below_Bachelor_per float,
	Univ_Diploma_Above_Bachelor_per float,
	City_EV_stattions_y integer,
	model_predictions float
	);


-- creating Training_Station_Predictions
	CREATE TABLE Training_Station_Predictions (
	id INTEGER,
	city VARCHAR(250),
	province_id VARCHAR(250),
	province_name VARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status VARCHAR (5),
	EV_Per_Province INTEGER,
	No_Certificate_perc FLOAT, 
	Secondary_HS_perc float,
	Apprenticeship_per float,
	College_CEGEP_perc float,
	Univ_Diploma_Below_Bachelor_per float,
	Univ_Diploma_Above_Bachelor_per float,
	City_EV_stattions_y integer,
	model_predictions float
	);


-- creating province_edu_rate

	CREATE TABLE province_edu_rate (
	Geographic_code INTEGER,
	Geographic_Name VARCHAR(250),
	No_Certificate_diploma_or_degree FLOAT, 
	Secondary_High_schol_diploma_or_equivalency_certificate_2 float,
	Apprenticeship_or_trades_certificate_or_diploma_3_4 float,
	College_CEGEP_or_other_non_university_certificate_or_diploma float,
	University_certificate_or_Diploma_Below_Bachelor_level float,
	University_certificate_or_Diploma_at_Bachelor_level_or_above_5 float
	);

-- creating Final table
CREATE TABLE clean_table (
	id INTEGER,
	city VARCHAR(250),
	province_id VARCHAR(250),
	province_name VARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status VARCHAR (5),
	EV_Per_Province INTEGER,
	No_Certificate_perc FLOAT, 
	Secondary_HS_perc float,
	Apprenticeship_per float,
	College_CEGEP_perc float,
	Univ_Diploma_Below_Bachelor_per float,
	Univ_Diploma_Above_Bachelor_per float
	);













--DROP TABLE IF EXISTS province_edu_rate
SELECT * FROM final_table
SELECT * FROM clean_table
SELECT * FROM province_population_table;
SELECT * FROM EV_registrations_provinces_table;
SELECT * FROM EV_registrations_cities_table;
SELECT * FROM EV_stations_locations;
SELECT * FROM incentives_table;
SELECT * FROM provincial_unemployment_table;
SELECT * FROM provincial_income
SELECT * FROM merged_dataset_table
SELECT * FROM province_population_table
SELECT * FROM Testing_Station_Predictions
SELECT * FROM Training_Station_Predictions
SELECT * FROM province_edu_rate