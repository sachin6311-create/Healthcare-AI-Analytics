-- ============================================================
-- HEALTHCARE AI ANALYTICS PROJECT
-- SQL ANALYSIS
-- Source: healthcare_clean.csv
-- Pipeline: Azure Data Factory -> Azure MySQL -> Power BI
-- ============================================================

-- Actual columns:
-- patient_id, patient_name, gender, age, city, department,
-- diagnosis, admission_type, admission_date, doctor_id,
-- machine_id, machine_type, machine_status, usage_hours,
-- test_count, treatment_cost, insurance_type, payment_status,
-- discharge_date, revenue

use healthcare_ai_etl;
-- ============================================================
-- 1. EXECUTIVE KPI ANALYSIS
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT patient_id) AS unique_patients,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(treatment_cost), 2) AS total_treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS net_revenue,
    ROUND(AVG(revenue), 2) AS avg_revenue_per_record,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost,
    ROUND(AVG(age), 2) AS avg_patient_age
FROM healthcare_clean;


-- ============================================================
-- 2. REVENUE BY DEPARTMENT
-- ============================================================

SELECT
    department,
    COUNT(*) AS patient_records,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS net_revenue
FROM healthcare_clean
GROUP BY department
ORDER BY total_revenue DESC;


-- ============================================================
-- 3. TOP 5 DEPARTMENTS BY REVENUE
-- ============================================================

SELECT
    department,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue
FROM healthcare_clean
GROUP BY department
ORDER BY revenue DESC
LIMIT 5;


-- ============================================================
-- 4. DEPARTMENT PROFITABILITY
-- ============================================================

SELECT
    department,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS profit,
    ROUND(
        100 * SUM(revenue - treatment_cost)
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM healthcare_clean
GROUP BY department
ORDER BY profit DESC;


-- ============================================================
-- 5. MONTHLY REVENUE TREND
-- ============================================================

SELECT
    DATE_FORMAT(admission_date, '%Y-%m') AS month,
    COUNT(*) AS patient_records,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost
FROM healthcare_clean
GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 6. MONTH-OVER-MONTH REVENUE GROWTH
-- ============================================================

WITH monthly AS (
    SELECT
        DATE_FORMAT(admission_date, '%Y-%m') AS month,
        SUM(revenue) AS revenue
    FROM healthcare_clean
    GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
),
growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month
    FROM monthly
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month, 2) AS previous_month,
    ROUND(
        100 * (revenue - previous_month)
        / NULLIF(previous_month, 0),
        2
    ) AS mom_growth_pct
FROM growth
ORDER BY month;


-- ============================================================
-- 7. GENDER ANALYSIS
-- ============================================================

