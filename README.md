# NYC 311 Service Request Analysis Project

## Data Source and Provenance
- **Source**: [NYC Open Data 311 Service Requests](https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2020-to-Present/erm2-nwe9/)
- **Time period**: Jan 29–Mar 21, 2026 (Q1 2026)
- **Prep**: Instructor-generated random sample of 200k complaints from 15 agencies
- **Files**: 
  - `raw/complaints.csv` (200k rows, main requests table)
  - `raw/agencies.csv` (unique agencies lookup table)
- **S3 paths** (fill after upload):
  - `s3://cmse492-huntbrendan-nyc311-767397988837-us-east-1-an/raw/complaints.csv`
  - `s3://cmse492-huntbrendan-nyc311-767397988837-us-east-1-an/raw/agencies.csv`

## Project Structure
```text
aws-nyc311-181211067/         
├── README.md                 # Data source, S3 paths, assumptions
├── DATA_DICTIONARY.md        # Column details
├── sql/                      # Athena queries (Warm-ups, Stakeholder, Modeling Prep)
├── notebooks/                # Jupyter Notebooks (Load Verify, Training, SageMaker)
├── notes/                    # Modeling plan, Sanity checks
└── reports/                  # Confusion matrix and analysis outputs
```
## Data Summary
See DATA_DICTIONARY.md for full schema.

Key relationships: Join complaints.agency = agencies.agency

Stakeholder Question:
- Predict whether a 311 complaint will be resolved within 3 days — specifically to flag fast vs. slow resolutions at intake.

## Assumptions and Known Issues
- Unresolved Requests: Empty closed_date fields indicate open/unresolved requests; these must be filtered before calculating resolution times.
- Missing Geography: The incident_zip column contained 1,768 missing values (imputed as "unknown" during modeling).
- Data Types: All dates are stored as strings and require DATE_PARSE(created_date, '%Y-%m-%d %H:%M:%S') for SQL analysis.
- Class Imbalance: The target variable resolved_quickly is highly imbalanced, with roughly 84% of cases resolved within 3 days and only 16% taking longer.
