# NYC 311 Modeling Plan

**Date created:** 2026-04-01

## Business question
The mayor's office wants to know whether certain types of 311 complaints are likely to be resolved within 3 days — can we build a model to flag fast vs. slow resolutions at intake?

## Data source
- **S3 path:** s3://cmse492-huntbrendan-nyc311-767397988837-us-east-1-an/modeling/modeling_data.csv
- **Records:** 173,870
- **Athena query:** sql/athena_to_modeling.sql

## Features
- **agency** (string): The department responding to the request.
- **borough** (string): The NYC borough where the incident occurred.
- **day_of_week** (numeric): Day of the week (1-7) extracted from created_date.
- **hour_of_day** (numeric): Hour of the day (0-23) extracted from created_date.
- **problem_category** (string): Aggregated complaint types (housing, noise, traffic, sanitation, other).
- **incident_zip** (numeric/categorical): ZIP code of the incident.

## Target
- **Name:** resolved_quickly
- **Type:** Binary Classification (1 = Resolved $\le$ 3 days, 0 = Resolved > 3 days)
- **Balance/Distribution:** * **1 (Quick):** 84.06%
    * **0 (Slow):** 15.94%
    * *Note: The data is imbalanced; the majority of cases are resolved within the 3-day window.*

## Modeling approach
- **Baseline:** Logistic Regression. This is chosen for its high interpretability, allowing us to see which agencies or problem types are most likely to result in "slow" resolutions.
- **Metrics:** F1-Score (for the '0' class), Precision, Recall, and Confusion Matrix.
- **Train/test split:** 80/20 with **stratification** on `resolved_quickly`.

## Data quality notes
- **Imbalance:** 84/16 split means accuracy will be a misleading metric; focus will be on the minority class (slow resolutions).
- **Missing Values:** `incident_zip` has 1,768 missing values. These will be handled via imputation or by dropping rows during preprocessing.
- **Encoding:** Categorical features (agency, borough, problem_category) will require One-Hot Encoding.

<<<<<<< HEAD
## Next steps
- Perform a stratified train/test split.
- Build a preprocessing pipeline.
- Fit the baseline Logistic Regression model.
- Evaluate the model
=======

## Baseline Model Results

- **Model:** Logistic Regression
- **Features used:** Encoded categorical and numeric features from the training set
- **Target:** Your binary target column
- **Train/test split:** 80/20, `random_state=42`, stratified

### Metrics
- Accuracy: 0.880
- Precision: 0.903
- Recall: 0.961

### Interpretation

The baseline model performs well overall and captures most positive cases, which is reflected in the strong recall score. Precision is also high, so when the model predicts the positive class it is usually correct. Because the classes are imbalanced, accuracy alone may make the model look stronger than it really is.

### Limitation

The target is imbalanced, so the model may be relying too heavily on the majority class and may not generalize well to the minority class.
>>>>>>> 204385227312a0bc160b581c2752c8385fad5809

## Comparison with SageMaker models

- **SageMaker Notebook:** Linear Learner (Built-in Algorithm)
- **Task Type:** Binary Classification (predicting `resolved_quickly`)
- **Key Metrics:** - **Accuracy:** 0.848
    - **Recall (Class 0 - Slow):** 0.10
    - **F1-Score (Class 0 - Slow):** 0.18
- **Comparison to sklearn:** The SageMaker Linear Learner performed slightly worse in accuracy than the baseline `sklearn` Logistic Regression (85% vs 88%) and demonstrated a severe struggle with the imbalanced nature of the data, failing to identify 90% of the "slow" resolution cases.
- **Workflow Assessment:** The SageMaker workflow does not seem worth it for a dataset of this size (~174k records) due to the significant infrastructure overhead and provisioning wait times; however, it would be the preferred route if the project scaled to millions of rows or required integration into an automated AWS production pipeline.