SELECT
    gender,
    COUNT(*) AS patients,
    ROUND(
        100 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS patient_percentage,
    ROUND(SUM(revenue), 2) AS revenue
FROM healthcare_clean
GROUP BY gender
ORDER BY patients DESC;


-- ============================================================
-- 8. AGE GROUP ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM healthcare_clean
GROUP BY
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END
ORDER BY patients DESC;


-- ============================================================
-- 9. TOP 10 CITIES
-- ============================================================

SELECT
    city,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue
FROM healthcare_clean
WHERE city IS NOT NULL
  AND TRIM(city) <> ''
GROUP BY city
ORDER BY patients DESC
LIMIT 10;


-- ============================================================
-- 10. DIAGNOSIS ANALYSIS
-- ============================================================

SELECT
    diagnosis,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM healthcare_clean
GROUP BY diagnosis
ORDER BY patients DESC;


-- ============================================================
-- 11. TOP 5 DIAGNOSES
-- ============================================================

SELECT
    diagnosis,
    COUNT(*) AS patients
FROM healthcare_clean
GROUP BY diagnosis
ORDER BY patients DESC
LIMIT 5;


-- ============================================================
-- 12. ADMISSION TYPE ANALYSIS
-- ============================================================

SELECT
    admission_type,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM healthcare_clean
GROUP BY admission_type
ORDER BY patients DESC;


-- ============================================================
-- 13. ADMISSION TYPE BY PAYMENT STATUS
-- ============================================================

SELECT
    admission_type,
    payment_status,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue
FROM healthcare_clean
GROUP BY admission_type, payment_status
ORDER BY admission_type, revenue DESC;


-- ============================================================
-- 14. PAYMENT STATUS ANALYSIS
-- ============================================================

SELECT
    payment_status,
    COUNT(*) AS records,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost
FROM healthcare_clean
GROUP BY payment_status
ORDER BY revenue DESC;


-- ============================================================
-- 15. PENDING REVENUE
-- ============================================================

SELECT
    COUNT(*) AS pending_records,
    ROUND(SUM(revenue), 2) AS pending_revenue
FROM healthcare_clean
WHERE payment_status = 'Pending';


-- ============================================================
-- 16. INSURANCE PERFORMANCE
-- ============================================================

SELECT
    insurance_type,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS net_revenue
FROM healthcare_clean
GROUP BY insurance_type
ORDER BY revenue DESC;


-- ============================================================
-- 17. INSURANCE BY PAYMENT STATUS
-- ============================================================

SELECT
    insurance_type,
    payment_status,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue
FROM healthcare_clean
GROUP BY insurance_type, payment_status
ORDER BY insurance_type, revenue DESC;


-- ============================================================
-- 18. DOCTOR PERFORMANCE
-- ============================================================

SELECT
    doctor_id,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS net_revenue
FROM healthcare_clean
WHERE doctor_id IS NOT NULL
GROUP BY doctor_id
ORDER BY revenue DESC;


-- ============================================================
-- 19. DOCTOR REVENUE RANKING
-- ============================================================

SELECT
    doctor_id,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM healthcare_clean
WHERE doctor_id IS NOT NULL
GROUP BY doctor_id
ORDER BY revenue_rank;


-- ============================================================
-- 20. MACHINE UTILIZATION
-- ============================================================

SELECT
    machine_type,
    COUNT(*) AS records,
    ROUND(SUM(usage_hours), 2) AS total_usage_hours,
    ROUND(AVG(usage_hours), 2) AS avg_usage_hours
FROM healthcare_clean
GROUP BY machine_type
ORDER BY total_usage_hours DESC;


-- ============================================================
-- 21. MACHINE STATUS ANALYSIS
-- ============================================================

SELECT
    machine_status,
    COUNT(*) AS records,
    ROUND(SUM(usage_hours), 2) AS usage_hours
FROM healthcare_clean
GROUP BY machine_status
ORDER BY records DESC;


-- ============================================================
-- 22. MACHINE TYPE BY STATUS
-- ============================================================

SELECT
    machine_type,
    machine_status,
    COUNT(*) AS records,
    ROUND(SUM(usage_hours), 2) AS usage_hours
FROM healthcare_clean
GROUP BY machine_type, machine_status
ORDER BY machine_type, records DESC;


-- ============================================================
-- 23. TOP 10 MOST UTILIZED MACHINES
-- ============================================================

SELECT
    machine_id,
    machine_type,
    ROUND(SUM(usage_hours), 2) AS total_usage_hours,
    COUNT(*) AS usage_records
FROM healthcare_clean
WHERE machine_id IS NOT NULL
GROUP BY machine_id, machine_type
ORDER BY total_usage_hours DESC
LIMIT 10;


-- ============================================================
-- 24. TREATMENT COST BY DEPARTMENT
-- ============================================================

SELECT
    department,
    ROUND(AVG(treatment_cost), 2) AS avg_cost,
    ROUND(MIN(treatment_cost), 2) AS min_cost,
    ROUND(MAX(treatment_cost), 2) AS max_cost,
    ROUND(SUM(treatment_cost), 2) AS total_cost
FROM healthcare_clean
GROUP BY department
ORDER BY avg_cost DESC;


-- ============================================================
-- 25. REVENUE VS TREATMENT COST
-- ============================================================

SELECT
    department,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS net_revenue
FROM healthcare_clean
GROUP BY department
ORDER BY net_revenue DESC;


-- ============================================================
-- 26. LENGTH OF STAY
-- ============================================================

SELECT
    patient_id,
    admission_date,
    discharge_date,
    DATEDIFF(discharge_date, admission_date) AS length_of_stay
FROM healthcare_clean;


-- ============================================================
-- 27. AVERAGE LENGTH OF STAY BY DEPARTMENT
-- ============================================================

SELECT
    department,
    ROUND(
        AVG(DATEDIFF(discharge_date, admission_date)),
        2
    ) AS avg_length_of_stay
FROM healthcare_clean
WHERE discharge_date IS NOT NULL
  AND admission_date IS NOT NULL
GROUP BY department
ORDER BY avg_length_of_stay DESC;


-- ============================================================
-- 28. MISSING VALUE ANALYSIS
-- ============================================================

SELECT
    SUM(CASE WHEN city IS NULL OR TRIM(city) = '' THEN 1 ELSE 0 END)
        AS missing_city,
    SUM(CASE WHEN doctor_id IS NULL OR TRIM(doctor_id) = '' THEN 1 ELSE 0 END)
        AS missing_doctor,
    SUM(CASE WHEN machine_id IS NULL OR TRIM(machine_id) = '' THEN 1 ELSE 0 END)
        AS missing_machine,
    SUM(CASE WHEN insurance_type IS NULL OR TRIM(insurance_type) = '' THEN 1 ELSE 0 END)
        AS missing_insurance
FROM healthcare_clean;


-- ============================================================
-- 29. <Na> INSURANCE QUALITY CHECK
-- ============================================================

SELECT
    COUNT(*) AS na_insurance_records,
    ROUND(SUM(revenue), 2) AS affected_revenue
FROM healthcare_clean
WHERE insurance_type = '<Na>';


-- ============================================================
-- 30. DUPLICATE PATIENT IDs
-- ============================================================

SELECT
    patient_id,
    COUNT(*) AS record_count
FROM healthcare_clean
GROUP BY patient_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


-- ============================================================
-- 31. RANK DEPARTMENTS BY REVENUE
-- ============================================================

SELECT
    department,
    ROUND(SUM(revenue), 2) AS revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM healthcare_clean
GROUP BY department
ORDER BY revenue_rank;


-- ============================================================
-- 32. TOP DEPARTMENT FOR EACH INSURANCE TYPE
-- ============================================================

WITH department_insurance AS (
    SELECT
        insurance_type,
        department,
        SUM(revenue) AS revenue
    FROM healthcare_clean
    GROUP BY insurance_type, department
),
ranked AS (
    SELECT
        insurance_type,
        department,
        revenue,
        RANK() OVER (
            PARTITION BY insurance_type
            ORDER BY revenue DESC
        ) AS rnk
    FROM department_insurance
)
SELECT
    insurance_type,
    department,
    ROUND(revenue, 2) AS revenue,
    rnk
FROM ranked
WHERE rnk = 1
ORDER BY insurance_type;


-- ============================================================
-- 33. FINAL DEPARTMENT BUSINESS SUMMARY
-- ============================================================

SELECT
    department,
    COUNT(*) AS patients,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(treatment_cost), 2) AS treatment_cost,
    ROUND(SUM(revenue - treatment_cost), 2) AS profit,
    ROUND(
        100 * SUM(revenue - treatment_cost)
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost,
    ROUND(AVG(age), 2) AS avg_patient_age,
    ROUND(
        AVG(DATEDIFF(discharge_date, admission_date)),
        2
    ) AS avg_length_of_stay
FROM healthcare_clean
GROUP BY department
ORDER BY profit DESC;


-- ============================================================
-- END OF PROJECT ANALYSIS
-- ============================================================
