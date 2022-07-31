-- creating Final table
CREATE TABLE final_table (
	id INTEGER,
	city NVARCHAR(250),
	province_id NVARCHAR(250),
	province_name NVARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status NVARCHAR (5),
	EV_Per_Province INTEGER
	);

-- creating province_population_table
CREATE TABLE province_population_table(
	REF_DATE date,
	province NVARCHAR(250),
	POPULATION INTEGER,
	province_ID NVARCHAR(250)
	);
-- creating EV_registrations_provinces_table
CREATE TABLE EV_registrations_provinces_table (
	REF_DATE date,
	province NVARCHAR(250),
	province_ID NVARCHAR(250),
	VALUE INTEGER,
	);
-- creating	EV_registrations_cities_table
CREATE TABLE EV_registrations_cities_table (
	REF_DATE date,
	GEO NVARCHAR(250),
	GEO_ID NVARCHAR(250),
	VALUE INTEGER,
	);
-- creating EV_stations_locations
CREATE TABLE EV_stations_locations (
	Stations_ID INTEGER,
	Fuel_Type_Code NVARCHAR(250),
	City NVARCHAR(250),
	Province NVARCHAR(250),
	ZIP NVARCHAR(250),
	Status_Code NVARCHAR(250),
		);

-- creating incentives_table
CREATE TABLE incentives_table (
	Province NVARCHAR(250),
	Total_Rebate INTEGER
	Provincial_incentives NVARCHAR(250),
	electricity_rate_per_1000kWh NVARCHAR(250),
		);

-- creating provincial_unemployment_table
CREATE TABLE provincial_unemployment_table(
	Province NVARCHAR(250),
	Province_ID NVARCHAR(250),
	Provincial_Unemp_rate INTEGER,
			);

-- creating provincial_income
CREATE TABLE provincial_income(
	Province NVARCHAR(250),
	Province_ID NVARCHAR(250),
	Median_Income INTEGER,
			);
-- creating merged_dataset_table
CREATE TABLE merged_dataset_table (
	City NVARCHAR(250),
	province NVARCHAR(250),
	City_ID NVARCHAR(250),
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
	city NVARCHAR(250),
	province_id NVARCHAR(250),
	province_name NVARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status NVARCHAR (5),
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
	city NVARCHAR(250),
	province_id NVARCHAR(250),
	province_name NVARCHAR(250),
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status NVARCHAR (5),
	EV_Per_Province INTEGER
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
	Geographic_Name NVARCHAR(250),
	No_Certificate_diploma_or_degree FLOAT, 
	Secondary_High_schol_diploma_or_equivalency_certificate_2 float,
	Apprenticeship_or_trades_certificate_or_diploma_3_4 float,
	College_CEGEP_or_other_non_university_certificate_or_diploma float,
	University_certificate_or_Diploma_Below_Bachelor_level float,
	University_certificate_or_Diploma_at_Bachelor_level_or_above_5 float,
	);














--DROP TABLE IF EXISTS 
SELECT * FROM final_table
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