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




DROP TABLE IF EXISTS city_unemployment_table
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