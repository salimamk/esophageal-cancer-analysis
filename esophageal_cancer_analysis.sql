--  1. Check all tables in the database
SELECT *
FROM patients;

SELECT *
FROM cancer_stage;

SELECT *
FROM treatment;

SELECT *
FROM risk_factors;


--  2. Count of Patients by Cancer Stage
SELECT stage, COUNT(*) AS patient_count
FROM cancer_stage
GROUP BY stage
ORDER BY patient_count DESC;

--  3. Average Age of Patients by Cancer Stage
SELECT cs.stage, ROUND(AVG(p.age), 1) AS avg_age
FROM cancer_stage cs
JOIN patients p ON cs.patient_id = p.patient_id
GROUP BY cs.stage
ORDER BY avg_age DESC;

--  4. Most Common Treatment Type
SELECT treatment_type, COUNT(*) AS count
FROM treatment
GROUP BY treatment_type
ORDER BY count DESC;

--  5. Relationship Between Risk Factors and Cancer Stage
SELECT cs.stage, rf.smoking_status, rf.alcohol_use, COUNT(*) AS patient_count
FROM cancer_stage cs
JOIN risk_factors rf ON cs.patient_id = rf.patient_id
GROUP BY cs.stage, rf.smoking_status, rf.alcohol_use
ORDER BY cs.stage, patient_count DESC;

--  6. Hospital with Most Admissions
SELECT hospital_name, COUNT(*) AS admissions
FROM hospital_visits
GROUP BY hospital_name
ORDER BY admissions DESC;

--  Save Key Findings to a Summary Table
CREATE TABLE cancer_summary (
    metric TEXT,
    value TEXT
);

INSERT INTO cancer_summary (metric, value)
VALUES 
('Most common cancer stage', (SELECT stage FROM cancer_stage GROUP BY stage ORDER BY COUNT(*) DESC LIMIT 1)),
('Average age of Stage IV patients', (SELECT ROUND(AVG(p.age), 1) FROM patients p JOIN cancer_stage cs ON p.patient_id = cs.patient_id WHERE cs.stage = 'Stage IV')),
('Most common treatment', (SELECT treatment_type FROM treatment GROUP BY treatment_type ORDER BY COUNT(*) DESC LIMIT 1)),
('Hospital with most admissions', (SELECT hospital_name FROM hospital_visits GROUP BY hospital_name ORDER BY COUNT(*) DESC LIMIT 1));

--  Copy Summary to a CSV file
DROP TABLE IF EXISTS cancer_summary;

CREATE TABLE cancer_summary AS
SELECT cs.stage, COUNT(p.patient_id) AS patient_count, ROUND(AVG(p.age), 1) AS avg_age
FROM cancer_stage cs
JOIN patients p ON cs.patient_id = p.patient_id
GROUP BY cs.stage
ORDER BY avg_age DESC;

SELECT * FROM cancer_summary;










