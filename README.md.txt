# Healthcare AI Analytics

## Project Overview

An end-to-end healthcare analytics project built using Azure Data
Factory, Azure MySQL, SQL and Power BI.

The project demonstrates the complete data analytics workflow:

Raw Healthcare CSV
        ↓
Azure Blob Storage
        ↓
Azure Data Factory
        ↓
Data Cleaning & Transformation
        ↓
Data Validation
        ↓
Clean / Rejected Data
        ↓
Azure MySQL
        ↓
Power BI
        ↓
Healthcare Business Analytics

---

## Business Objective

The objective of this project is to analyze healthcare operations,
patient activity, revenue, treatment costs, departments, admissions,
payments, insurance and machine utilization.

The project also monitors ETL data quality by separating valid and
rejected records during the Azure Data Factory pipeline.

---

## Technology Stack

- Azure Blob Storage
- Azure Data Factory
- Azure MySQL
- MySQL
- Power BI
- Power Query
- DAX
- GitHub

---

## Azure Data Engineering

Azure Data Factory was used to:

- Extract healthcare data
- Clean and transform records
- Convert and validate data types
- Handle data-quality issues
- Separate valid and rejected records
- Load processed data into Azure MySQL

Rejected records were stored separately for further investigation.

---

## Azure MySQL

The processed healthcare data was stored in Azure MySQL.

Main tables:

- healthcare_clean
- healthcare_rejected

Azure MySQL was then used as the analytical data source for Power BI.

---

## SQL Analysis

SQL analysis includes:

- Executive KPI analysis
- Revenue analysis
- Department performance
- Department profitability
- Patient demographics
- Diagnosis analysis
- Admission analysis
- Payment analysis
- Insurance analysis
- Doctor performance
- Machine utilization
- Treatment-cost analysis
- Length-of-stay analysis
- Data-quality analysis
- Duplicate detection
- CTEs
- Window functions
- Ranking analysis

---

## Power BI Dashboard

The Power BI report contains:

1. Executive Overview
2. Patients Analysis
3. Revenue & Financial Analytics
4. Department Performance
5. Operations & Admissions Analytics
6. Payment & Insurance
7. ETL & Data Quality Analytics

Interactive features include:

- KPI cards
- Filters
- Bookmarks
- Drillthrough
- Tooltips
- Page navigation
- Interactive charts

---

## Dashboard Preview

### Executive Overview

![Executive Overview](06_Dashboard_Screenshots/01_Executive_Overview.png)

### Patients Analysis

![Patients Analysis](06_Dashboard_Screenshots/02_Patients_Analysis.png)

### Revenue & Financial Analytics

![Revenue Analytics](06_Dashboard_Screenshots/03_Revenue_Financial.png)

### Department Performance

![Department Performance](06_Dashboard_Screenshots/04_Department_Performance.png)

### Operations & Admissions

![Operations](06_Dashboard_Screenshots/05_Operations_Admissions.png)

### Payment & Insurance

![Payment & Insurance](06_Dashboard_Screenshots/06_Payment_Insurance.png)

### ETL & Data Quality

![ETL Data Quality](06_Dashboard_Screenshots/07_ETL_Data_Quality.png)

---

## Key Business Questions

- Which departments generate the highest revenue?
- Which departments have the highest profitability?
- How does revenue change over time?
- Which diagnoses have the highest patient volume?
- Which admission types generate the most revenue?
- How much revenue is pending?
- Which insurance types contribute the most revenue?
- Which doctors generate the highest revenue?
- Which machines have the highest utilization?
- What is the average length of stay?
- What are the major data-quality issues?

---

## Business Value

The dashboard helps management identify:

- High-performing departments
- Revenue opportunities
- Treatment-cost patterns
- Pending payment opportunities
- Insurance performance
- Operational bottlenecks
- Machine utilization
- Patient trends
- Data-quality issues

---

## Future Improvements

- Revenue forecasting
- Patient demand forecasting
- Insurance claim analysis
- Payment aging analysis
- Automated data-quality alerts
- Predictive patient analytics
- Machine maintenance prediction

---

## Project Architecture

Raw CSV → Azure Blob Storage → Azure Data Factory →
Azure MySQL → SQL Analysis → Power BI

---

## Author

Sachin