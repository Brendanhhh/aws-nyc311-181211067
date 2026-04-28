# NYC 311 Service Request Analysis Project

## Data Source and Provenance
* **Source:** NYC Open Data 311 Service Requests.
* **Time Period:** Jan 29 – Mar 21, 2026 (Q1 2026).
* **Prep:** Instructor-generated random sample of 200k complaints from 15 agencies.
* **S3 Path:** s3://cmse492-huntbrendan-nyc311-767397988837-us-east-1-an/raw/.

## Project Structure
* sql/: Athena DDL and transformation queries.
* notebooks/: Data loading, verification, and modeling notebooks.
* notes/: Documentation including the modeling plan and sanity-check logs.
* reports/: Evaluation visualizations such as the confusion matrix.

## Stakeholder Question
The NYC Mayor’s Office wants to identify whether certain types of 311 complaints are likely to be resolved within 3 days. This model flags "fast" vs. "slow" resolutions at intake to help departments manage resources effectively.

## Key Findings & Performance
* **Baseline Model:** Logistic Regression.
* **Accuracy:** 0.853.
* **Critical Limitation:** The model has low recall (0.061) for slow resolutions due to a significant class imbalance (84/16 split). It is currently biased toward predicting the majority class.

## Assumptions and Known Issues
* **Unresolved Requests:** Empty closed_date values are treated as open/unresolved.
* **Class Imbalance:** Accuracy is a misleading metric here because the model can achieve ~85% accuracy just by predicting "fast" every time.


## Key Findings & Performance
* **Baseline Model:** Logistic Regression.
* **Accuracy:** 0.853
* **Critical Limitation:** The model has low recall (0.061) for slow resolutions due to a significant class imbalance (84/16 split). It is currently biased toward predicting the majority class.

## Assumptions and Known Issues
* **Unresolved Requests:** Empty closed_date values are treated as open/unresolved.
* **Class Imbalance:** Accuracy is a misleading metric here because the model can achieve ~85% accuracy just by predicting "fast" every time.

## Key Findings & Performance
* **Baseline Model:** Logistic Regression.
* **Accuracy:** 0.853.
* **Critical Limitation:** While accuracy is high, the model has low recall (0.061) for slow resolutions due to the 84/16 class imbalance. It is currently biased toward predicting "fast" resolutions.

## Assumptions and Known Issues
* **Empty `closed_date`:** These are treated as open/unresolved requests.
* **Class Imbalance:** The target distribution is skewed, making accuracy a misleading metric.
* **Weather Data:** Please note that project-related weather data was sourced from Excel tabs rather than an external API.
