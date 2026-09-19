CREATE TABLE HOSPITALS (
	HOSPITAL_NAME VARCHAR(200),
	LOCATION_OF_HOSPITAL VARCHAR(200),
	DEPARTMENT VARCHAR(200),
	DOCTORS_COUNT INT,
	PATIENTS_COUNT INT,
	ADMISSION_DATE DATE,
	DISCHARGE_DATE DATE,
	MEDICAL_EXPENSES NUMERIC(10, 2)
);

SELECT * FROM HOSPITALS;


-- 1) Total Number of Patients.
-- Write an SQL query to find the total number of patients across all hospitals.

SELECT SUM(patients_count) AS TOTAL_NO_OF_PATIENTS FROM HOSPITALS;

-- 2) Average Number of Doctors Per Hospital.
-- Retrieve the average count of doctors available in each hospital.
SELECT hospital_name, AVG(doctors_count) AS AVG_NO_OF_DOCTOR FROM HOSPITALS
GROUP BY hospital_name;

-- 3) Top 3 Departments with the Highest Number of Patients.
-- Find the top 3 hospital departments that have the highest number of patients.
SELECT department,
       SUM(patients_count) AS TOTAL_PATIENTS
FROM HOSPITALS
GROUP BY department
ORDER BY TOTAL_PATIENTS DESC
LIMIT 3;


-- 4) Hospital with the Maximum medical expenses.
-- Identify the hospital that recorded the highest medical expenses.
SELECT hospital_name, medical_expenses FROM HOSPITALS
ORDER BY MEDICAL_EXPENSES DESC
LIMIT 1;

-- 5) Daily Average Medical Expenses
-- Calculate the average medical expenses per day for each hospital.
SELECT hospital_name,
       AVG(
           medical_expenses /
           NULLIF((discharge_date - admission_date), 0)
       ) AS avg_daily_expense
FROM hospitals
GROUP BY hospital_name;

-- 6) Longest Hospital Stay
-- Find the patient with the longest stay calculating the difference between discharge date and admission date.

SELECT hospital_name, AGE(discharge_date, admission_date) AS TOTAL_STAY FROM HOSPITALS 
ORDER BY TOTAL_STAY DESC LIMIT 1;

-- 7) Total patients treated per city
-- count the total number of patients treated in each city

SELECT location_of_hospital, SUM(patients_count) AS TOTAL_PATIENTS_TREATED
FROM HOSPITALS 
GROUP BY location_of_hospital
ORDER BY TOTAL_PATIENTS_TREATED DESC;

-- 8) Average length of stay per department.
-- Calculate the average number of days patients spend in each department.

SELECT department, AVG(discharge_date - admission_date) AS AVG_LENGTH_OF_STAY_DAYS
FROM HOSPITALS 
GROUP BY DEPARTMENT;

-- 9)Identify the Department with the lowest number of patients.
-- Find the department with the least number of patients.
SELECT DEPARTMENT, SUM(PATIENTS_COUNT) AS LOWEST_PATIENT FROM HOSPITALS
GROUP BY DEPARTMENT
ORDER BY LOWEST_PATIENT ASC LIMIT 1;

-- 10) Monthly medical expenses report
-- Group the data by month and calculate the total medical expense for each month

SELECT DATE_TRUNC('month', admission_date) AS months,
       SUM(medical_expenses) AS medical_expense_month_wise
FROM hospitals
GROUP BY months
ORDER BY months;

