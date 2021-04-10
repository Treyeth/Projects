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
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/employee_exit_experience_dete.png" width="350">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/employee_exit_experience_tafe.png" width="350">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/age_employees_dete.png" width="450">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/age_employees_tafe.png" width="450">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/dissatisfied_career_stage.png" width="450">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/resignations_by_gender_dissatisfaction.png" width="450">
</p>

<p align="center">
<img src="https://github.com/Treyeth/Projects/blob/master/EDA_Employee_Exit_Surveys/Images/resignations_by_age_dissatisfaction.png" width="450">
</p>
