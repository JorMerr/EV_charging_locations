# Final Project

## Project Goal
    Using publicly available datasets, determine how many electric vehicle charging stations can a community support?

## Sources of Data
- **[NRCAN ELECTRIC CHARGING AND ALTERNATIVE FUELLING STATIONS LOCATOR](https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/)**

- **[LABOUR FORCE SURVEY](https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm)**

- **[NEW ZERO-EMISSION VEHICLE REGISTRATIONS- QUARTERLY](https://doi.org/10.25318/2010002501-eng)**

### Data Features
- Population
- Median Income
- Highest Education Level Acheived
- Electric Vehicle Sales Since 2017

### Limitations of Data
- EV Vehicle Sales Data is grouped geographically by Province
- EV Vehicle Sales Data dates back to 2017
    - sum total sales to have estimate of EV on road today
- Labour Force Statistics (Features Dataset) is grouped geographically by province
- Some provinces do not provide EV sales data to StatsCan, may need to drop these provinces from analysis

### Definitions of terms
**Community**
*postal code;dissemination area; census area*

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
- pie chart percentage change of EV registrations since 2011 (use annual vehicle registrations dataset, Tableau)
- comparison of median income to EV registrations or charging stations
- comparison of median education level to EV registrations or charging stations
- 


### 


## First Segment
### Presentation
#### Content - J first draft, E edit/proof
- [ ] Selected Topic
- [ ] Reason they selected the topic
- [ ] Description of the source of data
- [ ] Questions they hope to answer with the data

### GitHub Repository
#### Main Branch
- [x] include README

#### README.md
- [ ] Description of the communication protocols

#### Individual Branches
- [x] At least one branch for each team member
- [ ] Each team member has at least four commits for the duration of the first segment

### Machine Learning Model - 
- [ ] Takes in Data from the provisional database
- [ ] Outputs label for input data

### Database Integration - E
- [ ] Sample data that mimics the expected final database structure or schema
- [ ] Draft machine learning model is connected to the provisional database

### Tasks
- [ ] Merge J-code to main
- [ ] Merge E-code to main
- [ ] clean census data - E
- [ ] clean statcan EV registrations - J
- [ ] clean statcan LFS table - E
- [ ] filter charging station json data - J
- [ ] Load data to S3 bucket - Both
- [ ] import to pgAdmin for joining and extra cleaning - E
- [ ] export sample table with 1000 rows to test ML Models - E

## Second Segment
### Presentation
#### Content
- [ ] Description of the data exploration phase of the project
- [ ] Description of the analysis phase of the project

#### Slides
- [ ] Presentations are drafted in Google Slides

### GitHub Repository
#### Main Branch
- [ ] all code necessary to perform exploratory analysis
- [ ] Some code necessary to complete the machine learning portion of project

#### README.md
- [ ] Outline of the project (this may include images, but they should be easy to follow and digest)

#### Individual Branches
- [ ] At least one branch for each team member
- [ ] Each team member has at least four commits for the duration of the second segment (eight total commits per person)

### Machine Learning Model
- [ ] Description of preliminary data preprocessing
- [ ] Description of preliminary feature engineering and preliminary feature selection, including the decision-making process
- [ ] Description of how data was split into training and testing sets
- [ ] Explanation of model choice, including limitations and benefits

### Database integration
- [ ] Database stores static data for use during the project
- [ ] Database interfaces with the project in some format (e.g., scraping updates the database)
- [ ] Includes at least two tables (or collections, if using MongoDB)
- [ ] Includes at least one join using the database language (not including any joins in Pandas)
- [ ] Includes at least one connection string (using SQLAlchemy or PyMongo)
*If using SQL database, provide ERD with relationships*

### Dashboard
- [ ] Storyboard on Google Slides
- [ ] Description of the tool(s) that will be used to create the final dashboard
- [ ] Description of interactive element(s)


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
- [ ] At least one branch for each team member
- [ ] Each team member has at least four commits for the duration of the third segment (12 total commits per person)

### Machine Learning Model
- [ ] Description of data preprocessing
- [ ] Description of feature engineering and the feature selection, including the decision-making process
- [ ] Description of how data was split into training and testing sets
- [ ] Explanation of model choice, including limitations and benefits
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
- [ ] At least one branch for each team member
- [ ] Each team member has at least four commits for the duration of the final segment (16 total commits per person)
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