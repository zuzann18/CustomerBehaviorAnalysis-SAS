# CustomerBehaviorAnalysis-SAS
Project Objective
The aim of the project was to identify and analyze predictors capable of forecasting customers' credit defaults based on historical data. A key element was the analysis of variables and their impact on the target variable, which indicates default after 12 months (default_cus12).

Statistical Methods
Data Missingness Analysis: An analysis of data missingness was conducted, which helped understand data stability over time and improve data quality by removing observations with missing values in the key target variable. The preprocessing included data cleaning, particularly marking missing data and deriving distinct periods and customer default statuses
Outlier Analysis: Outlying observations were examined, allowing for the elimination of errors and anomalies in the data. Quartile methods were used to identify outliers.
Several statistical techniques were employed during the Exploratory Data Analysis (EDA) phase:

Frequency Analysis: Used to get an overview of categorical data distribution which helps in understanding the diversity and prevalence of categorical features.
Univariate Analysis: Employed histograms and summary statistics (mean, standard deviation) to understand the distribution of continuous variables and to check for normality. This is useful for identifying outliers and understanding the central tendencies of the data, which are crucial for modeling assumptions in predictive analytics.
Descriptive Statistics: Provided insights into central tendencies and variability which helps in understanding the baseline characteristics of the data.
Statistical Tests: The Kolmogorov-Smirnov test was used to assess the consistency of distributions, important for verifying data homogeneity across datasets.
Predictor Analysis: Gini coefficient and V-Cramer’s coefficient were applied to evaluate the strength of the relationship between individual variables and the target variable, crucial for building an effective predictive model.
Dependent Variable
The dependent variable (default_cus12) is a categorical/binary (qualitative) variable indicating whether a client defaults on financial obligations after 12 months. This allows for the classification of clients who may become insolvent, which is important in credit risk modeling.

Results and Conclusions
The project provided an in-depth analysis of data that can be used to predict credit risk. The stability of selected variables between datasets and their strong association with the target variable formed the basis for further modeling and implementation of risk management strategies.
