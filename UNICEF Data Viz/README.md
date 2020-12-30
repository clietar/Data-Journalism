#  UNICEF TABLEAU DATA VIZ CHALLENGE 2020

## Subject picked : Educational responses to covid-19-related school closures over 130+ countries  

### This repository contains coding and data files used for building the Tableau dashboard available at : https://public.tableau.com/profile/charleslietar#!/vizhome/DataVizChallenge-UNICEF/AccesstoRemote

Project Goal : Mining and presenting in a meaningful way results from the Survey on National Education Responses to COVID-19 School Closures, led by UNICEF, UNESCO and The World Bannk : http://tcg.uis.unesco.org/survey-education-covid-school-closures/. (second round of data collection)

The dashboard was also built to support UNICEF's Educational mission : "Working around the world to support quality learning for every girl and boy, especially those in greatest danger of being left behind", by highlighting facts and impacts triggered by the Covid-19 pandemic. 
Additional data sources from UNICEF were added to illustrate certain trends (see Raw data files section). 

Facts are presented across 4 educational measure areas : Access to Remote Learning - Learning contents coverage - Teacher support - Tracking student learning. The user is invited to click on circles represented the areas to navigate across the dashboard.

### Raw data files used:

- `detailed_survey_covid_responses.xlsx` : Raw survey data collected from each ministries of Education who contributed to the survey (one row = one respondant),  available here http://tcg.uis.unesco.org/wp-content/uploads/sites/4/2020/10/COVID_SchoolSurvey_R2_Data-and-Codebook.xlsx
- `covid_children_situation_tracking.xlsx` : country-specific dataset from UNICEF's situation tracking dashboard on covid-19 pandemic (filtered on educational fields), available at : https://data.unicef.org/resources/rapid-situation-tracking-covid-19-socioeconomic-impacts-data-viz/
- `attendance_nov2019.xlsx` and `completion_nov2019.xlsx` : school attendance and completion rate in November 2019 (latest datasets available before the pandemic), extracted from  UNICEF databases : https://data.unicef.org/
- `polygones_countries.csv` : polygones shaping all countries in the world, used for plotting the globe in the dashboard 


### Code files built for processing data:

- `Unicef_Data_Cleaning.ipynb`: Notebook in Python used for preparing (cleaning, joining..) raw survey data & UNICEF datasets for the dashboard. 
- `polygones_dataset_building.R` :  R code file used for building the `polygones_countries.csv` dataset from a .shp file 



