# CustomerBehaviorAnalysis-SAS
## Forecasting customers' credit defaults based on historical data

### Project Objective
The aim of this project was to identify and analyze predictors capable of forecasting customers' credit defaults based on historical data. A key element involved analyzing the impact of various predictors on the target variable, default_cus12, which indicates whether a client defaults after 12 months.

## Statistical Methods
Data Missingness Analysis
An analysis of data missingness was conducted to understand data stability over time and improve data quality by:

Removing observations with missing values in the key target variable.
Cleaning data, marking missing data, and deriving distinct periods and customer default statuses.
Outlier Analysis
Outlying observations were examined to eliminate errors and anomalies in the data, using quartile methods to identify outliers.

## Exploratory Data Analysis (EDA) Techniques
**Frequency Analysis:** Used to get an overview of the distribution of categorical data, which aids in understanding the diversity and prevalence of categorical features.
**Univariate Analysis**: Histograms and summary statistics (mean, standard deviation) were employed to understand the distribution of continuous variables and to check for normality.
**Descriptive Statistics**: Insights into central tendencies and variability were provided, which are crucial for understanding baseline characteristics of the data and for modeling assumptions in predictive analytics.
#### Statistical Tests
Kolmogorov-Smirnov Test: Used to assess the consistency of distributions, which is important for verifying data homogeneity across datasets.
## Predictor Analysis
Gini Coefficient and V-Cramer's Coefficient: Applied to evaluate the strength of the relationship between individual variables and the target variable, crucial for building an effective predictive model.
Dependent Variable
The dependent variable, default_cus12, is a categorical/binary (qualitative) variable that indicates whether a client defaults on financial obligations after 12 months. This classification is essential in credit risk modeling.

Application of the Gini Coefficient
The Gini coefficient was used to assess the discriminatory power of predictors within the context of credit risk modeling:

## Model Evaluation
Single-Variable Logistic Regression Models: Each model used one predictor at a time with default_cus12 as the dependent variable to evaluate performance.
## Predictive Power Assessment
Coefficient Range: Values ranged from 0 to 1, where a higher Gini coefficient indicates a stronger ability to differentiate between the outcomes (default or no default).
Threshold Determination
## Cutoff Point: Established at a Gini coefficient of 0.4 to select the best predictors from the dataset for further analysis.
### Comparative Analysis Ranking Predictors: 
The Gini coefficient was calculated for different predictors to rank and prioritize variables based on their effectiveness in predicting customer defaults.
Importance of Gini Coefficient in Credit Risk Modeling
Model Quality: Indicates the model's ability to correctly classify individuals into default or no default categories.
Decision Making: Financial institutions use these insights to make informed credit granting decisions, reducing the risk of defaults.


The findings from the project based on V-Cramer's coefficient were specifically aimed at assessing the strength of the relationship between textual (categorical) variables and the target variable default_cus12. Here’s a summary of the findings derived from using V-Cramer's coefficient:

### Strength of Association:

V-Cramer's coefficient was used to measure the association strength between various categorical variables and the likelihood of default (default_cus12). This included variables such as employment type, marital status, and residential status among others.
Selection of Predictive Variables:

Variables that exhibited higher V-Cramer's coefficients were considered strong predictors and were thus prioritized for inclusion in the predictive modeling. This approach helped in refining the model by focusing on variables that have a more substantial impact on the prediction of default.
Enhanced Model Accuracy:

By identifying and including variables with significant V-Cramer's coefficients, the project aimed to enhance the accuracy of the predictive models. This is because these variables have a demonstrated strong relationship with the outcome, making them valuable for improving model performance.
Decision-Making Insights:

The analysis provided insights into which customer characteristics are most predictive of default, aiding in decision-making processes related to credit risk management. For instance, if a variable like marital status showed a high V-Cramer's coefficient, it indicated a significant impact on default likelihood, which could influence credit policies and risk assessments.
The use of V-Cramer's coefficient thus played a crucial role in identifying and validating the importance of various categorical variables in the context of credit default risk, leading to more focused and effective predictive analytics
