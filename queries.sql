-- check all columns
select * from diabetes;

-- 1. Retrieve the Patient_id and ages of all patients.
SELECT patient_id, age FROM diabetes;

-- 2. Select all female patients who are older than 40.
select * from diabetes where gender = 'Female' and age > 40;
-- There are no female patients older than 40

-- 3. Calculate the average BMI of patients.
select avg(bmi) as average_bmi from diabetes;

-- 4. List patients in descending order of blood glucose levels.
select patient_id, blood_glucose_level
from diabetes
order by blood_glucose_level desc;

-- 5. Find patients who have hypertension and diabetes.
select patient_id, hypertension, diabetes from diabetes
where hypertension = 1 and diabetes = 1;

-- 6. Determine the number of patients with heart disease.
select count(*) as heart_patient from diabetes
where heart_disease = 1;

-- 7. Group patients by smoking history and count how many smokers and non-smokers there are.
select smoking_history, count(smoking_history) as no_of_patient
from diabetes
where smoking_history in ('current', 'never')
group by smoking_history;

-- 8. Retrieve the Patient ids of patients who have a BMI greater than the average BMI.
select patient_id, bmi from diabetes where bmi > (select avg(bmi) as avg_bmi from diabetes);

-- 9. Find the patient with the highest and the lowest HbA1clevel.

-- Highest HbA1c_level level:
select patient_id, HbA1c_level from diabetes
where HbA1c_level = (select max(HbA1c_level) from diabetes);

-- Lowest HbA1c_level level:
select patient_id, HbA1c_level from diabetes
where HbA1c_level = (select min(HbA1c_level) from diabetes);

-- 10. Calculate the age of patients in years (assuming the current date as of now).
select patient_id, age as age_of_patient
from diabetes;

-- 11. Rank patients by blood glucose level within each gender group.
select patient_id, blood_glucose_level, gender,
dense_rank() over(partition by gender order by blood_glucose_level) patient_rank
from diabetes;

-- 12. Update the smoking history of patients who are older than 50 to "Ex-smoker".
update diabetes set smoking_history = "Ex-smoker"
where age > 50;
-- There are no patients in the database aged over 50.

-- 13. Insert a new patient into the database with sample data.
INSERT INTO diabetes VALUES ('Subham Saha', 'PT409991', 'Male', '11-05-1992', 34, 0, 1, 'never', 25.5, 7, 110, 1);
select * from diabetes where Patient_id = 'PT409991';

-- 14. Delete all patients with heart disease from the database.
delete from diabetes where heart_disease = 1;

-- check if records are deleted 
select * from diabetes where heart_disease = 1;

-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
select patient_id, hypertension, diabetes from diabetes
where hypertension = 1
except
select patient_id, hypertension, diabetes from diabetes
where diabetes = 1;

-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
alter table diabetes
add constraint patient_id_constraint unique (patient_id (50));

-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.
create view patient_bmi_details as 
select patient_id, age, bmi
from diabetes;

select * from patient_bmi_details;
