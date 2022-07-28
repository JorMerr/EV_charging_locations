# Presentation Notes

## Selected Topic
For this analysis, we have chosen to create a supervised machine learning model to predict how many Electric Vehicle charging stations cities in Canada can support.

### Reason for the Selected Topic
We have chosen to analyze electric vehicle charging station locations in Canada because we understand that Canada's participation in the transition away from fossil fuels to green energy fuel sources is a crucial step in the battle against climate change. 

A significant portion of greenhouse gas emissions from burning fossil fuels comes from motor vehicles. Canada is on track to ban the sale of new fossil fuel burning cars and light-duty trucks by 2035. 

This transition to environmentally friendly vehicles will require a logistic network of charging stations that can support all electric vehicles on the road. These charging stations must be located in areas to best serve the public, in much the same way that gas stations currently do.

Our model aims to predict how many stations a city can support given a number of features of a city derived from the Canadian Census such as, Population, Median Income, Median Highest Education Level Achieved and New Registrations of Zero Emission Vehicles. With these features our goal is to determine whether the current network of vehicle charging stations is sufficient to meet public demand as adoption of zero emission vehicles increases and identify cities that will benefit from the construction of new charging stations over time.

### Data Sources
Our data has been collected from the following sources using the listed methods below:
- [2021 Census](https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/download-telecharger.cfm?Lang=E)
    - The data is downloaded as a full table CSV file directly from the website
- [LABOUR FORCE SURVEY](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410039101)
    - This dataset is collected using Statistics Canada's Web Data Services public API call.
- [NEW ZERO-EMISSION VEHICLE REGISTRATIONS- QUARTERLY](https://doi.org/10.25318/2010002501-eng)
    - This dataset is collected using Statistics Canada's Web Data Services public API call.
- [NRCAN ELECTRIC CHARGING AND ALTERNATIVE FUELLING STATIONS LOCATOR](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/)
    - This dataset is collected using an API call to NREL (National Renewable Energy Library) to access their database of Alternative Fuel Stations

### What we hope to answer with our data
We hope to answer whether Canadian cities will be sufficiently ready to support the adoption of Zero Emission Vehicles as the transition away from fossil fuel burning vehicles continues. We aim to predict the number of electric vehicle charging stations each city can support based on key demographic information.

## Data Exploration and Analysis

### Data Exploration
During the data exploration phase of the project, we discovered that our data sources were incomplete, or had a reduced availability of data. Our intent was to locate information on a city-level basis in order to train our machine learning model to predict the number of stations each city can support. 

With some of our datasets only providing data for roughly 25 to 30 cities we needed to locate additional data and reassess our features that we wanted to analyze. 

We managed to locate additional datasets for features such as population, median income, education level percentage, and electricity rates.

### Data Analysis
During the data analysis phase of our project, we performed the cleaning and transformation of our datasets. We discovered that some of our datasets managed to provide data at the city level. We also discovered that some values were missing from features such as population, median income, education level percentage, and electricity rates for cities within our EV charging station locations data. 

For missing values we decided to utilize a provincial average for missing values. This allowed us to have a larger dataset with which to train our machine learning model. 

The potential drawback of using a provincial average for missing values is that it will result in less variance, and our model may struggle to accurately predict the suitable number of EV charging stations for a city if that city's featurs are significantly different than the provincial average. For example, a large metropolitan city such as Toronto likely has a significantly different median income and education level than a smaller rural Ontario city. Additionally, using provincial electricity rates for some cities will not take in to account cities which have locally operated electrical companies such as Hydro Ottawa. These rates may differ significantly from the provincial average.


## Machine learning model

### Preliminary Data Preprocessing
Prior to the training of our machine learning model several steps of data preprocessing were completed. The master table with all of our features and our target variable was read from the S3 bucket which stores our dataset.

The full dataset was copied to retain the integrity of our master table. The copied table was then split using a sample of 80% as the training data, and 20% as the testing data. The testing data was held unseen by the machine learning model for later validation of model accuracy.

The training and testing sets were each copied with columns identifying each city removed from the dataframe such as "id", "province_name" "city", etc..

The final categorical column "incentives_status" was saved as separate variables for both the training and testing data sets. The "incentives_status" variables were then passed through to OneHotEncoder to retrieve the feature names for whether a city received provincial Electric Vehicle incentives or not. The

The encoded columns were merged back to each dataset, and the original "incentives_status" was dropped alongside the "incentives_status_NO" column. Dropping the "incentives_status_NO" column was intentionally done due to the fact that the "inecentives_status_YES" column contained all the relevant information.

After merging the encoded data, the training set of data was split into our target variable column and the features columns


### Preliminary Feature Engineering and Selection
The features we chose to use for our machine learning model and the assumptions used in selecting the features are as follows:
    - Population
        - With a higher population, the city will require more stations to be available
    - Median Income
        - Electric Vehicles have historically been sold at a premium, and if the median income is insufficient to purchase either an Electric Vehicle, or a vehicle at all, the city is less likely to require charging stations
    - Unemployment Rate
        - Similar to median income, if a significant percentage of the population in a city is unemployed, there is not sufficent income to purchase a vehicle, electric or otherwise
    - Electricity Price
        - Given that electric vehicles by nature use electricity as their fuel source, the price of electricity has an impact on the long term costs of operating an electric vehicle
    - Electric Vehicle Registations Per City Since 2017
        - The higher the number of electric vehicles registered in a city, the more likely the population of that city will require the charging station infrastructure to support them 
    - Provincial Electric Vehicle Incentive Status
         - While national incentives are available for purchases of electric vehicles, some provinces and territories are not providing incentives. The availability of such purchase incentives will impact the upfront cost of electric vehicles and may slow the uptake by the population
    - Sum of Electric Vehicles Sold per Province since 2017
        - The higher the number of electric vehicles registered in a province, the more likely the population of that province will require the charging station infrastructure to support them when travelling between cities or visiting larger metropolitan areas.
    - Percentage of Highest Education Level Achieved
        - The level of education acheived by the population of a city impacts their ability to earn higher incomes. The higher the percentage of higher education acheived the more likely that population earns sufficient income to purchase and operate an electric vehicle. Additionally, it may be possible that the population with a higher level of education acheived is more inclined to adopt technologies which reduce fossil fuel consumption as the types of employment are less dependent on those same fossil fuel technologies.
    

### Data Testing and Training Split
Our dataset was split as 80% used for training, and 20% used for testing the accuracy of the model. This split was chosen as it would provide sufficient rows of data to train the model at over 1000 rows. This also left nearly 350 rows for our testing dataset. 


### Model Choice
We chose to use the RandomForestRegressor machine learning model. This model was chosen after having conducted some comparison of other linear regression algorithms using PyCaret. The RandomForestRegressor consistently performed as a top level contender after multiple iterations of PyCaret's <compare_models> method. 

One other model was considered as a candidate for our purposes. The OrthogonalMatchingPursuit model performed well in some of the PyCaret comparisons, but when tuning the model using our split dataset, OrthogonalMatchingPursuit was unable to consistently perform at a minimum accuracy level of 70%.

#### Benefits
The benefits of using the RandomForestRegressor model is that is can be very quick to train this model. Our dataset, being of a relatively smaller sample size, was suitable for this type of model to be able to provice quick and accurate predictions.
#### Limitations
The RandomForestRegressor model's limiation is that with larger datasets the trained model may require a higher number of decision trees and will slow down in real-world application of big data.