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

    ![NEW ZEV REGISTRATIONS]()


- [NRCAN ELECTRIC CHARGING AND ALTERNATIVE FUELLING STATIONS LOCATOR](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/)
    - This dataset is collected using an API call to NREL (National Renewable Energy Library) to access their database of Alternative Fuel Stations
    - See a snapshot of the Alternative Fuelling Stations Locator below:

        ![ALT STATIONS LOCATOR]()

    ![STATION LOCATIONS TABLE]()



- The final Master Table:

    ![MASTER TABLE]()

### Preprocessing
- Prior to the training of our machine learning model several steps of data preprocessing were completed. The master table with all of our features and our target variable was read from the S3 bucket which stores our dataset.

- The full dataset was copied to retain the integrity of our master table. 

- The dataset dropped city identifier columns.

- The final categorical column "incentives_status" was saved as a separate variable for the dataset. The "incentives_status" variable was then passed through to OneHotEncoder to retrieve the feature names for whether a city received provincial Electric Vehicle incentives or not.

    ![ENCODE CATEGORICAL DATA]()

- The encoded columns were merged back to each dataset, and the original "incentives_status" was dropped alongside the "incentives_status_NO" column. Dropping the "incentives_status_NO" column was intentionally done due to the fact that the "inecentives_status_YES" column contained all the relevant information.

- After merging the encoded data, the dataframe was split into our target variable column and the features columns

    ![TARGET AND FEATURE VARIABLES]()

The copied table was then split using the train_test_split utility from scikit-learn. The testing data was held unseen by the machine learning model for later validation of model accuracy.

    ![SPLITTING THE DATA]()

### Model Choice
We chose to use the RandomForestRegressor machine learning model. This model was chosen after having conducted some comparison of other linear regression algorithms using PyCaret. The RandomForestRegressor consistently performed as a top level contender after multiple iterations of PyCaret's <compare_models> method. 

    ![PyCaret COMPARE MODELS]()

    ![RANDOMFORESTREGRESSOR MODEL]()

    ![RFREG TRAIN SCORE]()

    ![RFREG TEST SCORE]()

One other model was considered as a candidate for our purposes. The OrthogonalMatchingPursuit model performed well in some of the PyCaret comparisons, but when tuning the model using our split dataset, OrthogonalMatchingPursuit was unable to consistently perform at a minimum accuracy level of 70%.

    ![PyCaret TUNED OMP]()


## The Dashboard
Lorem ipsum dolor sit amet, consectetur adipiscing elit 




## Communication Protocols
This is a brief outline of the communication protocols for this project. It outlines the frequency, purpose, and method of communication established by the team to ensure consistent communication between the project partners.
### Project Team Meetings
- Regular working meetings Monday and Wednesday 7pm to 9pm
    - Work collaboratively to develop the project
    - Discuss dataset sharing, or merging of GitHub branches to main branch
    - Review and select visualizations of the project
- Additional progress meetings Tuesdays and Thursdays at 7pm
    - Video call meeting
    - Meet for one hour to discuss:
        - progress on individual tasks
        - Merge plans from branches to main
        - Review the combined dataset
        - Plan next steps of the project
        - Discuss any challenges or hurdles

### Project Minor Updates
- Slack message to discuss minor updates and progress checkmarks
