# EV_charging_locations

## Project Outline

### Selected Topic
For this analysis, we have chosen to create a supervised machine learning model to predict how many Electric Vehicle charging stations cities in Canada can support.

### Reason for the Selected Topic
We have chosen to analyze electric vehicle charging station locations in Canada because we understand that Canada's participation in the transition away from fossil fuels to green energy fuel sources is a crucial step in the battle against climate change. 

A significant portion of greenhouse gas emissions from burning fossil fuels comes from motor vehicles. Canada is on track to ban the sale of new fossil fuel burning cars and light-duty trucks by 2035. 

This transition to environmentally friendly vehicles will require a logistic network of charging stations that can support all electric vehicles on the road. These charging stations must be located in areas to best serve the public, in much the same way that gas stations currently do.

Our model aims to predict how many stations a city can support given a number of features of a city derived from the Canadian Census such as, Population, Median Income, Median Highest Education Level Achieved and New Registrations of Zero Emission Vehicles. With these features our goal is to determine whether the current network of vehicle charging stations is sufficient to meet public demand as adoption of zero emission vehicles increases and identify cities that will benefit from the construction of new charging stations over time.

### What we hope to answer with our data
We hope to answer whether Canadian cities will be sufficiently ready to support the adoption of Zero Emission Vehicles as the transition away from fossil fuel burning vehicles continues. We aim to predict the number of electric vehicle charging stations each city can support based on key demographic information.

### Data Sources
Our data has been collected from the following sources using the listed methods below:
- [2021 Census](https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/download-telecharger.cfm?Lang=E)
    - The data is downloaded as a full table CSV file directly from the website
- [LABOUR FORCE SURVEY](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410039101)
    - This dataset is collected using Statistics Canada's Web Data Services public API call.
