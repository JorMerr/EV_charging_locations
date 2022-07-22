-- creating Final table
DROP TABLE IF EXISTS final_table;
CREATE TABLE final_table (
	id INTEGER,
	city NVARCHAR(250),
	province_id NVARCHAR(250,
	province_name NVARCHAR(250,
	City_Population INTEGER,
	Median_Income INTEGER ,
	Unemployment_Rate FLOAT,
	City_Electricity_Rate FLOAT,
	City_EV_Registrations INTEGER,
	City_EV_stations_locations INTEGER,
	incentives_status NVARCHAR (5),
	EV_Per_Province INTEGER
	);

SELECT * FROM final_table