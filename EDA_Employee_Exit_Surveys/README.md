# Cleaning and Analyzing Employee Exit Surveys

In this project we will use the exit surveys from employees of the <b>Department of Education, Training and Employment (DETE)</b> and the <b>Technical and Further Education (TAFE)</b> institute in Queensland, Australia. The TAFE exit survey can be found __[here](https://data.gov.au/dataset/ds-qld-89970a3b-182b-41ea-aea2-6f9f17b5907e/details?q=exit%20survey)__ and the survey for the DETE __[here](https://data.gov.au/dataset/ds-qld-fe96ff30-d157-4a81-851d-215f2a0fe26d/details?q=exit%20survey)__ .

<h2> Short introduction to our data</h2>

---
There are 2 data sources, dete_survey.csv and tafe_survey.csv.

Some of the important in <i>dete_survey.csv</i> we can find:

<ul>
    <li><b>ID</b>: An id used to identify the participant of the survey
    <li><b>SeparationType</b>: The reason why the person's employment ended
    <li><b>Cease Date</b>: The year or month the person's employment ended
    <li><b>DETE Start Date</b>: The year the person began employment with the DETE
</ul>

Meanwhile, in <i>tafe_survey.csv</i>:
<ul>
    <li><b>Record ID</b>: An id used to identify the participant of the survey
    <li><b>Reason for ceasing employment</b>: The reason why the person's employment ended
    <li><b>LengthofServiceOverall. Overall Length of Service at Institute (in years)</b>: The length of the person's employment (in years)
</ul>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/employee_exit_experience_dete.png" width="300">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/employee_exit_experience_tafe.png" width="300">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/age_employees_dete.png" width="450">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/age_employees_tafe.png" width="450">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/dissatisfied_career_stage.png" width="400">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/resignations_by_gender_dissatisfaction.png" width="450">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/resignations_by_age_dissatisfaction.png" width="450">
</p>

<h2> Recap </h2>

---

* Explored the data and figured out how to prepare it for analysis
* Corrected some of the missing values
* Dropped any data not needed for our analysis
* Renamed our columns
* Verified the quality of our data
* Created a new institute_service column
* Cleaned the Contributing Factors columns
* Created a new column indicating if an employee resigned because they were dissatisfied in some way
* Combined the data
* Cleaned the institute_service column
* Handled the missing values in the dissatisfied column
* Aggregated the data

<h2> Conclusions </h2>

---

Our initial questions were:

1. Are employees who only worked for the institutes for a short period of time resigning due to some kind of dissatisfaction? What about employees who have been there longer?

2. Are younger employees resigning due to some kind of dissatisfaction? What about older employees?
* Based on the analysis, it can be said that the most dissatisfied employees were those <b>Experienced (3-7 years of work in the institute)</b> and the <b>Veteran ones (11 + years)</b>.
* The most common age bracket for the workers in both institutes is <b>41-45</b> years old.
* <b>TAFE</b> has a problem with <b>New employees (< 3 years)</b> and <b>Experienced ones (3-7 years)</b> resigning, while <b>DETE</b> has a problem with the more experienced ones <b>Veteran (11+ years)</b> and <b>Established (7-11 years)</b>.
* More <b>male</b> than <b>female</b> workers have been dissatisfied with their job in both institutes.
* <b>DETE workers</b> are much more dissatisfied with their job than their counterpart at <b>TEFE</b> with <b>DETE</b> workers hovering around <b>50-60% dissatisfaction</b> and <b>TAFE workers</b> at <b>30%</b> at all age brackets.
* New workers are the most unlikely to resign due to dissatisfaction, while the ones that stayed for a long time in the institute are likely to do so.
