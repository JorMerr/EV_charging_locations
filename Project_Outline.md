# Final Project

## Project Goal
Using publicly available datasets, determine how many electric vehicle charging stations can a community support?


### What we hope to achieve:
- Create a machine learning model that will predict the maximum number of Electric Vehicle Charging Stations that a city can support.

## Sources of Data
- **[NRCAN ELECTRIC CHARGING AND ALTERNATIVE FUELLING STATIONS LOCATOR](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/)**

- **[LABOUR FORCE SURVEY](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410039101)**

- **[INCOME TABLE](https://www150.statcan.gc.ca/t1/tbl1/en/cv!recreate.action?pid=9810006401&selectedNodeIds=4D24,5D1&checkedLevels=0D1,0D2,0D3,0D4,1D1,2D1&refPeriods=20210101,20210101&dimensionLayouts=layout3,layout2,layout2,layout2,layout2,layout2&vectorDisplay=false)**

- **[POPULATION COUNTS](https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=9810000203)**

- **[Unemployment Rate](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410029401&pickMembers%5B0%5D=2.5&pickMembers%5B1%5D=3.1&pickMembers%5B2%5D=4.1&cubeTimeFrame.startMonth=12&cubeTimeFrame.startYear=2020&cubeTimeFrame.endMonth=12&cubeTimeFrame.endYear=2020&referencePeriods=20201201%2C20201201)**

- **[NEW ZERO-EMISSION VEHICLE REGISTRATIONS- QUARTERLY](https://doi.org/10.25318/2010002501-eng)**
    @NOTE from StatsCan *To ensure the confidentiality of the Zero-Emission Vehicles (ZEV) data, a process known as Random Tabular Adjustment (RTA) was used. This changes estimates by a random amount and adds a degree of uncertainty to the accuracy of the estimate to prevent the disclosure of individual values. As a result, estimates that could disclose an individual's response are not released. (Note that if the adjusted estimates are part of a table with totals or sub-totals, the related total and sub-total estimates will also be adjusted.)*

### Data Features
- Population
- Median Income
- Highest Education Level Acheived
- Electric Vehicle Sales Since 2017
- Provincial level reimbursement plan as binary value (tax incentive for EV)
- Cities categorized as city/village/town
- how many green party members for each city electoral district
- Electricity rate Kw/h
- Infrastructure investments in EV in past 10 years
- EV charging station forecasting
- 



### Limitations of Data
- EV Vehicle Sales Data is grouped geographically by Province
- EV Vehicle Sales Data dates back to 2017
    - sum total sales to have estimate of EV on road today
- Labour Force Statistics (Features Dataset) is grouped geographically by province
- Some provinces do not provide EV sales data to StatsCan, may need to drop these provinces from analysis

### Definitions of terms
**Community**

*city*


## Communication Protocols
- Slack message updates as items change
- 2 1-hour meetings per week to review project progress
    - Tuesday and Thursday evening video call 7pm
    


## Next steps:
- Find Datasets that will provide sufficient specificity of vehicle sales
- Begin cleaning data for relevant information
    - Charging stations: 
        - status of station > groupby
        - Organize by locations
        - filter for EV chargers
    - LFS Dataset:
        - Find relevant columns, drop unneccesary
        - relable columns for interpretability
        - Scale data?
        - Elysee : *If data available by city or detailed location to increase specificity* **Access to this data may impact our target question and viability of model**
    - vehicle sales:
        - find relevant columns, drop unneccesary
        - groupy EV types to one type, drop gasoline and diesel vehicles
        - groupby province
        - sum total sales by year to grand total
        - Jordan: *If data available by city or detailed location to increase specificity* **Access to this data may impact our target question and viability of model**

- Determine if datasets are dynamic or static
    - likely static
    - load the datasets to database
- mockup of machine learning model with output labels
    - snapshot of dataset to test machine learning model
    - linear regression model
    - features and scaling
    - output = # of charging stations in [area]
- set up basic database schema (ERD)
- connect machine learning model to database for output


### Visualizations
- city data to display as map of Canada with individual points
    - some visual way of identifying existing locations vs predicted by model
- city data to display number of stations as size of point
- bar chart to show total stations predicted in each city (or top 10)
- line graph to show EV registrations over time
- pie chart percentage change of EV registrations since 2017 (use annual vehicle registrations dataset, Tableau)
- comparison of median income to EV registrations or charging stations
- comparison of median education level to EV registrations or charging stations
- 


### 


## First Segment
### Presentation
#### Content - J first draft, E edit/proof
- [x] Selected Topic
- [x] Reason they selected the topic
- [x] Description of the source of data
- [x] Questions they hope to answer with the data

### GitHub Repository
#### Main Branch
- [x] include README

#### README.md
- [x] Description of the communication protocols

#### Individual Branches
- [x] At least one branch for each team member
- [x] Each team member has at least four commits for the duration of the first segment

### Machine Learning Model - 
- [x] Takes in Data from the provisional database
- [x] Outputs label for input data
    - [x] Can we acheive 70% accuracy?

### Database Integration - E
- [x] Sample data that mimics the expected final database structure or schema
- [x] Draft machine learning model is connected to the provisional database
    - [x] Machine learning model template is created

### Tasks
- [x] Merge J-code to main
- [x] Merge E-code to main
- [x] clean census data - E
- [x] clean statcan EV registrations - J
- [x] clean statcan LFS table - E
- [x] filter charging station json data - J
- [x] import to pgAdmin for joining and extra cleaning - E

## Second Segment
### Presentation
#### Content - Jordan to write, Elysee to proofread
- [x] Description of the data exploration phase of the project 
- [x] Description of the analysis phase of the project

#### Slides - Elysee to draft
- [x] Presentations are drafted in Google Slides
    - [x] [Google Slides Presentation](https://docs.google.com/presentation/d/1W5Oujguz8QI4ABw9R7OA1TJrKt9auE0PjM4C-ivxvDo/edit?usp=sharing)
    - [ ] Add slides which include:
        - [ ] purpose of project
        - [ ] analysis of project
        - [ ] model used
        - [ ] results of the project
        - [ ] description or images of data sources
        - [ ] snapshots of some cleaning/code
        - [ ] 

### GitHub Repository
#### Main Branch
- [x] all code necessary to perform exploratory analysis
- [x] Some code necessary to complete the machine learning portion of project

#### README.md - Jordan
- [x] Outline of the project (this may include images, but they should be easy to follow and digest)

#### Individual Branches
- [x] At least one branch for each team member
- [x] Each team member has at least four commits for the duration of the second segment (eight total commits per person)

### Machine Learning Model - Jordan
- [x] Description of preliminary data preprocessing
- [x] Description of preliminary feature engineering and preliminary feature selection, including the decision-making process
- [x] Description of how data was split into training and testing sets *(split 80/20 and saved as new variables for the purposes of adding model predictions back to the datasets)*
- [x] Explanation of model choice, including limitations and benefits
    - *Model used was RandomForestRegressor model*
        - Reason for using this model is that when comparing models using PyCaret, this model performed regularly in top level contenders. The other model option was OrthogonalMatchingPursuit. OrthogonalMatchingPursuit when used outside of PyCaret comparison did not consistently perform to the same level at RandomForestRegressor.

    - Benefits:
        - The model can be fast to train
        - The model works well for datasets of a relatively smaller sample size, such as what was used in our training dataset
    - Limitations:
        - Once trained, the potential for a high number of decision trees can slow the algorithm.
    - [x] Ideal accuracy 70%

### Database integration - Elysee & Jordan
- [x] Database stores static data for use during the project
- [ ] Database interfaces with the project in some format (e.g., scraping updates the database)
- [x] Includes at least two tables (or collections, if using MongoDB)
- [x] Includes at least one join using the database language (not including any joins in Pandas) **Used CTE method instead of join method**
- [ ] Includes at least one connection string (using SQLAlchemy or PyMongo) **What does connection string mean for our project?** 
        *Set up connection to pgAdmin/SQL direct from jupyter notebook*
*If using SQL database, provide ERD with relationships* **Elysee to create ERD**

### Dashboard - Elysee
- [ ] Storyboard on Google Slides
- [ ] Description of the tool(s) that will be used to create the final dashboard
    - [ ] Github pages/flask/herokuapp/
- [ ] Description of interactive element(s) **Will interactivity of Tableau be sufficient, or do we need a flask app** *tableau is sufficient*
    - [ ] Tableau vs Interactive Website Dashboard

## Tasks
- [x] PyCaret optimization of ml model (J)
- [x] Check if CTE/joins count for rubric (E)
- [ ] Review Herokuapp and see if we want to use that or GitHub pages and Bootstrap for our dashboard (E)
- [x] Write-ups of data cleaning and analysis (J)
- [ ] Tableau visualizations (E)
- [ ] ERD for SQL (E)
- [x] Outline of Project with placeholders for images (J)
- [ ] 

## Third Segment
### Presentation
#### Content
- [ ] Technologies, languages, tools, and algorithms used throughout the project 

#### Slides
- [ ] Presentations are drafted in Google Slides

### GitHub Repository
#### Main Branch
- [ ] All code necessary to perform exploratory analysis
- [ ] Most code necessary to complete the machine learning portion of the project

#### README.md
- [ ] Description of the communication protocols has been removed
- [ ] Cohesive, structured outline of the project (this may include images, but they should be easy to follow and digest)
- [ ] Link to Google Slides draft presentation

#### Individual Branches
- [x] At least one branch for each team member
- [x] Each team member has at least four commits for the duration of the third segment (12 total commits per person)

### Machine Learning Model
- [x] Description of data preprocessing
- [x] Description of feature engineering and the feature selection, including the decision-making process
- [x] Description of how data was split into training and testing sets
- [x] Explanation of model choice, including limitations and benefits
- [ ] Explanation of changes in model choice (if changes occurred between the Segment 2 and Segment 3 deliverables)
- [ ] Description of how they have trained the model thus far, and any additional training that will take place
- [ ] Description of current accuracy score
*Additionally, the model obviously addresses the question or problem the team is solving.*

### Database

### Dashboard
- [ ] Images from the initial analysis
- [ ] Data (images or report) from the machine learning task
- [ ] At least one interactive element

## Fourth Segment
### Presentation
#### Content
- [ ] Result of the analysis
- [ ] Recommendation for future analysis
- [ ] Anything the team would have done differently

#### Slides
- [ ] Slides are primarly images or graphics (rather than primarly text)
- [ ] Images are clear, in high-definition, and directly illustrative of subject matter

#### Live Presentation
- [ ] Demonstrates the interactivity of the dashboard in real time
- [ ] Adheres to the time limits provided by intructor
- [ ] Includes speaker notes, flashcards, or a video of the presentation rehearsal

### GitHub Repository
#### Main Branch
- [ ] All code necessary to perform exploratory analysis
- [ ] All code necessary to complete machine learning portion of project
- [ ] Any images that have been created (at least three)
- [ ] Requirements.txt file

#### README.md
- [ ] Cohesive, structured outline of the project (this may include images, but they should be easy to follow and digest)
- [ ] Link to dashboard (or link to video of dashboard demonstration)
- [ ] Link to Google Slides presentation
*The descriptions and explanations required in all other project deliverables should also be in your READme.md as part of your outline, unless otherwise noted.*

#### Individual Branches
- [x] At least one branch for each team member
- [x] Each team member has at least four commits for the duration of the final segment (16 total commits per person)
- [ ] Link to Google Slides draft presentation

### Machine Learning Model
- [ ] Description of data preprocessing
- [ ] Description of feature engineering and the feature selection, including the decision-making process
- [ ] Description of how data was split into training and testing sets
- [ ] Explanation of model choice, including limitations and benefits
- [ ] Explanation of changes in model choice (if changes occurred between the Segment 2 and Segment 3 deliverables)
- [ ] Description of how the model was trained (or retrained, if the team is using an existing model)
- [ ] Description and explanation of model's confusion matrix, including final accuracy score
**Additionally, the model obviously addresses the question or problem the team is solving.**

*If statistical analysis is not included as part of the current analysis, the team should describe how it would be included in the next phases of the project.*

### Database Integration
- [ ] Database stores static data for use during the project
- [ ] Database interfaces with the project in some format (e.g., scraping updates the database)
- [ ] Includes at least two tables (or collections, if using MongoDB)
- [ ] Includes at least one join using the database language (not including any joins in Pandas)
- [ ] Includes at least one connection string (using SQLAlchemy or PyMongo)
*If you use a SQL database, you must provide your ERD with relationships.*

### Dashboard
- [ ] Images from the initial analysis
- [ ] Data (images or report) from the machine learning task
- [ ] At least one interactive element
*Either the dashboard is published or the submission includes a screen capture video of it in action.*