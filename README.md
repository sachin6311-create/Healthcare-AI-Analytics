# 🏥 Healthcare AI Analytics

An end-to-end healthcare data analytics project built using Azure Data Factory, Azure MySQL, SQL, and Power BI.

## 📌 Project Overview

This project demonstrates a complete data analytics pipeline starting from raw healthcare data through data cleaning, transformation, validation, database storage, SQL analysis, and interactive Power BI dashboards.

The project focuses on healthcare operations, patient demographics, revenue, treatment costs, payment status, insurance, and department performance.

---

## 🏗️ Project Architecture


Raw Healthcare Data
        ↓
Azure Data Factory
        ↓
Data Cleaning & Transformation
        ↓
Data Quality Validation
        ↓
   ┌───────────────┐
   ↓               ↓
Clean Data     Rejected Data
   ↓               ↓
Azure MySQL Database
        ↓
    SQL Analysis
        ↓
      Power BI
        ↓
Healthcare Business Insights


🛠️ Tools & Technologies
Azure Data Factory
Azure MySQL
MySQL
SQL
Power BI
Power Query
DAX
GitHub
🔄 ETL Process


1. Data Extraction
Healthcare data was collected from the source CSV dataset and loaded into the Azure data pipeline.


2. Data Cleaning
The ETL pipeline handled data quality issues including:

Missing values
Invalid records
Data type validation
Data transformation
Record validation


3. Data Validation
Records were separated into:

Cleaned/accepted records
Rejected records


4. Data Storage
Validated healthcare data was stored in Azure MySQL for further analysis.


5. SQL Analysis
SQL was used to perform:

Patient analysis
Revenue analysis
Department analysis
Treatment cost analysis
Payment analysis
Insurance analysis
Doctor performance analysis
Ranking and aggregation
Data quality analysis


## 📊 Power BI Dashboard

### Dashboard Preview

#### Healthcare Analytics Overview
![Healthcare Analytics Overview](06_Dashboard_Screenshots/Healthcare%20Analytics%20overview.png)

#### Patients Analysis
![Patients Analysis](06_Dashboard_Screenshots/Patients%20Analysis.png)

#### Financial Analytics
![Financial Analytics](06_Dashboard_Screenshots/Financial%20Analytics.png)

#### Department Performance
![Department Performance](06_Dashboard_Screenshots/Department%20Performance.png)

#### Operations & Admissions
![Operations & Admissions](06_Dashboard_Screenshots/Operations%20and%20Admissions.png)

#### Payment & Admissions
![Payment & Admissions](06_Dashboard_Screenshots/Payment%20and%20Admissions.png)

#### ETL & Data Quality
![ETL & Data Quality](06_Dashboard_Screenshots/ETL%20AND%20DATA%20QUALITY.png)


💡 Business Insights

The dashboard can help healthcare management understand:

Patient volume by department
Revenue-generating departments
Treatment cost patterns
Payment collection status
Insurance contribution
Doctor revenue performance
Common diagnoses
Admission patterns
Data quality and rejected records


🎯 Business Decisions Supported
Healthcare management can use the analysis to:

Identify high-performing departments
Monitor treatment costs
Improve payment collection
Understand insurance contribution
Optimize staffing based on patient volume
Identify frequently occurring diagnoses
Monitor doctor-level revenue
Improve data quality in future ETL cycles


📂 Repository Structure
healthcare-ai-analytics/
│
├── README.md
│
├── 02_Azure_Data_Factory/
│
├── 03_Azure_MySQL/
│
├── 04_SQL/
│   └── Healthcare_Project_Analysis.sql
│
├── 05_PowerBI/
│
├── 06_Dashboard_Screenshots/
│
└── 07_Documentation/


🚀 Future Improvements
Future versions of the project can include:

Automated data refresh
Real-time healthcare monitoring
Predictive patient analytics
Patient readmission prediction
Treatment cost forecasting
Advanced anomaly detection
Automated data-quality alerts
Cloud-based Power BI deployment

👨‍💻 Author
Sachin Kumar

Data Analytics | SQL | Power BI | Azure | ETL