- [NEW ZERO-EMISSION VEHICLE REGISTRATIONS- QUARTERLY](https://doi.org/10.25318/2010002501-eng)
    - This dataset is collected using Statistics Canada's Web Data Services public API call.

    ![NEW ZEV REGISTRATIONS](https://github.com/JorMerr/EV_charging_locations/blob/main/img/cleaned_new_zev_reg.JPG)


- [NRCAN ELECTRIC CHARGING AND ALTERNATIVE FUELLING STATIONS LOCATOR](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/)
    - This dataset is collected using an API call to NREL (National Renewable Energy Library) to access their database of Alternative Fuel Stations
    - It is noted that our API call retrieved the dataset for only Electric fuel stations and we have chosen to generate a sum total of all stations. The locator provides specificity regarding currently open, temporarily closed, or planned stations. 
    - We have chosen to utilize all three of these indicators as a valid stations in our dataset. Future users of our model may choose not to select one or more of these indicators as valid station locations. 
    - See a snapshot of the Alternative Fuelling Stations Locator below:

    ![ALT STATIONS LOCATOR](https://github.com/JorMerr/EV_charging_locations/blob/main/img/example_stations_locator.JPG)

    ![STATION LOCATIONS TABLE](https://github.com/JorMerr/EV_charging_locations/blob/main/img/cleaned_station_locations.JPG)

- The final Master Table:

    ![MASTER TABLE](https://github.com/JorMerr/EV_charging_locations/blob/main/img/master_table.JPG)

#### Limitations of our Data
- The EV Vehicle Registrations Data is grouped geographically by Province and dates back to 2017. The sum total of registrations was calculated for each location which provided data to estimate the current number of electric vehicles on the road in each province.
- Some provinces do not provide EV registration data to StatsCan and as such, will impact the end result of our model predictions. The provinces which have not shared registration data of electric vehicles are Alberta, Nova Scotia, and Newfoundland and Labrador.
- Median Income was not available for all cities in our dataset. In order to eliminate null values, and retain as much of our station locations data as possible, we elected to use the average provincial value for any null values.
- Unemployment data was not readily accessible for all cities in our station locations dataset. In order to maintain our station locations data we elected to use a provincial average to replace null values.
- The electricity rates included in our dataset use provincial data. This provides a simple way to collect data as an average value. This data does not include any electricity company rates that are more localized than the provincial average such as HydroOttawa, or Rideau St.Lawrence Distribution Inc. in Ontario.
- Our education level dataset uses provincial averages in place of specific levels of education acheived for each city.

*It is possible that with time and resources outside the scope of this project that these limitations may be overcome or eliminated.*


### Preprocessing
- Prior to the training of our machine learning model several steps of data preprocessing were completed. The master table with all of our features and our target variable was read from the S3 bucket which stores our dataset.

- The full dataset was copied to retain the integrity of our master table. 

- The dataset dropped city identifier columns.
    ![Drop City Identifiers](https://github.com/JorMerr/EV_charging_locations/blob/main/img/drop_city_ids.JPG)

- The final categorical column "incentives_status" was saved as a separate variable for the dataset. The "incentives_status" variable was then passed through to OneHotEncoder to retrieve the feature names for whether a city received provincial Electric Vehicle incentives or not.

    ![ENCODE CATEGORICAL DATA](https://github.com/JorMerr/EV_charging_locations/blob/main/img/encode_cat_data.JPG)

- The encoded columns were merged back to each dataset, and the original "incentives_status" was dropped alongside the "incentives_status_NO" column. Dropping the "incentives_status_NO" column was intentionally done due to the fact that the "inecentives_status_YES" column contained all the relevant information.

- After merging the encoded data, the dataframe was split into our target variable column and the features columns

    ![TARGET AND FEATURE VARIABLES](https://github.com/JorMerr/EV_charging_locations/blob/main/img/target_feature_vars.JPG)

- The data was then split using the default train_test_split method. This split in our dataset worked out to be approximately 75% training data, and 25% testing data. 

The testing data was held unseen by the machine learning model for later validation of model accuracy. Identical preprocessing steps were taken for the training and testing datasets, as outlined below.

![SPLITTING THE DATA](https://github.com/JorMerr/EV_charging_locations/blob/main/img/train_test_split.JPG)


### Model Choice
We chose to use the RandomForestRegressor machine learning model. This model was chosen after having conducted some comparison of other linear regression algorithms using PyCaret. The RandomForestRegressor consistently performed as a top level contender after multiple iterations of PyCaret's <compare_models> method. 

![PyCaret COMPARE MODELS](https://github.com/JorMerr/EV_charging_locations/blob/main/img/pycaret_compare_models.JPG)

![RANDOMFORESTREGRESSOR MODEL](https://github.com/JorMerr/EV_charging_locations/blob/main/img/pycaret_createmodel_randomforestregressor.JPG)

![RFREG TEST SCORE](https://github.com/JorMerr/EV_charging_locations/blob/main/img/testing_accuracy.JPG)

One other model was considered as a candidate for our purposes. The OrthogonalMatchingPursuit model performed well in some of the PyCaret comparisons, but when tuning the model using our split dataset, OrthogonalMatchingPursuit was unable to consistently perform at a minimum accuracy level of 70%.

![PyCaret TUNED OMP](https://github.com/JorMerr/EV_charging_locations/blob/main/img/pycaret_tuned_omp.JPG)


## Final results
Our trained machine learning model was able to predict how many electric vehicle charging station locations a city can support at this time with 75% accuracy. This level of accuracy has exceeded our target of 70%, and provides reasonable confidence that the model will provide insights into cities which may benefit from further public electric vehicle infrastructure.

Our model is a snapshot of current statistics based on the features we explored. It must be noted that the model is subject to the limitations of our dataset as outlined previously and with more features or more specific datasets for cities it is possible that our model will perform at a higher accuracy level. 

Our model will be able to be updated as new data becomes available by running our code necessary to perform ETL processes and data preprocessing. Such updates may include quarterly statistics regarding electric vehicle registrations in Canada, updates to the NRCAN source which lists existing, planned, and temporarily closed electric vehicle charging stations, or new census data from Statistics Canada.

### Recommendations for further analysis
Future users of our project may choose to include some or all of the following recommendations for additional features:
    - Influence of political party representation in a given city
    - Infrastructure investments in Electric Vehicles in the past 10 years
    - Impact of the amount of provincial incentives for electric vehicles
    - Percentage of vehicles registered are Electric vs fossil fuel or other fuel sources
    - Whether a station provides fast charging or not
    - Whether a station utlizies any form of Solar Energy collection and charging

## The Dashboard
In order to provide an interactive dashboard for exploring our data features and predictions, we have created a Tableau Dashboard, which can be found at [this link](https://public.tableau.com/app/profile/elysee.manzi/viz/Electric_Vehicle_Canada/Dashboard1)


## Final Presentation
To view the Google Slides presentation of our project, please follow [this link](https://docs.google.com/presentation/d/1W5Oujguz8QI4ABw9R7OA1TJrKt9auE0PjM4C-ivxvDo/edit#slide=id.p).